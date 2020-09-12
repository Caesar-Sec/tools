#!/bin/bash

cd ~/takeover;
git clone https://github.com/arkadiyt/bounty-targets-data;
cp ~/takeover/bounty-targets-data/data/wildcards.txt ./;
cat wildcards.txt | sed 's/^*.//g' | grep -v '*' > root_domains.txt;
rm -r bounty-targets-data/;
rm wildcards.txt;


while read host;
    do file=subdomains.txt;
    ~/go/bin/subfinder -o $file -d $host;
    ~/go/bin/assetfinder --subs-only $host | tee -a $file;
    cat $file | sort -u | tee -a subs.txt;
done < ./root_domains.txt;

~/go/bin/subjack -w subs.txt -t 100 -timeout 20 -v -c ~/go/src/github.com/haccer/subjack/fingerprints.json -o results.txt
cat results.txt | grep -v "Not Vulnerable" > takeover.txt;
rm root_domains.txt;
rm results.txt;

go run ~/go/src/github.com/caesarsec/discordmessage/discordmessage.go "$(< ./takeover.txt)"

rm takeover.txt
