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


r = requests.get(URL)
soup = bs(r.text, "html.parser")
pattern = "(\<input.+\>)"

comments = list()
inputs = list()

for input_tags in soup.find_all('input'):
    # Strip out the parameters
    for value in input_tags:
        get_val = value.get('id')
        print(get_val)
    # for parameter in input_tags:
    #     print(parameter)
    
    
    # inputs.append(input_tags)
    # print(input_tags)



# comments = re.findall(pattern, soup.text)
# print(soup)