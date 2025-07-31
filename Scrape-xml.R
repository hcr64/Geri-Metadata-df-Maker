# include the xml library
library(XML)

# include my subroot scraper function
source("Geri-Metadata-df-Maker/Scrape-subroot.R")

# a function to scrape all the data from an XMl file,
# and returns a named list of the data inside
# pass the root of the file as an arg
scrape_xml <- function( xml_root )
{
  # get the number of roots in the file
  num_roots <- sum( sapply( xmlChildren( xml_root ), xmlName ) != "" )
  
  #the array storing the data with the keys being the xml tags
  root_val_arr <- list()
  
  # iterate through the roots in the file
  for( i in 1:num_roots )
  {
    # get the current root 
    curr_root <- xml_root[[i]]
    
    # get the name of the root
    root_name <- xmlName( curr_root ) 
    
    # if the root has a subroot,
    if( sum( sapply( xmlChildren( curr_root ), xmlName ) != "" ) > 1 )
    {
      # call the function again, and store result as a string
      root_value <- scrape_subroot( curr_root, divider="##" )
    }
    
    # otherwise just set the root_value var to the value
    else
    {
      root_value <- xmlValue( xml_root[[i]] )
    }
    
    # add the data as a string to the list of data
    root_val_arr[[ root_name ]] <- root_value
  }
  
  # return the array
  root_val_arr
}
