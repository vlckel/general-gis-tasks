# install.packages("remotes")
remotes::install_github("ABbiodiversity/wildRtrax")

Sys.setenv(WT_USERNAME = 'efox.vlckova@gmail.com', WT_PASSWORD = 'Anda1usan')

if (FALSE) {
  # Authenticate first:
  wt_auth(force = FALSE)
}

species = wt_get_species()


# Filter the data using dplyr
filtered_data <- species %>%
  filter(grepl("toad|frog", species_common_name, ignore.case = TRUE))

# Canadian Toad is 80
# Northern Leopard Frog is 82
# Western Toad is 84


projects = wt_get_download_summary(sensor_id = "ARU")

# Filter the data using dplyr

FILTER_PROJECTS <- species %>%
  filter(grepl("toad|frog", species_common_name, ignore.case = TRUE))

wt_download_report(
  project_id = 42, sensor_id = "ARU", reports = "main",
  weather_cols = TRUE)



#6. Download multiple projects----
projects.test <- sample_n(projects_2, 85)
FILTER_PROJECTS <- species %>%
  filter(grepl("toad|frog", species_common_name, ignore.case = TRUE))

dat.list_2 <- list()
error.log <- data.frame()

for(i in 1:nrow(projects.test)){
  
  dat.list_2[[i]] <- try(wt_download_report(project_id = projects.test$project_id[i], sensor_id = "ARU", weather_cols = T, report = "main"))
  # Export the dataframe to a CSV file
  filename <- paste(projects.test$project_id[i], ".csv", sep = "")
  write.csv(dat.list_2[[i]], filename, row.names = FALSE)
  print(paste0("Finished dataset ", projects.test$project[i], " : ", i, " of ", nrow(projects.test), " projects"))
  
}

dat.test <- do.call(rbind, dat.list_2)


# Create an empty list to store unlisted dataframes
unlisted_dfs <- list()

# Loop through each column
for (i in 1:31) {
  # Extract data and column names for the current column from the first 17 sublists
  column_data <- lapply(dat.list[1:85], function(x) x[[i]])
  column_names <- names(dat.list[[1]])[i]
  
  # Unlist the column data
  unlisted_data <- unlist(column_data)
  
  # Convert the unlisted data into a dataframe
  unlisted_df <- data.frame(unlisted_data)
  
  # Set the column name
  colnames(unlisted_df) <- column_names
  
  # Store the dataframe in the list
  unlisted_dfs[[i]] <- unlisted_df
}

# Bind the dataframes column-wise to create the final dataframe
final_df_3 <- do.call(cbind, unlisted_dfs)



# Merge data frames
bind_df <- rbind(final_df_1, final_df_2,  final_df_3)
# Export the dataframe to a CSV file
write.csv(bind_df, "output1.csv", row.names = FALSE)

# Extract unique values from the "Value" column
unique_values <- unique(bind_df$project_id)

# Subset the dataframe to include only projects not present in the previous list
projects_2 <- subset(projects, !(project_id %in% unique_values))

