#!/bin/bash
cd /Volumes/Samsung_T5/Data/Legiscan/Data/
cd /home/michelle/sdb1/
cd "/run/media/sean/Samsung USB/"
cd "/run/media/sean/mwier"
ls


#All States
StatesArray=("AL" "AK" "AZ" "AR" "CA" "CO" "CT" "DE" "FL" "GA" "HI" "ID" "IL" "IN" "IA" "KS" "KY" "LA" 
  "ME" "MD" "MA" "MI" "MN" "MS" "MO" "MT" "NE" "NV" "NH" "NJ" "NM" "NY" "NC" "ND" "OH" "OK" "OR" "PA" 
  "RI" "SC" "SD" "TN" "TX" "UT" "VT" "VA" "WA" "WV" "WI" "WY")

StateArray=("") 

#Run BEFORE parsing bills. 
echo "Unzipping state files."
for val in ${StateArray[@]}
do 
  echo "Unzipping session-specific folders."
  sudo unzip -n Zipped/$val\* -d data_json; rm -rf __MACOSX
done 

#Run AFTER unzipping folders. 
FileArray=("people" "vote") "bill" "text" "amendment" )
echo "Moving/copying bill/people/text/vote/amendment folders from session-specific 
  to all-session folder, which makes parsing easier." 
for val in ${StateArray[@]}
do
  for i in ${FileArray[@]}
  do echo $val $i
  mkdir -p ./data_json/$val/AllSessions/$i #making file for subfiles data 
  find ./data_json/$val/*/$i/ -type f -name  *.json -exec cp -n {} ./data_json/$val/AllSessions/$i/ \;
  done
done 

StateArray=("AL" "AK" "AZ" "AR" "CA" "CO" "CT" "DE" "FL" "GA" "HI" "ID" "IL" "IN" "IA" "KS" "KY" "LA" 
  "ME" "MD" "MA" "MI" "MN" "MS" "MO" "MT" "NE" "NV" "NH" "NJ" "NM" "NY" "NC" "ND" "OH" "OK" "OR" "PA" 
  "RI" "SC" "SD" "TN" "TX" "UT" "VT" "VA" "WA" "WV" "WI" "WY")
#Run AFTER parsing bills.

FileArray=("bill" "people" "vote")
echo "Zipping session-specific folders to save space."
for val in ${StateArray[@]}
do 
  for i in ${FileArray[@]}
  do 
  find ./data_json/$val/* -type d -name "*_*" -exec zip -rm {} {} \;
  done 
done 

echo "Zipping the all-session specific folders to save space. I don't zip the 
  text and amedment folders, since I did that parsing separately. "
FileArray=("bill" "people" "vote")
for val in ${StateArray[@]}
do 
  for i in ${FileArray[@]}
  do 
  find ./data_json/$val/AllSessions/$i -type d -exec zip -rm {} {} \;
  done 
done 
