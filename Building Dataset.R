# Actual retrieval of .json files from Legiscan API; useless without an API key. 

#install.packages("devtools")
#install.packages("rjson")
# install.packages("dplyr")
#devtools::install_github("fanghuiz/legiscanrr")

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
#setwd("/home/sean/Documents/michelle/bill_data")
#setwd("/home/michelle/sdb1/")
#setwd("/run/media/sean/mwier/")
dir()
list.files()

parse_people <- function(people_json){
  # Inner function
  extract_people_meta <- function(input_people_json){
    # Import json
    input_people <- jsonlite::fromJSON(input_people_json, flatten = TRUE)
    # Keep inner element
    people_meta <- input_people[['person']]
    
    people_meta
    # End of inner functionn
  }
  
  # Iterate over input json to decode text one by one
  output_list <- lapply(people_json, extract_people_meta)
  
  # Bind list into flat data frame
  output_df <- data.table::rbindlist(output_list, fill = TRUE)
  output_df  <- tibble::as_tibble(data.table::setDF(output_df))
  output_df
  # End of function call
}

full_state_list<-c("AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID",
                   "IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS",
                   "MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK",
                   "OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV",
                   "WI","WY")

error_list <- c("OH", "MS", "PA", "WV")

state_list <- c("MS") , "TX", "MS", "NJ") 

#Bill files
for(i in 1:length(state_list)){ 
path_state <- paste0("data_json/", state_list[i], "/AllSessions") 
  #Meta 
  bill_meta_paths <- find_json_path(base_dir = path_state, file_type = "bill") 
  bill_meta <- bill_meta_paths %>%
    map_df(parse_bill)
  # Progress
  bill_progress <- bill_meta_paths %>%
    map_df(parse_bill_progress)
  #Sponsor 
  bill_sponsor <- bill_meta_paths %>%
    map_df(parse_bill_sponsor) 

#Bill Votes
  # Roll-Call
  bill_vote_paths <- find_json_path(base_dir = path_state, file_type = "vote") 
  bill_rollcall_vote <- bill_vote_paths %>%
    map_df(parse_rollcall_vote)
  # Individual Votes
  bill_indv_vote <- bill_vote_paths %>%
    map_df(parse_person_vote)

#People files
  #Bill_People
  bill_people_paths <- find_json_path(base_dir = path_state, file_type = "people") 
  bill_people <- bill_people_paths %>%
    map_df(parse_people)

#Saving files
  dir.create(path = paste0("data_r/", state_list[i]))
  save(bill_indv_vote, file = paste0("data_r/", state_list[i], "/", state_list[i], "_bill_indv_votes.RData"))
  save(bill_people, file = paste0("data_r/", state_list[i], "/", state_list[i], "_bill_people.RData"))
  
  # Combines meta, progress, roll-call votes, and sponsors. 
  bill_master <- merge(bill_meta, bill_progress, by.x = "bill_id", by.y = "bill_id")
  bill_master <- merge(bill_master, bill_rollcall_vote, by.x = "bill_id", by.y = "bill_id")
  bill_master <- merge(bill_master, bill_sponsor, by.x = "bill_id", by.y = "bill_id")
  save(bill_master, file = paste0("data_r/", state_list[i], "/", state_list[i], "_bill_master.RData"))
  }

state_list <- c("DE")
#Bill text
for(i in 1:length(state_list)){ 
  #Bill Text
  bill_text_paths <- find_json_path(base_dir = paste0("data_json/", state_list[i], "/AllSessions"),file_type = "text") 
  bill_text_all <- bill_text_paths %>%
    map_df(decode_bill_text)
  bill_text_all <- bill_text_all  %>%  ungroup  %>%  select(-doc)
  bill_text_all$text_decoded <- str_replace(bill_text_all$text_decoded,"\t"," ")
  bill_text_all$text_decoded <- str_replace(bill_text_all$text_decoded,"\n"," ")
  save(bill_text_all, file = paste0("data_r/", state_list[i], "/", state_list[i], "_bill_text.RData"))
}

############### State Specific ############### 



  path_state <- paste0("data_json/", "MS", "/AllSessions") 
  #Meta 
  bill_meta_paths <- find_json_path(base_dir = path_state, file_type = "bill") 
  bill_meta <- bill_meta_paths %>%
    map_df(parse_bill)
  # Progress
  bill_progress <- bill_meta_paths %>%
    map_df(parse_bill_progress)
  #Sponsor 
  bill_sponsor <- bill_meta_paths %>%
    map_df(parse_bill_sponsor) 
  
  #Bill Votes
  # Roll-Call
  bill_vote_paths <- find_json_path(base_dir = path_state, file_type = "vote") 
  bill_rollcall_vote <- bill_vote_paths %>%
    map_df(parse_rollcall_vote)
  # Individual Votes
  bill_indv_vote <- bill_vote_paths %>%
    map_df(parse_person_vote)
  
  #People files
  #Bill_People
  bill_people_paths <- find_json_path(base_dir = path_state, file_type = "people") 
  bill_people <- bill_people_paths %>%
    map_df(parse_people)
  
  #Saving files
  dir.create(path = paste0("data_r/", "MS"))
  save(bill_indv_vote, file = paste0("data_r/", "MS", "/", "MS", "_bill_indv_votes.RData"))
  save(bill_people, file = paste0("data_r/", "MS", "/", "MS", "_bill_people.RData"))
  
  # Combines meta, progress, roll-call votes, and sponsors. 
  bill_master <- merge(bill_meta, bill_progress, by.x = "bill_id", by.y = "bill_id")
  bill_master <- merge(bill_master, bill_rollcall_vote, by.x = "bill_id", by.y = "bill_id")
  bill_master <- merge(bill_master, bill_sponsor, by.x = "bill_id", by.y = "bill_id")
  save(bill_master, file = paste0("data_r/", "MS", "/", "MS", "_bill_master.RData"))
}
