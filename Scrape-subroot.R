# include the mxl library
library(XML)

# the function iteelf, takes one arg to a root with multiple(>1) subroots
# the divider arg is what will seperate the data in the final string
scrape_subroot <- function( xml_root, divider="-" )
{
  # the final string to be returned
  # start it with the first subroot's value
  string_of_data <- xmlValue( xml_root[[1]] )
  
  # get the amount of subroots
  num_subroots <- sum( sapply( xmlChildren( xml_root ), xmlName ) != "" )
  
  # iterate through the subroots
  for(i in 2:num_subroots)
  {
    # get the data point
    subroot_value <- xmlValue( xml_root[[i]])
    
    # get the subroot and add it to the sting
    string_of_data <- paste0( string_of_data, divider, subroot_value)
  }
  
  # return the string with the data seperated by the divider
  string_of_data
}
