# install the library if not already
#install.packages( "XML" )

# include the xml library
library(XML)

# a function to scrape all the data from an XMl file,
# and returns a named list of the data inside
# pass the root of the file as an arg, and a seperator 
scrape_xml <- function( xml_root, divider='-' )
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
      # the final list of data to be returned
      list_of_data <- list() # xmlValue( xml_root[[1]] )
      
      # get the amount of subroots
      num_subroots <- sum( sapply( xmlChildren( xml_root ), xmlName ) != "" )
      
      # iterate through the subroots
      for(i in 1:num_subroots)
      {
        # get the data point
        subroot_value <- xmlValue( xml_root[[i]])
        
        # get the subroot and add it to the list
        list_of_data <- append( list_of_data, subroot_value)
      }
      
      # remove empty indexes from the list of data
      list_of_data <- list_of_data[list_of_data != ""]
      
      # return the list as a string
      root_value <- paste( unlist( list_of_data ), collapse=divider )
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
