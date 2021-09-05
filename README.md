# Tools

This is a repo of some random tools that I made or use. Most of these scripts are somewhat hacked together just to get a job done.

If at a later time I want to expand on a certain tool it will get its own repo and be built out from there.


### Tools

Indexer.py - given a url it will grab any HTML comments and any HTML attributes that are included in the input tags on the page. Only handles 1 url at a time, for multiple urls I will use a for loop in bash.

WaybackIndexer.py - similar to Indexer.py, it will gather any input attributes from all snapshots that the given url from the wayback machine.

Redirect.php - This was a small tool from Zseano for testing redirections to webpages. The file should be hosted on an appropriate stack (I tend to use XAMPP), then using Burp intruder request to the php file with your list of subdomains as the url parameter. For the full description take a look here: https://zseano.medium.com/using-xampp-and-burp-intruder-when-scanning-for-subdomains-to-look-for-interesting-behaviour-code-f24c511d15ed

