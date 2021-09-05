#!/bin/bash

cd ~/tools/tmp;
ulimit -n 5000;
FILENAME=$(date +"%d-%m-%Y-%H:%M");
OUTPUT=$(echo "results-"$FILENAME".txt");


#Check for dangling CNAME Records
~/go/bin/subjack -w ~/tools/tmp/subs.txt -t 250 -timeout 10 -v -c ~/go/src/github.com/haccer/subjack/fingerprints.json -a -ssl -o results.txt;
cat ~/tools/tmp/"$OUTPUT" | grep -v "Not Vulnerable" >> ~/tools/tmp/takeover.txt;


#Send data to discord webhook

~/go/bin/discorder "Finished `date +"%d-%m-%Y-%H:%M"`";

cat ~/tools/tmp/takeover.txt | grep -i 'Fastly' > ~/tools/tmp/tmp.txt;
[ -s ~/tools/tmp/tmp.txt ] && ~/go/bin/discorder "$(< ~/tools/tmp/tmp.txt)" || echo "File empty";

cat ~/tools/tmp/takeover.txt | grep -i 'Azure' > ~/tools/tmp/tmp.txt;
[ -s ~/tools/tmp/tmp.txt ] && ~/go/bin/discorder "$(< ~/tools/tmp/tmp.txt)" || echo "File empty";

cat ~/tools/tmp/takeover.txt | grep -i 'Github' > ~/tools/tmp/tmp.txt;
[ -s ~/tools/tmp/tmp.txt ] && ~/go/bin/discorder "$(< ~/tools/tmp/tmp.txt)" || echo "File empty";

cat ~/tools/tmp/takeover.txt | grep -i 'S3 BUCKET' > ~/tools/tmp/tmp.txt;
[ -s ~/tools/tmp/tmp.txt ] && ~/go/bin/discorder "$(< ~/tools/tmp/tmp.txt)" || echo "File empty";

cat ~/tools/tmp/takeover.txt | grep -i 'DOMAIN AVAILABLE' > ~/tools/tmp/tmp.txt;
[ -s ~/tools/tmp/tmp.txt ] && ~/go/bin/discorder "$(< ~/tools/tmp/tmp.txt)" || echo "File empty";

cat ~/tools/tmp/takeover.txt | grep -i 'Digital Ocean' > ~/tools/tmp/tmp.txt;
[ -s ~/tools/tmp/tmp.txt ] && ~/go/bin/discorder "$(< ~/tools/tmp/tmp.txt)" || echo "File empty";


#Clean up
cp ~/tools/tmp/takeover.txt ~/backups/"takeover-`date +"%d-%m-%Y-%H:%M"`.txt";
echo "Done" - `date +"%d-%m-%Y-%H:%M"` >> finished.txt;
mv takeover.txt takeover_old.txt;
rm "$OUTPUT";
rm tmp.txt;

