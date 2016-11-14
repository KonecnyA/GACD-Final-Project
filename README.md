# README - Getting And Cleaning Data Course Project #
## Requirements ##
- Explain:
	- How do scripts work?
	- How are scripts connected?
- Submit:
	- A tidy data set (as described in project)
	- A link to a Github repository with your script for performing the analysis, run_analysis.R
	- A CodeBook.md
	- A README.md


## Introduction ##
The focus of this text is to document my journey and iterative coding of "run_analysis.R" .  This script is intended to collect, work with, and clean a data set to meet the 3 tidy requirements (i. Each variable forms a column. ii. Each observation forms a row. iii. Each type of obervational unit forms a table. Hadley Wickham).   For documentation on data and transformations use this link [CodeBook]("/README.md") .

## Background ##
- Prior to writing code:
	- Read Week 4 Project Assignment
	- Read suggested Data Science article Wearable Computing article
	- Read suggested data source article Human Activity Recognition Using Smartphones Data Set
	- Read Week 4 Course Forum
	- Read suggested article written by David Hood
	- Read code books with downloaded data
- My Setup:
	- Windows 8.1 Enterprise Operating System
	- R Version 3.3.2
	- RStudio Version 1.0.44

## run_analysis.R##
### Set working directory ###
I create and set a variable "work\_dir" so it is easy to run from another location or computer. Perhaps at this point I should mention I will be following for variable and function names lowercase underscore\_separated.

### Load my GACD project functions ###
I decided for both testing this feature of R and for readability to have some parts of the script as calls to my own functions.

### Download source data ###
If directory does not exist, download files and unzip. If directory exists, I assume what is needed by the script (project) is already in place.

### Helpful paths ###
I set three paths for root, test and train that will help me working with the unzipped data directory structure.

### Create Initial / Temporary data frames ###
I have well documented the source data loaded from text files into a series of data frames in my "CodeBook.md" . I create the data frames using "read.table" but through a function i built called "load\_data\_frame". Where possible I assign meaningful variable names using "col.names = ". As I iteratively wrote the script, it made sense to me to move this up in the sequence. I learned to use "check.names = FALSE" so that R would not change the feature variable names I was trying to initially apply.

My objective at this point in the script was to be ready to execute the 5 Project STEPS. So notably df\_test has approximately 30% of the data with the required columns and df\_training has approximately 70% of the data with the required columns. I also thought I should merge columns, "cbind()", after the load because my assumption is that the rows (observations) were in the correct order and in subsequent steps this could change.

In an early version of my script, I included a function I called "df_Info()". Perhaps not  a definitive list but class suggestions about functions to perform on data in order to learn about the data:

- head(df,n=3)
- tail(df,n=3
- dim(df)
- names(df)
- str(df)
- unique(df)
- table(df)
- summary(df)
- View(df) 

### Housekeeping###
Just take an opportune time, prior to the key project steps, to remove objects that will no longer be required.

### STEP 1 Ask: Merge the training and the test sets to create one data set. ###
Because we are grouping rows (observations) together I used "rbind()" to merge the training and test sets to create one total data set.

### STEP 2 Ask: Extract only the measurements on the mean and standard deviation for each measurement. ###
I used grep to search the list of feature variable names to find those that had "-mean()" and "-std()". This means I intentionally do not include "-meanFreq()". I kept the results of the search on select\_names.  I then subset the data frame keeping "subject\_id", "activity" and the 66 feature variables (confirmed this via "length(select\_names)") that resulted from the search.

### STEP 3 Ask: Use descriptive activity names to name the activities in the data set###
I reviewed some information on factor variables (categorical variables) and the factor function. This seemed the best way to make the activity names descriptive by converting the variable Activity from (int) to (Factor).

### STEP 4 Ask: Appropriately label the data set with descriptive variable names ###
As stated earlier, I decided for style: lowercase, underscore\_separated.  I used a series of gsub calls to iteratively scan and improve variable names. I changed lower case "t" and "f" to "time" and "frequency". I changed instances of "BodyBody" to "Body". I changed dash "-" to blank "" so no confusion with subtraction.  I changed "()" to blank "" so no confusion with functions. I then ensured an underscore between words or abbreviations (undoing a form of camelcase) and converted all to lowercase.

### STEP 5 Ask: From the data set in STEP 4, create a second, independent tidy data set with the average of each variable for each activity and each subject ###
I decided to use the plyr package. Given alternatives, I could understand how it would calculate the column wise average for each variable being requested.
In my call "ddply(df\_total,c("activity","subject\_id"), colwise(mean))". The first argument is the data frame to be processed. The second argument is the two variables to split the data frame by. The third argument "colwise()" turns a function, in this case mean, that operates on a vector into a function that operates column-wise on a data frame.

## Tidy Data ##
Before writing the tidy data to a file, I calculate a quick check sum which essentially adds together every numeric value in the file.  I decided to write a ".csv" file so that it would be easier for an analyst to load the tidy data. In order to validate that the file I wrote represents the tidy data I created earlier in the script, I read the file back in and calculate a check sum following the same formula.  If the two check sums are equal then it was a good write and read.  If the two check sums are not equal then further exploration would be required to determine if there is a write problem or a read problem. As a last step I do final housekeeping by cleaning up the memory.

## Closing Thoughts ##
- Possibly add more error checking and sophistication to downloading and unzipping data
- Possibly subset data earlier so working with smaller files
- Possibly add student\_id and activity variables (columns) later to smaller data set.
- Possibly use chaining to avoid creating what amounts to a number of temporary objects (data frames, vectors and variables)
- Possibly cleanup variable names earlier so they can be mapped when data frame is first created
- Possibly use dplyr package (small functions that work well) and "data frame tlb" or "tbl_df" - for speed, readability and simplicity
- come back and improve this code when I have learned and applied more in my Data Science Certification Journey

*"The CodeBook is about the data, the README is about the code and run\_analysis scripts my learning adventure."*

© Andrew Konecny 2016 All Rights reserved.