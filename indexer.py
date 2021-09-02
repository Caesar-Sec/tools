#!/usr/bin/python3

# ToDo
## take a list of domains
## request the index page of each domain
## use findall to gather all variables in that index page
### Optionally use the findall to gahter all comments on the page

import requests
import re
from bs4 import BeautifulSoup as bs

URL = "https://www.hackerone.com"
COMMENTS = list()
INPUTS = list()

# def get_index(URL):
#     webpage = requests.get(URL)
#     soup = bs(webpage.text, "html.parser")
#     return soup.text


# def get_input_tags(page):
#     for input_tags in page.find_all('input'):
#         INPUTS.append(input_tags)
#     return    


# def get_comment_tags(page):
#     for comment_tags in page.find_all(''):
#         COMMENTS.append(comment_tags)
#     return


# Create a sturcture for storing the attribute names
input_attributes = set()


r = requests.get(URL)
soup = bs(r.text, "html.parser")

input_tags = soup.find_all('input')
for i in input_tags:
    try:
        input_attributes.add(i['id'])
    except:
        print("No ID found in tag")

    try:
        input_attributes.add(i['name'])
    except:
        print("No ID found in tag")

print(input_attributes)

########
### POC CODE
########

# req = requests.get(URL)
# soupp = bs(req.text, "html.parser")

# comments = list()
# inputs = list()

# tags = soupp.find_all('input')
# print(tags)

# for input_tags in tags:
#     print("Searching")
#     try:
#         print(input_tags['id'])
#     except:
#         print("No ID attribute found")