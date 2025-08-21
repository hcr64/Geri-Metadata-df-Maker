# install the library if not already
#install.packages( "XML" )

# include the xml library
library(XML)

# a function to scrape all the data from an XMl file,
# and returns a named list of the data inside
# pass the root of the file as an arg, and a seperator 
scrape_xml <- function( xml_root, arr, divider='-' )
{
  # a list of nodes that cannot be directly added to the df
  special_conditions <- list( "geoLocations", "contributors", "subjects", "dates" )
  
  # get the number of roots in the file
  num_roots <- length( xmlChildren( xml_root ) )
  
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
    if( length( xmlChildren( curr_root ) ) > 1 )
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
      # if the root is not in the special conditions list
      if( !(xmlName( xml_root[[i]] ) %in% special_conditions) )
      {
        root_value <- xmlValue( xml_root[[i]] )
      }
    }
    
    # add the data as a string to the list of data
    root_val_arr[[ root_name ]] <- root_value
  }

  # add the coordinates to the array, each in their own column
  root_val_arr[["pointLatitude"]] <- xmlValue( xmlElementsByTagName(xml_root, "pointLatitude", recursive=TRUE)[[1]] )
  root_val_arr[["pointLongitude"]] <- xmlValue( xmlElementsByTagName(xml_root, "pointLongitude", recursive=TRUE)[[1]] )
  
  # add only one date to the array
  root_val_arr[["dates"]] <- xmlValue( xmlChildren(xml_root[["dates"]])[[3]] )
  
  # get a list of the contributors' names
  contributor_names <- xmlValue( xmlElementsByTagName(xml_root, "contributorName", recursive=TRUE) )
  
  # turn it into a string using the divider, and add it to the correct spot in the array
  root_val_arr[["contributors"]] <- paste( unlist( contributor_names ), collapse=divider )
  
  # do something about the subjects too
  # keep all but the 1st and 5th entries for the subjects
  subject_names <- xmlValue( xmlElementsByTagName(xml_root, "subject", recursive=TRUE) )
  
  # put the appropriate subjects in the array
  root_val_arr[["subjects"]] <- paste( unlist( subject_names[-c(1, 5)] ), collapse=divider )
  
  # return the array
  root_val_arr
}
