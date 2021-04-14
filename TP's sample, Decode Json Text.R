# https://fanghuiz.github.io/legiscanrr/articles/parse-json.html

# Clear workspace
   # Use control+L to clear console
   rm(list=ls())

# Load Packages
   library("rjson")
      # 
   library("legiscanrr")
      # Make sure Xcode app is installed on Mac https://www.r-project.org/nosvn/pandoc/devtools.html
      # install.packages("devtools")
      # library("devtools")
      # devtools::install_github("fanghuiz/legiscanrr", force = TRUE)
   library("dplyr")
 
# Set Directory
   getwd()
   setwd("/Users/ktpsmith/Desktop/JSONTEST/text")
   dir()
   list.files()

# Decode JSON Bill Text from Local JSON
   # Base function to find data types: https://fanghuiz.github.io/legiscanrr/reference/find_json_path.html
   
   # Find and List Text Paths
   text_paths <- find_json_path(base_dir = "/Users/ktpsmith/Desktop/JSONTEST/text", file_type = "text")
   text_paths
   
   # Decode Bills
   text_decode_2 <- decode_bill_text(text_paths)
   str(text_decode_2)
   
   