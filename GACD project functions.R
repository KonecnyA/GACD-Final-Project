## Purpose of this function is to create a data frame from a text file with meaningful variable names
load_data_frame <- function(file_path, file_name, colnames) {
  read.table(paste(file_path, file_name, ".txt", sep = ""), col.names = colnames, check.names = FALSE)
}

## Purpose of this function is to take a data frame, select a range of columns, write a csv file and verify the written file.
write_and_check <- function(data_frame, column_range_start, column_range_end, file_path, file_name) {
  ## Create a test check sum - Before
  write_sum <- sum(data_frame[column_range_start : column_range_end]); print(paste("The write ",file_name," checksum is ", as.integer(write_sum), sep = ""))
  
  ## Write the final tidy dataset as a csv file
  write.csv(data_frame, paste(file_path, file_name, ".csv", sep = ""), row.names = FALSE) 
  
  ## Read the final tidy dataset csv just created
  df_written_file <- read.csv(paste(file_path, file_name, ".csv", sep = ""))
  
  ## Create a test check sum - After
  read_sum <- sum(df_written_file[column_range_start : column_range_end]); print(paste("The read ",file_name," checksum is ", as.integer(read_sum), sep = ""))
  
  ## Status of written file?
  if (all.equal(write_sum, read_sum)) {
    print(paste("The checksums are equal so the write and read of ", file_name, ".csv is fine.", sep = ""))
  } else {
    print(paste("The checksums are not equal so there was a problem with the write or read of ", file_name, ".csv.", sep = ""))
  }
}