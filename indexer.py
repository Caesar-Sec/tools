#!/usr/bin/python3

# ToDo
## take a list of domains
## request the index page of each domain
## use findall to gather all variables in that index page
### Optionally use the findall to gahter all comments on the page

import requests
import re

URL = "https://www.hackerone.com"

r = requests.get(URL)

comments = re.findall(r"\<\!.+\>", r)
print(comments)