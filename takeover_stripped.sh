#!/bin/bash

cd ~/tools/tmp
ulimit -n 7000;

#Check for dangling CNAME Records
~/go/bin/subjack -w ~/tools/tmp/subs.txt -t 1000 -timeout 15 -v -c ~/go/src/github.com/haccer/subjack/fingerprints.json -a -ssl -o results.txt;
cat results.txt | grep -v "Not Vulnerable" > takeover.txt;


#Send data to discord webhook
cat takeover.txt | grep -i '[Fastly]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Azure]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Github]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[S3 BUCKET]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Heroku]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[DOMAIN AVAILABLE' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Digital Ocean]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Wordpress]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";


#Diff new and last takeover.txt
cat takeover_old.txt | sort | tee -a diff1.txt
cat takeover.txt | sort | tee -a diff2.txt
comm -13 diff1.txt diff2.txt > tmp.txt;
~/go/bin/discordtitle Diff;
~/go/bin/discordmessage "$(< ./tmp.txt)";
mv takeover.txt takeover_old.txt;
rm diff1.txt
rm diff2.txt

#Clean up
cp takeover.txt ../backups/"takeover-`date +"%d-%m-%Y-%H:%M"`.txt";
echo "Done" - `date +"%d-%m-%Y-%H:%M"` >> finished.txt;
rm results.txt;
rm tmp.txt;

