library(tools)

# Define paths
source_dir <- "E:/zaaged/DMR5G_test"
unzip_dir <- "E:/zabaged/DMR5G_test_unzipped"

# Ensure the unzip directory exists
if (!dir.exists(unzip_dir)) {
  dir.create(unzip_dir, recursive = TRUE)
  message("Created directory: ", unzip_dir)
}

# List all ZIP files in the source directory
zip_files <- list.files(source_dir, pattern = "\\.zip$", full.names = TRUE)

# List all extracted folders in the destination directory
extracted_folders <- list.dirs(unzip_dir, recursive = FALSE, full.names = FALSE)

# Get ZIP filenames without extension
zip_names <- file_path_sans_ext(basename(zip_files))

# Identify which ZIP files were not properly unzipped
missing_zips <- zip_files[!(zip_names %in% extracted_folders)]

# Use 7-Zip exclusively for unzipping
for (zip_file in missing_zips) {
  tryCatch({
    system(sprintf('"C:/Program Files/7-Zip/7z.exe" x "%s" -o"%s" -y', zip_file, unzip_dir))
    message("Successfully unzipped using 7-Zip: ", basename(zip_file))
    Sys.sleep(1)  # Pause between extractions
  }, error = function(e) {
    message("Failed to unzip using 7-Zip: ", basename(zip_file), " - ", e$message)
  })
}

# Check if all ZIP files are now extracted and contain files
for (zip_file in zip_files) {
  zip_name <- file_path_sans_ext(basename(zip_file))
  extracted_path <- file.path(unzip_dir, zip_name)
  
  if (!(zip_name %in% list.dirs(unzip_dir, recursive = FALSE, full.names = FALSE)) || 
      length(list.files(extracted_path, recursive = TRUE)) == 0) {
    message("Still not unzipped or empty: ", basename(zip_file))
  }
}

message("Unzipping process completed.")
