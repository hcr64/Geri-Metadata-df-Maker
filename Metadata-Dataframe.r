# import the xml scraping funciton 
source("Geri-Metadata-df-Maker/Scrape-xml.R")

# get a path to the directory of metadata files
dir_path <- "data-store/data/iplant/home/shared/geri/geri-harmonized/metadata/saeon_metadata/"

# where to print the dataframe
print_df_path = "Geri-Metadata-df-Maker/saeon_output.csv"

# for seperating list values in the dataframe
divider='#'

# get a list of the file names in the directory
list_of_files <- list.files( path=dir_path )

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
  val_arr <- scrape_xml( root, divider=divider )
  
  # add that struct to the larger dataframe
  df <- rbind( df, val_arr )
}

# save the dataframe somewhere
write.csv( df, print_df_path )

# write a little message
print("All Good!")