#!/usr/bin/python3

import sys
import requests
from multiprocessing.dummy import Pool
from bs4 import BeautifulSoup as bs

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

    # get js data
    input_tags = soup.find_all('input')
    for i in input_tags:
        try:
            append_input(INPUT_ATTRIBUTES, i)
        except:
            pass
    return

def append_input(input_list, value):
    input_list.append(value['id'])
    input_list.append(value['name'])
    return input_list

def cli_output(endpoints):
    for endpoint in endpoints:
        print(endpoint)
        

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: \n\t python3 waybackinput.py <domain-name>")
        sys.exit()

    host = sys.argv[1]
    if 'http' not in host:
        host = 'https://' + host

    snapshots = indexes(host)
    if len(snapshots) == 0:
        print("No Results Found")
        sys.exit()
    pool = Pool(4)


    INPUT_ATTRIBUTES = list()
    pool.map(get_data, snapshots)

    uniqueinput = set()
    for c in INPUT_ATTRIBUTES:
        if "archive.org" in c:
            pass
        elif c[0:4] != "http" or c[0:4] != "HTTP":
            if c[0:5] == "/web/":
                x = c.find("http")
                result = c[x:]
                uniqueinput.add(result)
            elif "http" not in c:
                new_c = host + c
                uniqueinput.add(new_c)
        else:
            uniqueinput.add(c)

    cli_output(uniqueinput)
