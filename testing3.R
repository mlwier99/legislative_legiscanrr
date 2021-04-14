# https://fanghuiz.github.io/legiscanrr/articles/parse-json.html

# Clear workspace
# Use control+L to clear console
rm(list=ls())

# Load Packages
library("rjson")
# 
devtools::install_github("fanghuiz/legiscanrr", force = TRUE)
library("legiscanrr")
# Make sure Xcode app is installed on Mac https://www.r-project.org/nosvn/pandoc/devtools.html
# install.packages("devtools")
# library("devtools")

library("dplyr")


# Set Directory
getwd() 
setwd("/home/michelle/Dropbox/RA Work/Spring 2020, TP/")
dir()
list.files()

# Decode JSON Bill Text from Local JSON
# Base function to find data types: https://fanghuiz.github.io/legiscanrr/reference/find_json_path.html

# Find and List Text Paths
text_paths <- find_json_path(base_dir = "CA Sample" , file_type = "text")
text_paths

# Decode Bills
text_decode_2 <- decode_bill_text(text_paths)
str(text_decode_2)

indicate <- 1

if(indicate <= max(length(text_paths))){
  print(indicate)
  text <- jsonlite::fromJSON(text_paths['indicate'])
  input_bill_text_indicate <- text[['text']]
  indicate <- indicate + 1 
}


text <- jsonlite::fromJSON(text_paths[4])
input_bill_text <- text[['text']]

if(input_bill_text[["mime"]] == "text/html"){
  ext <- ".html"
}

if(input_bill_text[["mime"]] == "application/pdf"){
  ext <- ".pdf"
}

if(input_bill_text[["mime"]] == "application/wpd"){
  ext <- ".wpd"
}

if(input_bill_text[["mime"]] == "application/doc" |
   input_bill_text[["mime"]] == "application/docx"){
  ext <- ".docx"
}

if(input_bill_text[["mime"]] == "application/rtf"){
  ext <- ".rtf"
}


tmp <- tempfile(fileext = ext)

text_bin <- jsonlite::base64_dec(input_bill_text[["doc"]])

writeBin(text_bin, tmp)

text_decoded <- readtext::readtext(tmp)

text_decoded <- text_decoded[["text"]]

output_bill_text <- tibble::as_tibble(input_bill_text)
output_bill_text$text_decoded <- text_decoded
output_bill_text

purrr::flatten(text)