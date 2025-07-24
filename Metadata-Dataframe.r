# import proper packages 
library(XML)

# get a path to the directory of metadata files
dir_path <- "data-store/data/iplant/home/shared/geri/geri-harmonized/metadata/saeon_metadata/"

# where to print the dataframe
print_df_path = "Geri-Metadata-df-Maker/saeon_output.csv"

# get a list of the file names in the directory
list_of_files <- list.files( path=dir_path )
print( list_of_files )

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

# create the dataframe
df <- data.frame()

# for each file in the directory,
for (file in list_of_files)
{
  # read the file as an xml 
  xml_data <- xmlParse( paste( dir_path, file, sep="" ) )
  
  # get the root of the xml data
  root <- xmlRoot( xml_data )
  
  # scrape the xml file and get the data in a named list
  val_arr <- scrape_xml( root )
  
  # add that struct to the larger dataframe
  df <- rbind( df, val_arr )
}

# save the dataframe somewhere
write.csv( df, print_df_path )