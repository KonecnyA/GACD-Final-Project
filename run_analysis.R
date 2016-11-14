## Getting and Cleaning Data Course - Week 4 - Assignment / Project
## This is "run_analysis.R" - GACD project functions.R, README.md and CodeBook.md also in the repo

## Set working directory, check and get raw data if required.
work_dir <- "C:/R/Coursera/Tidy Data"
setwd(work_dir)

## Load up functions I have created to facilitate the project
source("GACD project functions.R")

## Location of data
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## Test if directory exists - if no download and unzip files, if yes skip.
if(!file.exists("UCI HAR Dataset")) {
  download.file(file_url, destfile = "Dataset.zip")
  unzip("Dataset.zip")
}

## Set some helpful paths to work with unzipped data
root_path <- "UCI HAR Dataset//"
test_path <- paste(root_path, "test//", sep = "")
train_path <-  paste(root_path, "train//", sep = "")

## Load activity labels, feature variable names and set meaningful column names.
df_activity_labels <- load_data_frame(root_path, "activity_labels", c("activity_Number", "activity"))
df_features <- load_data_frame(root_path, "features",c("feature_number", "feature_variable_name"))

## Create preliminary test data frame from subject, X, y and set meaningful column names.
## This data frame represents approximately 30% of 30 volunteers data.
df_subject_test <- load_data_frame(test_path, "subject_test", "subject_id")
## "check.names = FALSE" preserves variable names.
df_X_test <- load_data_frame(test_path, "X_test", df_features$feature_variable_name)
df_y_test <- load_data_frame(test_path, "y_test", "activity")
df_test <- cbind(df_subject_test, df_y_test, df_X_test)

## Create preliminary training data frame from subject, X, y and set meaningful column names.
## This data frame represents approximately 70% of 30 volunteers.
df_subject_training <- load_data_frame(train_path, "subject_train", "subject_id")
df_X_training <- load_data_frame(train_path, "X_train", as.vector(df_features$feature_variable_name))
df_y_training <- load_data_frame(train_path, "y_train", "activity")
df_training <- cbind(df_subject_training, df_y_training, df_X_training)

## Housekeeping - remove objects no longer required.
rm(df_subject_test, df_subject_training, df_X_test, df_X_training, df_y_test, df_y_training)

## Execute 5 Getting and Cleaning Course Project STEPS to achieve the 3 requirements of tidy data.
## STEP 1. Merge training and test to create a total data frame.
df_total <- rbind(df_training, df_test)

## STEP 2. Extract variables with "-mean()" & "-std()" measurements.
##         Variables containing "-meanFreq()") will not be selected.
## "select_names" is assigned the result of the "toMatch" search.
select_names <- unique(grep(paste(c("-mean\\(\\)","-std\\(\\)"),collapse="|"), df_features$feature_variable_name, value=TRUE))

## Subset the data frame keeping the variables requested: subject_id, activity and select_names (search result).
df_total <- df_total[, c("subject_id", "activity", select_names)]

## STEP 3. Use descriptive activity names to name the activities in the data set.
df_total$activity <- factor(df_total$activity, labels = df_activity_labels$activity)

## STEP 4. Appropriately label the data set with descriptive variable names.
## Decided to follow Hadley Wickham's style guide - http://stat405.had.co.nz/r-style.html - lowercase_underscore_separated
names(df_total) <- gsub("^t", "time", names(df_total))         ## Time is more meaningful than t
names(df_total) <- gsub("^f", "frequency", names(df_total))    ## Frequency is more meaningful than f
names(df_total) <- gsub("BodyBody", "body", names(df_total))   ## Body vs BodyBody
names(df_total) <- gsub("mean\\(\\)", "Mean", names(df_total)) ## Mean vs possible confusion a function call mean()
names(df_total) <- gsub("std\\(\\)", "Std", names(df_total))   ## Std vs possible confusion a function call std()
names(df_total) <- gsub("-", "" , names(df_total))             ## Underscore "_" vs possible Subtract confusion "-"
names(df_total) <- gsub("([A-Z])", "_\\1", names(df_total))    ## Convert to underscore_separated
names(df_total) <- tolower(names(df_total))                    ## Ensure all text is lowercase

## STEP 5. Create a second, independent tidy dataset
##         with the average of each variable for each activity and each subject_id.
library(plyr)
df_tidy_data <- ddply(df_total,c("activity", "subject_id"), colwise(mean))

write_and_check(df_tidy_data, 3, 68, "UCI HAR Dataset//", "tidydata")

## Final housekeeping, clean up the memory
rm(list=ls())