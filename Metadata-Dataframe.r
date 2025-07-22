# import proper packages 
library(XML)

# a function that gets the information from a root in an xml file
# if the root has more children, it recursively calls itself until there are none
# its only arguement is an xml root
xml_root_gatherer <- function( xml_root )
{
  # get the number of children in the root 
  num_roots <- sum( sapply( xmlChildren( xml_root ), xmlName ) != "" )

  # make a list to gether the data for
  
  # iterate through the roots
  for( i in 1:num_roots )
  {
    # get the name of the root
    root_name <- xmlName( xml_root[[i]] ) 
    
    # get the root value
    root_value <- xmlValue( xml_root[[i]] )
    
    # look at the roots
    print( cat( root_name, root_value ) )
    
    # if the root is a subroot,
      # call the function again
  
    # otherwise,
      # add it to the list of data
  }
  
  # return the list
}

# get a path to the directory of metadata files
dir_path <- "data-store/data/iplant/home/shared/geri/metadata/saeon_metadata/"

# get a list of the file names in the directory
list_of_files <- list.files( path=dir_path )

# create the dataframe
df <- data.frame()

# for each file in the directory,
for (file in list_of_files)
{
  print( file )
  # read the file as an xml 
  xml_data <- xmlParse( paste( dir_path, file, sep="" ) )
  
  # get the root of the xml data
  root <- xmlRoot( xml_data )
  
  xml_root_gatherer( root )
  
  # add that struct to the larger dataframe 
}

# save the dataframe somewhere
