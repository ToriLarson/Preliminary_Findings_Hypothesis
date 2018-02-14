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

# find links for all states

state_urls = c("http://livingwage.mit.edu/states/01","http://livingwage.mit.edu/states/02","http://livingwage.mit.edu/states/04")
state_nums = c("01","02","04")



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
  occ_table <- html_table(occ_node)
  return(occ_table)
}  
  
get_state = function(state_num) {
  state_url_from_num(state_num)
  # "http://livingwage.mit.edu/states/05"
  return(get_occ_table_from_url(state_url_from_num()))
}

  #read url
  #get table
  #put table in dataframe
  #return dataframe

#step 2
#call the function on individidual states as a test

#step 3
#make a function that takes state_num and returns a df
get_occ_from_state_num = function(state_num){
  state_url = paste("http://livingwage.mit.edu/states/",state_num, sep = "")
  state_html <- read_html(state_url)
  occ_node <- html_nodes(state_html, "table.occupations_table")
  occ_table <- html_table(occ_node)
  return(occ_table)
  
}


get_occ_from_state_num2 = function(state_num){
  state_url = state_url_from_num(state_num)
  occ_table = get_occ_table_from_url(state_url)
  return(occ_table)
}

#step 4
# call on individual numbers as a test

#step 5
# rbind two states together



#step 6 function to rbind state to table



