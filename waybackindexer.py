#!/usr/bin/python3

import sys
import requests
import re
from multiprocessing.dummy import Pool
from bs4 import BeautifulSoup as bs

# request all index pages from wayback machine
# Gather all id and name attributes from any input tags
# grab any comments
# links to js files
def indexes(host):
    r = requests.get('https://web.archive.org/cdx/search/cdx\
        ?url=%s&output=json&fl=timestamp,original&\
        filter=statuscode:200&collapse=digest' % host)
    results = r.json()
    if len(results) == 0:
        return []
    results.pop(0)  # remove the first item ['timestamp', 'original']
    return results


def get_data(snapshot):
    url = 'https://web.archive.org/web/{0}/{1}'.format(snapshot[0], snapshot[1]) 
    indexPage = requests.get(url).text
    soup = bs(indexPage, "html.parser")

    # get input data
    input_tags = soup.find_all('input')
    for i in input_tags:
        try:
            append_input(INPUT_ATTRIBUTES, i)
        except:
            pass

    # get js data
    js_paths = soup.find_all('script')
    for i in js_paths:
        # add an if to check if the url is relative or absolute and append the host
        try:
            append_js(JS_ATTRIBUTES, i)
        except:
            pass
    return
        

def append_input(input_list, value):
    input_list.append(value['id'])
    input_list.append(value['name'])
    return input_list


def append_js(js_list, value):
    js_list.append(value['src'])
    return js_list


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('Usage: \npython3 waybackindexer.py <domain-name>')
        sys.exit()

    host = sys.argv[1]
    if "http" not in host:
        host = 'https://' + host


    snapshots = indexes(host)
    if len(snapshots) == 0:
        print("No Results Found")
        sys.exit()
    pool = Pool(4)
    
    # get all input unique attributes
    print("Staring Execution")
    INPUT_ATTRIBUTES = list()
    JS_ATTRIBUTES = list()
    pool.map(get_data, snapshots[1:20])

    # move data into a set from the list
    uniqueAttributes = set()
    uniqueJS = set()

    for i in INPUT_ATTRIBUTES:
        uniqueAttributes.add(i)

    for c in JS_ATTRIBUTES:
        if "archive.org" in c:
            pass
        elif c[0:4] != "http" or c[0:4] != "HTTP":
            if c[0:5] == "/web/":
                x = c.find("http")
                result = c[x:]
                uniqueJS.add(result)
            elif "http" not in c:
                new_c = host + c
                uniqueJS.add(new_c)
        else:
            uniqueJS.add(c)


    filename = "waybackindexer.txt"
    with open(filename, 'w') as f_hand:
        f_hand.write('\n'.join(uniqueAttributes))
        f_hand.write('\n\n')
        f_hand.write('\n'.join(uniqueJS))
