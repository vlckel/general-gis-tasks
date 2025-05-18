# Load required libraries
library(readxl)  # For reading Excel files
library(httr)    # For downloading files

# Define the path to the Excel file and the output directory
excel_file <- "E:\\kladctvercu.xls"
output_dir <- "E:\\zabaged\\DMR5G"

# Read the Excel file and extract the MAPNO column
mapno_data <- read_excel(excel_file)
mapno_list <- mapno_data$MAPNO

# Base URL for downloading files
base_url <- "https://openzu.cuzk.cz/opendata/DMR5G/epsg-5514/"

# Ensure the output directory exists
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

# Loop through each MAPNO and download the corresponding file
for (mapno in mapno_list) {
  # Construct the full URL
  file_url <- paste0(base_url, mapno, ".zip")
  
  # Define the output file path
  output_file <- file.path(output_dir, paste0(mapno, ".zip"))
  
  # Download the file
  tryCatch({
    download.file(file_url, output_file, mode = "wb")
    cat("Downloaded:", file_url, "to", output_file, "\n")
  }, error = function(e) {
    cat("Failed to download:", file_url, "\n")
  })
}
