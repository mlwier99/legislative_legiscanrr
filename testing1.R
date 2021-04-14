install.packages("devtools")
install.packages("rjson")
install.packages("jsonlite")
install.packages("dplyr")
devtools::install_github("fanghuiz/legiscanrr")

# Load Packages
library("jsonlite")
library("rjson")
library("devtools")
library("legiscanrr")
library("dplyr")

detach("package:rjson", unload = TRUE)


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

bill_text1 = text_paths[41]
bill_text2 = text_paths[42]
bill_text3 = text_paths[43]
bill_text4 = text_paths[44]
decode_bill_text(bill_text1)
decode_bill_text(bill_text2)
decode_bill_text(bill_text3)
decode_bill_text(bill_text4)

print(bill_text1) 
print(bill_text2) 
print(bill_text3) 
print(bill_text4) 

ex1 <- readLines('example1.json') 
ex2 <- readLines('example2.json') 
ex3 <- readLines('example3.json')
ex4 <- readLines(text_paths[44])
print(ex1)
print(ex2)
print(ex3)
print(ex4)
fromJSON(ex1)
fromJSON(ex2)
fromJSON(ex3)
fromJSON(ex4)

jsonlite::fromJSON(ex1)
jsonlite::fromJSON(ex2)
jsonlite::fromJSON(ex3)
jsonlite::fromJSON(ex4)

rjson::fromJSON(ex1)
rjson::fromJSON(ex2)
rjson::fromJSON(ex3)
rjson::fromJSON(ex4)

# get rid of the "/* 0 */" lines
json1 <- grep("^/\\* [0-9]* \\*/", ex1, value = TRUE, invert = TRUE)
json2 <- grep("^/\\* [0-9]* \\*/", ex2, value = TRUE, invert = TRUE)
json3 <- grep("^/\\* [0-9]* \\*/", ex3, value = TRUE, invert = TRUE)
json4 <- grep("^/\\* [0-9]* \\*/", ex4, value = TRUE, invert = TRUE)

# add missing comma after }
n1 <- length(json1)
n2 <- length(json2)
n3 <- length(json3)
n4 <- length(json4)

json1[-n1] <- gsub("^}$", "},", json1[-n1])
json2[-n2] <- gsub("^}$", "},", json2[-n2])
json3[-n3] <- gsub("^}$", "},", json3[-n3])
json4[-n4] <- gsub("^}$", "},", json4[-n4])

# add brakets at the beginning and end
json1 <- c("[", json1, "]")
json2 <- c("[", json2, "]")
json3 <- c("[", json3, "]")
json4 <- c("[", json4, "]")


json <- fromJSON(paste(ex1, collapse = ""))
json <- fromJSON(paste(ex2, collapse = ""))
json <- fromJSON(paste(ex3, collapse = ""))
json <- fromJSON(paste(ex4, collapse = ""))

print(json1)
print(json2)
print(json3)
print(json4)

table1 <- json1 
table2 <- json2 
table3 <- json3 
table4 <- json4

print(table1)
print(table2)
print(table3)
print(table4)

write.csv(table1, file = "mydata1.csv")
write.csv(table2, file = "mydata2.csv")
write.csv(table3, file = "mydata3.csv")
write.csv(table4, file = "mydata4.csv")



# Decode Bills
text_decode_1 <- decode_bill_text(text_paths[43])
list.files()
# Decoding the object; line below is the attempt to directly do it, without assigning as an object. 

text_decode_2 <- decode_bill_text(text_paths[44])
text_decode_2 <- decode_bill_text('ex4')

str(text_decode_2)
