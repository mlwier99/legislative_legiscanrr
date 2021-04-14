#!/bin/bash

cd /Volumes/Samsung_T5/Data/Legiscan/Data/data_json/CO
  for file in 2*
    do 
    zip -rm ${file%.*}.zip $file
    done