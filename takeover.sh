#!/bin/bash

#Get wildcarded bounty data
cd ~/takeover;
git clone https://github.com/arkadiyt/bounty-targets-data;
cp ~/takeover/bounty-targets-data/data/wildcards.txt ./;
cat wildcards.txt | sed 's/^*.//g' | grep -v '*' > root_domains.txt;
rm -rf bounty-targets-data/;
rm -f wildcards.txt;
ulimit -n 7000;


#Find Subdomains
while read host;
    do file=subdomains.txt;
    ~/go/bin/subfinder -o $file -d $host;
    ~/go/bin/assetfinder --subs-only $host | tee -a $file;
    cat $file | sort -u | tee -a subs.txt;
done < ./root_domains.txt;


#Check for dangling CNAME Records
~/go/bin/subjack -w subs.txt -t 250 -timeout 20 -v -c ~/go/src/github.com/haccer/subjack/fingerprints.json -a -ssl -o results.txt;
cat results.txt | grep -v "Not Vulnerable" > takeover.txt;


#Send data to discord webhook
cat takeover.txt | grep -i 'Fastly' > tmp.txt
go run ~/go/src/github.com/caesarsec/discordmessage/discordmessage.go '```'"$(< ./tmp.txt)"'```'

cat takeover.txt | grep -i 'Azure' > tmp.txt
go run ~/go/src/github.com/caesarsec/discordmessage/discordmessage.go '```'"$(< ./tmp.txt)"'```'

cat takeover.txt | grep -i 'Github' > tmp.txt
go run ~/go/src/github.com/caesarsec/discordmessage/discordmessage.go '```'"$(< ./tmp.txt)"'```'

cat takeover.txt | grep -i 'S3 BUCKET' > tmp.txt
go run ~/go/src/github.com/caesarsec/discordmessage/discordmessage.go '```'"$(< ./tmp.txt)"'```'

cat takeover.txt | grep -i 'Heroku' > tmp.txt
go run ~/go/src/github.com/caesarsec/discordmessage/discordmessage.go '```'"$(< ./tmp.txt)"'```'

cat takeover.txt | grep -i 'DOMAIN AVAILABLE' > tmp.txt
go run ~/go/src/github.com/caesarsec/discordmessage/discordmessage.go '```'"$(< ./tmp.txt)"'```'


#Clean up
cp takeover.txt ../backups/"takeover-`date +"%d-%m-%Y"`.txt"
echo "Done" - `date +"%d-%m-%Y-%H-%M"` >> finished.txt
rm root_domains.txt;
rm results.txt;
rm subs.txt;
rm subdomains.txt;
