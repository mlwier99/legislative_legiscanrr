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

#Get bill details via API using get_bill(); the file the code is saved in is: 
  # Updating LEGISCAN_API_KEY env var with input; consider setting this in your
  # ~/.Renviron file to avoid future input.

bill_example <- get_bill(bill_id = 230086)

# My api: 16a94313b870b8a21ecca876b858b9aa
# Her api: f29fef5ddcea1b65cee12357ac828383

head(bill_example)
#> $bill_id
#> [1] 230086
#> 
#> $change_hash
#> [1] "16a94313b870b8a21ecca876b858b9aa" 
#> 
#> $session_id
#> [1] 122
#> 
#> $session
#> $session$session_id
#> [1] 122
#> 
#> $session$session_name
#> [1] "27th Legislature"
#> 
#> $session$session_title
#> [1] "27th Legislature"
#> 
#> $session$year_start
#> [1] 2011
#> 
#> $session$year_end
#> [1] 2012
#> 
#> $session$special
#> [1] 0
#> 
#> 
#> $url
#> [1] "https://legiscan.com/AK/bill/HB3/2011"
#> 
#> $state_link
#> [1] "http://www.legis.state.ak.us/basis/get_bill.asp?session=27&bill=HB3"


#Extract bill metadata using parse_bill()
bill_meta <- parse_bill(bill_example)
str(bill_meta)
#> Classes 'tbl_df', 'tbl' and 'data.frame':    1 obs. of  24 variables:
#>  $ bill_id             : int 230086
#>  $ change_hash         : chr "16a94313b870b8a21ecca876b858b9aa"
#>  $ url                 : chr "https://legiscan.com/AK/bill/HB3/2011"
#>  $ state_link          : chr "http://www.legis.state.ak.us/basis/get_bill.asp?session=27&bill=HB3"
#>  $ status              : int 2
#>  $ status_date         : chr "2011-02-28"
#>  $ state               : chr "AK"
#>  $ state_id            : int 2
#>  $ bill_number         : chr "HB3"
#>  $ bill_type           : chr "B"
#>  $ bill_type_id        : chr "1"
#>  $ body                : chr "H"
#>  $ body_id             : int 13
#>  $ current_body        : chr "S"
#>  $ current_body_id     : int 14
#>  $ title               : chr "Requirements For Driver's License"
#>  $ description         : chr "An Act relating to issuance of driver's licenses."
#>  $ pending_committee_id: int 2149
#>  $ session_id          : int 122
#>  $ session_name        : chr "27th Legislature"
#>  $ session_title       : chr "27th Legislature"
#>  $ year_start          : int 2011
#>  $ year_end            : int 2012
#>  $ special             : int 0



#Extract bill progress information using parse_bill_progress()
parse_bill_progress(bill_example)
#>          date event bill_id
#> 1: 2011-01-18     1  230086
#> 2: 2011-01-18     9  230086
#> 3: 2011-02-02    11  230086
#> 4: 2011-02-23    10  230086
#> 5: 2011-02-28     2  230086
#> 6: 2011-03-01     9  230086

#Extract information about sponsors for this bill using parse_bill_sponsor()
sponsor <- parse_bill_sponsor(bill_example)
str(sponsor)
#> Classes 'data.table' and 'data.frame':   19 obs. of  9 variables:
#>  $ people_id        : int  6033 11587 11300 11299 11277 6071 6068 6067 6064 6063 ...
#>  $ party_id         : int  2 2 2 2 2 2 1 2 2 2 ...
#>  $ party            : chr  "R" "R" "R" "R" ...
#>  $ name             : chr  "Carl Gatto" "Steve Thompson" "Lance Pruitt" "Eric Feige" ...
#>  $ sponsor_type_id  : int  0 0 0 0 0 0 0 0 0 0 ...
#>  $ sponsor_order    : int  0 0 0 0 0 0 0 0 0 0 ...
#>  $ committee_sponsor: int  0 0 0 0 0 0 0 0 0 0 ...
#>  $ committee_id     : chr  "0" "0" "0" "0" ...
#>  $ bill_id          : int  230086 230086 230086 230086 230086 230086 230086 230086 230086 230086 ...
#>  - attr(*, ".internal.selfref")=<externalptr>

# Decode Bills via mapping 
text_paths <- find_json_path(base_dir = "CA Sample", file_type = "text")
text_paths
text_all <- text_paths %>%
  map_df(decode_bill_text)
text_all <- text_all  %>%  ungroup  %>%  select(-doc)


#Saving 
save(bill_example, bill_meta, sponsor, text_all, file = "example_data.RData")
# To load the data again
load("example_data.RData")

