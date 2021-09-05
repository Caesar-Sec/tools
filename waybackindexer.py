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
    print("Staring New Page")
    url = 'https://web.archive.org/web/{0}/{1}'.format(snapshot[0], snapshot[1]) 
    indexPage = requests.get(url).text
    soup = bs(indexPage, "html.parser")

    # get input data
    input_tags = soup.find_all('input')
    for i in input_tags:
        try:
            input_attributes.add(i['id'])
        except:
            pass
        try:
            input_attributes.add(i['name'])
        except:
            pass

    # get js data
    js_paths = soup.find_all('script')
    for i in js_paths:
        # add an if to check if the url is relative or absolute and append the host
        try:
            js_attributes.add(i['src'])
        except:
            pass
    return
        


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('Usage: \npython3 waybackindexer.py <domain-name>')
        sys.exit()
    
    host = sys.argv[1]

    snapshots = indexes(host)
    if len(snapshots) == 0:
        print("No Results Found")
        sys.exit()
    pool = Pool(4)
    
    # get all input unique attributes
    print("Staring Execution")
    input_attributes = list()
    js_attributes = list()
    pool.map(get_data, snapshots[1:5])
    uniqueAttributes = set()
    for i in input_attributes:
        uniqueAttributes.update(i)

    # Write to output files
    print(type(uniqueAttributes))
    print(type(js_attributes))
    print(uniqueAttributes)
    print(js_attributes)
    # f_hand = open('waybackindexer.txt', 'w')
    # for i in uniqueAttributes:
    #     f_hand.write(i + '\n')
    # f_hand.write('\n\n\n')
    # for c in js_attributes:
    #     f_hand.write(c + '\n')
    # f_hand.close()

