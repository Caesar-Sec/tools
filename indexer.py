#!/usr/bin/python3

import sys
import requests
from bs4 import BeautifulSoup as bs
from bs4 import Comment


# Take input of a url
if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('Usage: \npython3 indexer.py <domains-name>')
        sys.exit()
    url = sys.argv[1]


# Create a sturcture for storing the attribute names and comments
input_attributes = set()
comments = set()


r = requests.get(url)
soup = bs(r.text, "html.parser")

# Gather all attributes from input tags with id or name
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



# Gather any comments from the page
soup2 = bs(r.text, 'html.parser')
comment = soup2.find_all(string=lambda text: isinstance(text, Comment))
for i in comment:
    comments.add(i)
    

# Open File Handler and write findings to an output file
f_hand = open('indexer_output.txt', 'w')
f_hand.write("Input tag Attributes\n")
f_hand.write("------------------------------------------\n")
for i in input_attributes:
    f_hand.write(i + '\n')

f_hand.write("\n\nHTML Comments\n")
f_hand.write("------------------------------------------\n")
for c in comments:
    f_hand.write("New Comment Section:\n")
    f_hand.write(c + '\n\n\n')

f_hand.close()
