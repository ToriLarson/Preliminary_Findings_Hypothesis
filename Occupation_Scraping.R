# giving URL a name
URL_Weber <- "http://livingwage.mit.edu/counties/49057"

#reading in the URL
read_html(URL_Weber)

# Giving the read URL a name
LW_Weber <- read_html(URL_Weber)

# Getting all of the table out
all_tbls <- html_nodes(LW_Weber, "table")

# just getting the Occupations Table out
occ_tbls <- html_nodes(LW_Weber, "table.occupations_table")

# Turning the List into a data.frame
html_table(occ_tbls)

# renaming the table Weber_Occ1
Weber_Occ1 <- html_table(occ_tbls[[1]])

-----
  
state_url_from_num = function(state_num) {
state_url = paste("http://livingwage.mit.edu/states/",state_num, sep = "")
return(state_url)
  }

#step 1
get_occ_table_from_url = function(state_url) {
  #state_url = "http://livingwage.mit.edu/states/05"
  state_html <- read_html(state_url)
  occ_node <- html_nodes(state_html, "table.occupations_table")
  occ_table <- html_table(occ_node[[1]])
  return(occ_table)
}  


#step 3
#make a function that takes state_num and returns a df
get_occ_from_state_num = function(state_num){
  state_url = paste("http://livingwage.mit.edu/states/",state_num, sep = "")
  state_html <- read_html(state_url)
  occ_node <- html_nodes(state_html, "table.occupations_table")
  occ_table <- html_table(occ_node[[1]])
  return(occ_table)
}


get_occ_from_state_num2 = function(state_num){
  state_url = state_url_from_num(state_num)
  occ_table = get_occ_table_from_url(state_url)
  return(occ_table)
}

#step 4

# Creating variables to put in my gst function.
states = c("Alabama","Alaska","Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "District of Columbia", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming")
url_num = c("01", "02", "04", "05","06", "08", "09","10","11","12","13","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","44","45","46","47","48","49","50","51","53","54","55","56")
state_info = data.frame(
  states,
  url_num
)

gst = function(state_name,state_num){
  Test_table <- get_occ_from_state_num2(state_num)
  Test_table$State <- state_name
  return(Test_table)
}

state_from_row = function(row){
  return(gst(row[1],row[2]))
}

State_Occupations = bind_rows(apply(state_info,1,function(row) gst(row[1],row[2])))


print(apply(state_info,1,state_from_row))
# 1 means applying on a row basis
State_Occupations = bind_rows(state_from_row(state_info))


#apply(state_info,1,function(row) gst(row[1],row[2])) %>% bind_rows

# Move state to the left
State_Occupations <- State_Occupations[,c(3,1:2)]

#Changed Column Names
names(State_Occupations)[names(State_Occupations) == 'Typical Annual Salary'] <- 'Annual_Salary'
names(State_Occupations)[names(State_Occupations) == 'Occupational Area'] <- 'Occupational_Area'

## Taking out dollar sign
parse_number(State_Occupations$Annual_Salary)
State_Occupations1 <- parse_number(State_Occupations$Annual_Salary)
State_Occupations$Annual_Salary <- State_Occupations1

## Changing Annual_Salary from character to numeric
State_Occupations$Annual_Salary <- as.numeric(State_Occupations$Annual_Salary)

# Moving on to EDA

summarise(State_Occupations)

# Which field and state has the highest paying job
which.max(State_Occupations$Annual_Salary)
# Answer!
State_Occupations[183,]

# Since I know the highest paying field is Legal, I now want to do a bar chart of all the legal fields in the country
Legal_USA <- subset(State_Occupations, Occupational_Area=="Legal")

#BAR PLOT!!!
Legal_USA_Graph <- plot_ly(Legal_USA, x = ~State, y = ~Annual_Salary, type = 'bar', name = 'Occupational Area') %>% layout(yaxis = list(title = 'Annual Salary'), barmode = 'group')
# behold 
Legal_USA_Graph

-----

#step 6 function to rbind state to table


# test
state.table = function(state_name,state_num){
  Test_table <- get_occ_from_state_num2(state_num)
  Test_table$State <- state_name
  Occupations <- rbind(Test_table, Occupations)
  return(Occupations)
}
# Something ben did
library(readr)
allstates$salary_num  = parse_number(allstates$`Typical Annual Salary`)
