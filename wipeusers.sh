#!/bin/bash


datenow=$(date +%s)
for user in $(awk -F: '{print $1}' /etc/passwd); do
expdate=$(chage -l $user|awk -F: '/Account expires/{print $2}')
echo $expdate | grep -q never && continue
echo -n "User \`$user' expired on $expdate "
expsec=$(date +%s --date="$expdate")
diff=$( echo $datenow - $expsec)
echo $diff | grep -q ^\- && echo okay && continue
printf ""
echo deleting $user ...
userdel -r $user

done