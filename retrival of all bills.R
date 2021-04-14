# install.packages("devtools")
# install.packages("rjson")
# install.packages("dplyr")
# devtools::install_github("fanghuiz/legiscanrr")

# Load Packages
library("rjson")
library("devtools")
library("legiscanrr")
library("dplyr")
library("readr")
library("tidyr")
library("purrr")
library("stringr")

# Set Directory
getwd()
setwd("/home/michelle/Dropbox/RA Work/Spring 2020, TP/")
dir()
list.files()

#Get bill details via API using get_bill(); the file the code is saved in is: 
# Updating LEGISCAN_API_KEY env var with input; consider setting this in your
# ~/.Renviron file to avoid future input.


for(i in 1:200) { 
  bill <- get_bill(bill_id = i)
  head(bill)
  bill_meta <- parse_bill(bill)
  str(bill_meta)
  parse_bill_progress(bill)
  sponsor <- parse_bill_sponsor(bill)
  bill_meta <- cbind(bill_meta, sponsor)
  str(sponsor)
  bill_text <- get_bill_text(bill$bill_id, api_key = '16a94313b870b8a21ecca876b858b9aa')
  bill_text <- decode_bill_text(bill_text)
  bill_text <- bill_text  %>%  ungroup  %>%  select(-doc)
  str(bill_text)
  bill_text$text_decoded <- str_replace_all(bill_text$text_decoded, "\n", "")
  bill_text$text_decoded <- str_replace_all(bill_text$text_decoded, "\t", "")
  str(bill_text)
  bill_meta <- cbind(bill_meta, bill_text$doc_id)
  bill_meta <- cbind(bill_meta, bill_text$bill_id)
  bill_meta <- cbind(bill_meta, bill_text$date)
  bill_meta <- cbind(bill_meta, bill_text$type)
  bill_meta <- cbind(bill_meta, bill_text$type_id)
  bill_meta <- cbind(bill_meta, bill_text$mime) 
  bill_meta <- cbind(bill_meta, bill_text$mime_id)
  bill_meta <- cbind(bill_meta, bill_text$text_size)
  #bill_meta <- cbind(bill_meta, bill_text$text_decoded) 
  while(i==1) {
    write.table(bill_meta, file = "combined.csv", sep="@", append=F, col.names=T, row.names=F, quote=F)
  }
  write.table(bill_meta, file = "combined.csv", sep="@", append=T, col.names=F, row.names=F, quote=F)
  print(i)
}