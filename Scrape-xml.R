# include the xml library
library(XML)

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
    # get the name of the root
    root_name <- xmlName( xml_root[[i]] ) 
    
    # get the root value
    root_value <- xmlValue( xml_root[[i]] )
    
    # add the value to the list using the root
    root_val_arr[[ root_name ]] <- root_value
    
    # if the root is a subroot,
    # call the function again
    
    # otherwise,
    # add it to the list of data
  }
  
  # return the array
  root_val_arr
}