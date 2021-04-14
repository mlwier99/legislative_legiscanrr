# install.packages("devtools")
# install.packages("rjson")
# install.packages("dplyr")
# devtools::install_github("fanghuiz/legiscanrr")

# Load Packages
library("rjson")
library("devtools")
library("legiscanrr")
library("dplyr")
library("purrr")

# Set Directory
getwd()
setwd("/home/michelle/Dropbox/RA Work/Spring 2020, TP/")
dir()
list.files()

# Decode JSON Bill Text from Local JSON
# Base function to find data types: https://fanghuiz.github.io/legiscanrr/reference/find_json_path.html

# Find and List Text Paths
text_paths <- find_json_path(base_dir = "CA Sample", file_type = "text")
  # Above line is assigning a json path to the text_path object; must include "text"/"bill"/etc as the subfile. 
text_paths

# Decode Bills
#text_decode_2 <- decode_bill_text(text_paths[4])
#str(text_decode_2)

# Mapping; learn to do this. You can map through folders. 
text_all <- text_paths %>%
  map_df(decode_bill_text)

# Dropping "doc" variable, which was original of the text data. 
text_df <- text_all  %>%  ungroup  %>%  select(-doc)

