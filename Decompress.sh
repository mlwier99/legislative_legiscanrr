#!/bin/bash


StateArray=("AL" "AZ" "AK" "AR" "CT"); 
  for val in ${StateArray[@]}; do
    unzip $val/All_Sessions/people
    unzip $val/All_Sessions/vote
    unzip $val/All_Sessions/bill
    unzip $val/All_Sessions/text
done
