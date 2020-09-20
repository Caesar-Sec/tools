#!/bin/bash

#Get wildcarded bounty data
cd ~/tools/tmp;
git clone https://github.com/arkadiyt/bounty-targets-data;
cp ./bounty-targets-data/data/wildcards.txt ./;
cat wildcards.txt | sed 's/^*.//g' | grep -v '*' > root_domains.txt;
rm -rf bounty-targets-data/;
rm -f wildcards.txt;
ulimit -n 7000;


#Find Subdomains
while read host;
    do file=subdomains.txt;
    ~/go/bin/subfinder -o $file -d $host;
    ~/go/bin/assetfinder --subs-only $host | tee -a $file;
    cat $file | sort -u | tee -a subs1.txt;
done < ./root_domains.txt;

#Cleanup
cp subs1.txt subs.txt;
rm subdomains.txt;
rm subs1.txt;
rm root_domains.txt;
