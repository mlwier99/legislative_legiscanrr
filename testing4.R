# https://fanghuiz.github.io/legiscanrr/articles/parse-json.html

# Clear workspace
# Use control+L to clear console
rm(list=ls())

# Load Packages
library("rjson")
# 

# Make sure Xcode app is installed on Mac https://www.r-project.org/nosvn/pandoc/devtools.html
install.packages("devtools")
 library("devtools")
library("dplyr")
library("legiscanrr")


# Set Directory
getwd() 
setwd("/Users/RA/Desktop/")
dir()
list.files()

# Decode JSON Bill Text from Local JSON
# Base function to find data types: https://fanghuiz.github.io/legiscanrr/reference/find_json_path.html

# Find and List Text Paths
text_paths <- find_json_path(base_dir = "Michelle" , file_type = "text")
text_paths

# Decode Bills
text_decode_2 <- decode_bill_text(text_paths[4])

# Mapping; learn to do this. You can map through folders. 
text_all <- text_paths %>%
  purrr::map_df(decode_bill_text)
