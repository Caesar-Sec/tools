#!/usr/bin/python3

import sys
import requests
import re

# request all index pages from wayback machine
# Gather all id and name attributes from any input tags
# grab any comments
# links to js files

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('Usage: /npython3 waybackindexer.py <domain-name>')
        sys.exit()
    host = sys.argv[1]

# send get request
r = requests.get('https://web.archive.org/cdx/search/cdx\
        ?url=%s&output=json&fl=timestamp,original&\
        filter=statuscode:200&collapse=digest' % host)

results = r.json()
if len(results) == 0:
    pass
print(results)
