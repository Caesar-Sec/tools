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

cat takeover.txt | grep -i '[Agile CRM]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Anima]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Worksites]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Bitbucket]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Campaign Monitor]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Cargo Collective]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Cargo Collective]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Digital Ocean]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Feedpress]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Fly.io]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Gemfury]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Ghost]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[HatenaBlog]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Help Juice]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Help Scout]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Intercom]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[JetBrains]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Kinsta]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[LaunchRock]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Ngrok]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Pantheon]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Pingdom]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Readme.io]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[SmartJobBoard]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Statuspage]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Strikingly]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Surge.sh]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Uberflip]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Uptimerobot]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[UserVoice]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";

cat takeover.txt | grep -i '[Wordpress]' > tmp.txt;
~/go/bin/discordmessage "$(< ./tmp.txt)";


#Diff new and last takeover.txt
comm -13 takeover_old.txt takeover.txt > tmp.txt;
~/go/bin/discordtitle Diff;
~/go/bin/discordmessage "$(< ./tmp.txt)";
mv takeover.txt takeover_old.txt;


#Clean up
cp takeover.txt ../backups/"takeover-`date +"%d-%m-%Y-%H:%M"`.txt";
echo "Done" - `date +"%d-%m-%Y-%H:%M"` >> finished.txt;
rm results.txt;
rm tmp.txt;
