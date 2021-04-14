install.packages("devtools")
install.packages("rjson")
install.packages("dplyr")
devtools::install_github("fanghuiz/legiscanrr")

# Load Packages
library("rjson")
library("jsonlite")
library("devtools")
library("legiscanrr")
library("dplyr")

# Set Directory
getwd()
#setwd("/home/michelle/Dropbox/RA Work/Spring 2020, TP/text/")
setwd("/Users/RA/Desktop/Michelle/text/")
dir()
list.files()

# Decode JSON Bill Text from Local JSON
# Base function to find data types: https://fanghuiz.github.io/legiscanrr/reference/find_json_path.html

# Find and List Text Paths
#text_paths <- find_json_path(base_dir = "/home/michelle/Dropbox/RA Work/Spring 2020, TP/text", file_type = "text")
text_paths <- find_json_path(base_dir = "/Users/RA/Desktop/Michelle/text/", file_type = "text")

# Above line is assigning a json path to the text_path object; must include "text"/"bill"/etc as the subfile. 
text_paths
text_paths[41] # example
text_paths[42] # example
text_paths[43] # example
text_paths[44] # example
bill_text3 = text_paths[43]
bill_text4 = text_paths[44]
print(bill_text3)
print(bill_text4)

text_bin <- jsonlite::base64_dec(ex3) 
text_bin <- jsonlite::base64_dec(ex4) 
print(text_bin)
text_bin <- jsonlite::base64_dec(ex4[["html"]])
input_bill_text3 <- jsonlite::fromJSON(bill_text3)
input_bill_text4 <- jsonlite::fromJSON(bill_text4)

ex3 <- readLines(text_paths[43])
ex4 <- readLines(text_paths[44])

# Decode Bills
text_decode_1 <- decode_bill_text(text_paths[4])
ext <- ".html"
print(ex3)
jsonlite::base16_dec(ex3)

input2 <- fromJSON(ex4) 
input <- parse_json(ex4, flatten=TRUE)
minify(input)
colnames(table1)
colnames(flatten(table1))

if (any(class(bill_text) == "billText")) {
  # As is if is API return
  input_bill_text <- bill_text
  input_bill_text
} else if (assertthat::has_extension(bill_text, "json")) {
  # Import if is local json
  input_bill_text <- jsonlite::fromJSON(bill_text)
  input_bill_text
}

# Decode base64 to binary
text_bin <- jsonlite::base64_dec(input_bill_text[["doc"]])

# Write binary text to temp file using correct mime type extension
tmp <- tempfile(fileext = ext)
writeBin(text_bin, tmp)

# Read in from temp file as plain text
text_decoded <- readtext::readtext(tmp)
text_decoded <- text_decoded[["text"]]

# Return a dataframe with decoded texts added in
output_bill_text <- tibble::as_tibble(input_bill_text)
output_bill_text$text_decoded <- text_decoded
output_bill_text

list.files()
# Decoding the object; line below is the attempt to directly do it, without assigning as an object. 

text_decode_2 <- decode_bill_text(text_paths[44])
text_decode_2 <- decode_bill_text('ex4')

str(text_decode_2)
