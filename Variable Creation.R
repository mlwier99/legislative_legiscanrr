
##### More Variables to Dataframe 

bill_info_master$originate_senate <- 0 
if(bill_info_master$chamber=="S") {
  bill_info_master$originate_senate <- 1
}
bill_info_master$crossed_chambers <- 0 
if(bill_info_master$chamber!=bill_info_master$current_body){
  bill_info_master$crossed_chambers <-1 
}

bill_master$action_type <- bill_master$type 
bill_master$type <- NULL 

number_of_bills_intro <- sum(with(bill_master, action_type=="Introduced"))
number_of_bills_pass <- sum(with(bill_master, passed==1))
number_of_bills_committee <-
  
  # Variables Needed
  Bills introduced
Bills passed, number
Bills passed, percent
Bills sent to committee, number
Bills sent to committee, percent
Bills passing committee, number
Bills passing committee, percent
Bills failing committee, number
Bills failing committee, percent
Bills crossing over both chambers 
Bills originating in the Senate
Bills originating in the House 


#Finished States# 
#Exlcuding Text
# AL (has .RData, but not .txt)
# AK
# AR
# MA
# SC

#Including Text  
# NV, compressed json
# AZ, compressed json


text_list[j]
