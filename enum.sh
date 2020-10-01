#!/bin/bash

#Get wildcarded bounty data
cd ~/tools/tmp;
ulimit -n 7000;

#Find Subdomains
while read host;
    do file=subdomains.txt;
    ~/go/bin/subfinder -config ~/.config/subfinder/config.yaml -o $file -d $host;
    ~/go/bin/amass enum -passive -d $host -o $file;
    ~/go/bin/assetfinder --subs-only $host | tee -a $file;
    cat $file | sort -u | tee -a subs1.txt;
done < ./domains.txt;

#Cleanup
cp subs1.txt subs.txt;
rm subdomains.txt;
rm subs1.txt;
