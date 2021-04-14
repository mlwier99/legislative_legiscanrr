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
setwd("/home/michelle/Dropbox/RA Work/Spring 2020, TP/")
dir()
list.files()

# API Key is 16a94313b870b8a21ecca876b858b9aa

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

state_list <- c('AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL',
                'IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT',
                'NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI', 
                'SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY')

for(i in 5:5) { 
#Bill Meta, Progress
  bill_meta_paths <- find_json_path(base_dir = "Raw Data/CA Sample", file_type = "bill") 
  bill_meta_paths
  length(bill_meta_paths)
  bill_meta <- bill_meta_paths %>%
    map_df(parse_bill)
  filename_r = paste0("States/", state_list[i], "/", state_list[i], "_bill_meta.RData")
  filename_csv = paste0("States/", state_list[i], "/", state_list[i], "_bill_meta.csv")
  save(bill_meta, file = filename_r)
  write.table(bill_meta, file = filename_csv, 
              sep="|", append=F, col.names=T, row.names=F, quote=F)
  bill_progress <- bill_meta_paths %>%
    map_df(parse_bill_progress)
  filename_r = paste0("States/", state_list[i], "/", state_list[i], "_bill_progress.RData")
  filename_csv = paste0("States/", state_list[i], "/", state_list[i], "_bill_progress.csv")
  save(bill_progress, file = filename_r)
  write.table(bill_progress, file = filename_csv, 
              sep="|", append=F, col.names=T, row.names=F, quote=F)

#Bill_People
  bill_people_paths <- find_json_path(base_dir = "Raw Data/CA Sample", file_type = "people") 
  bill_people_paths
  length(bill_people_paths)
  bill_people <- bill_people_paths %>%
    map_df(parse_people)
  filename_r = paste0("States/", state_list[i], "/", state_list[i], "_bill_people.RData")
  filename_csv = paste0("States/", state_list[i], "/", state_list[i], "_bill_people.csv")
  save(bill_people, file = filename_r)
  write.table(bill_people, file = filename_csv, 
              sep="|", append=F, col.names=T, row.names=F, quote=F)

#Bill Votes
  bill_vote_paths <- find_json_path(base_dir = "Raw Data/CA Sample", file_type = "vote") 
  bill_vote_paths
  length(bill_vote_paths)
  bill_rollcall_vote <- bill_vote_paths %>%
    map_df(parse_rollcall_vote)
  filename_r = paste0("States/", state_list[i], "/", state_list[i], "_bill_rc_votes.RData")
  filename_csv = paste0("States/", state_list[i], "/", state_list[i], "_bill_rc_votes.csv")
  save(bill_rollcall_vote, file = filename_r)
  write.table(bill_rollcall_vote, file = filename_csv, 
              sep="|", append=F, col.names=T, row.names=F, quote=F)
  bill_people_vote <- bill_vote_paths %>%
    map_df(parse_person_vote)
  filename_r = paste0("States/", state_list[i], "/", state_list[i], "_bill_people_votes.RData")
  filename_csv = paste0("States/", state_list[i], "/", state_list[i], "_bill_people_votes.csv")
  save(bill_people_vote, file = filename_r)
  write.table(bill_people_vote, file = filename_csv, 
              sep="|", append=F, col.names=T, row.names=F, quote=F)
  #Bill Text
  bill_text_paths <- find_json_path(base_dir = "Raw Data/CA Sample", file_type = "text") 
  bill_text_paths
  length(bill_text_paths)
  bill_text_all <- bill_text_paths %>%
    map_df(decode_bill_text)
  bill_text_all <- bill_text_all  %>%  ungroup  %>%  select(-doc)
  filename_r = paste0("States/", state_list[i], "/", state_list[i], "_bill_text.RData")
  filename_csv = paste0("States/", state_list[i], "/", state_list[i], "_bill_text.csv")
  save(bill_text_all, file = filename_r)
  write.table(bill_text_all, file = filename_csv, 
              sep="|", append=F, col.names=T, row.names=F, quote=F)

#Combining R Dataframes 
  bill_info_master <- merge(bill_meta, bill_progress, by.x = "bill_id", by.y = "bill_id")
  bill_info_master <- merge(bill_info_master, bill_rollcall_vote, by.x = "bill_id", by.y = "bill_id")
  bill_info_master <- merge(bill_info_master, bill_text_all, by.x = "bill_id", by.y = "bill_id")
  filename_r = paste0("States/", state_list[i], "/", state_list[i], "_bill_info_master.RData")
  filename_csv = paste0("States/", state_list[i], "/", state_list[i], "_bill_info_master.csv")
  save(bill_info_master, file = filename_r)
  
  bill_people_master <- merge(bill_people_vote, bill_people, by.x = "people_id", by.y = "people_id")
  filename_r = paste0("States/", state_list[i], "/", state_list[i], "_bill_people_master.RData")
  filename_csv = paste0("States/", state_list[i], "/", state_list[i], "_bill_people_master.csv")
  save(bill_people_master, file = filename_r)
  write.table(bill_people_master, file = filename_csv, 
              sep="|", append=F, col.names=T, row.names=F, quote=F)
  }  
