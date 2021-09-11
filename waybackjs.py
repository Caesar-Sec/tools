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
    js_paths = soup.find_all('script')
    for i in js_paths:
        # add an if to check if the url is relative or absolute and append the host
        try:
            append_js(JS_ATTRIBUTES, i)
        except:
            pass
    return

def append_js(js_list, value):
    js_list.append(value['src'])
    return js_list

def cli_output(endpoints):
    for endpoint in endpoints:
        print(endpoint)

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: \n\t python3 waybackjs.py <domain-name>")
        sys.exit()

    host = sys.argv[1]
    if 'http' not in host:
        host = 'https://' + host

    snapshots = indexes(host)
    if len(snapshots) == 0:
        print("No Results Found")
        sys.exit()
    pool = Pool(4)


    JS_ATTRIBUTES = list()
    pool.map(get_data, snapshots)

    uniqueJS = set()
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

    cli_output(uniqueJS)
