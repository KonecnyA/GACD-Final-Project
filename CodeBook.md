# CodeBook - Getting and Cleaning Data Course Project #

## Project Requirements ##
- Modify and Update available code books with the data
- Indicate all variables and summaries calculated, along with units
- Describe the variables, the data, and any transformations or work performed to clean data
- Add any other relevant information

## Introduction ##
The focus of this text is to document source data (observations, variables and linkages of datasets), any transformations on the data and finally to document a final tidy dataset (which meets the 3 requirements), ready to perform analytics. For documentation on my run\_analysis.R script use this link [README](https://github.com/KonecnyA/GACD-Final-Project/blob/master/README.md) .

## CodeBook Essentials ##
- Study description
	- Who?
	- Why?
	- How?
- Sample information
	- What population studied?
	- How sample drawn?
	- What was the response rate?
- Technical file information
	- Number of observations
	- Record length
	- Number of records per observation
- Structure of the data within the file
- Details about the data
	- Columns in which specific variables can be found
	- Character or numeric?
	- If numeric, what format?
- Text of questions and responses

[Reference](http://dss.princeton.edu/online_help/analysis/codebook.htm)

## Source Information, Data, License & Citation ##

- Exciting Data Science wearable computing for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/)
- **Study Description & Sample Information** - Data collected from the accelerometers from the Samsung Galaxy S smartphone [description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
- UCI HAR Dataset.zip (source data) [zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). UCI - University of California, Irvine & HAR - Human Activity Recognition
- Citation Policy:
If you publish material based on databases obtained from this repository, then, in your acknowledgements, please note the assistance you received by using this repository. This will help others to obtain the same data sets and replicate your experiments. We suggest the following pseudo-APA reference format for referring to this repository: Lichman, M. (2013). UCI Machine Learning Repository [http://archive.ics.uci.edu/ml]. Irvine, CA: University of California, School of Information and Computer Science. 


## Dataset.zip (files of interest & Technical Information) ##
1. UCI HAR Dataset\activity_labels.txt - text file: 6 obs. of 2 vars.
1. UCI HAR Dataset\features.txt - text file: 561 obs. of 2 vars.
1. UCI HAR Dataset\features_into.txt - text file: explains the features variables
1. UCI HAR Dataset\README.txt - text file: explains Human Activity Recognition Using Smartphones Dataset
1. UCI HAR Dataset\test\subject_test.txt - text file: 2947 obs. of 1 var.
1. UCI HAR Dataset\test\X_test.txt - text file: 2947 obs. of 561 vars.
1. UCI HAR Dataset\test\y_test.txt - text file: 2947 obs. of 1 var.
1. UCI HAR Dataset\train\subject_train.txt - text file: 7352 obs. of 1 var.
1. UCI HAR Dataset\train\X_train.txt - text file: 7352 obs. of 561 vars.
1. UCI HAR Dataset\train\y_train.txt - text file: 7352 obs. of 1 var.


## Getting Data ##
I used "read.table" to input required text files and created a function "df_Info()" which had many of the class suggestions to do the initial exploration of the data frames created while I was iteratively writing and changing the script. Where possible, on the initial load of the data frame, I assigned meaningful column names using "col.names = " 
## Initial Data Frames
1. df\_activity\_labels - 6 obs. of activity\_number(int) and activity(Factor)
1. df\_features - 561 obs. of feature\_number(int) and feature\_variable\_name(Factor)
1. df\_subject\_test - 2947 obs. of subject\_id(int) from 1 to 30 (30 Volunteers)
1. df\_X\_test - 2947 obs. of 561 variables(num) as documented in "features.txt"
1. df\_y\_test - 2947 obs. of activity(int) from 1 to 6 (6 Activities)
1. df\_test - merge of above 3 data frames, 2947 obs. subject\_id(int), activity(int) & 561 variables(num) as documented in features.txt
1. df\_subject\_training - 7352 obs. of subject\_id(int) from 1 to 30 (30 Volunteers)
1. df\_X\_training - 7352 obs. of 561 variables(num) as documented in features.txt
1. df\_y_\training - 7352 obs. of activity(int) from 1 to 6 (6 Activities)
1. df\_training - merge of above 3 data frames, 7352 obs. subject\_id(int), activity(int) & 561 variables(num) as documented in "features.txt"

## Structure of Data##
There is a set of test files (subject, X and y) and train files (subject, X and y).  I am assuming that when loaded they are in the correct order to merge. The subject file has a subject\_id(int) for every single row (observation). The y file has an activity(Factor) for every single row (observation).  The X file has all the feature measurements (561 num) for every single row (observation).  When the columns are merged together then the result has subject\_id, activity and 561 feature measurements.

## Cleaning Data (Transformations) ##
### STEP 1 Ask: Merge the training and the test sets to create one data set. ###
Created data frame df\_total which is a merge of df\_test (approximately 30% of data) and df\_training (approximately 70% of data) to have 100% of data in a single file. There are 10299 obs. of 563 vars. subject\_id(int), activity(int) and 561 variables(num) as documented in "features.txt" .

### STEP 2 Ask: Extract only the measurements on the mean and standard deviation for each measurement. ###
Changed df\_total data frame to have 10299 obs. and 68 vars. Retain subject\_id(int) and activity(int) plus 66 vars. identified by searching those with -mean() and -std(). Please note that my interpretation of the assignment ask will not include -meanFreq().

**Details about the data** - these original feature variables are of the form the form (f | t)(Body | Gravity)(Acc | Gyro)(Jerk | Mag)(-mean() | -std())( | -X | -Y | -Z).

- t is time
- f is the frequency
- Body and Gravity are reference frames
- Acc is the accelerometer
- Gyro is the gyroscope
- Mag is the euclidean magnitude
- -mean() is the average value
- -std() is the standard
- X, Y & Z represent 3-axial signals
- deviation Jerk, where present, is the jerk signal, as opposed to smooth signal (everything else)


66 retained feature variables:

1. "tBodyAcc-mean()-X"          
1. "tBodyAcc-mean()-Y"          
1. "tBodyAcc-mean()-Z"          
1. "tBodyAcc-std()-X"           
1. "tBodyAcc-std()-Y"           
1. "tBodyAcc-std()-Z"           
1. "tGravityAcc-mean()-X"       
1. "tGravityAcc-mean()-Y"       
1. "tGravityAcc-mean()-Z"       
1. "tGravityAcc-std()-X"        
1. "tGravityAcc-std()-Y"        
1. "tGravityAcc-std()-Z"        
1. "tBodyAccJerk-mean()-X"      
1. "tBodyAccJerk-mean()-Y"      
1. "tBodyAccJerk-mean()-Z"      
1. "tBodyAccJerk-std()-X"       
1. "tBodyAccJerk-std()-Y"       
1. "tBodyAccJerk-std()-Z"       
1. "tBodyGyro-mean()-X"         
1. "tBodyGyro-mean()-Y"         
1. "tBodyGyro-mean()-Z"         
1. "tBodyGyro-std()-X"          
1. "tBodyGyro-std()-Y"          
1. "tBodyGyro-std()-Z"          
1. "tBodyGyroJerk-mean()-X"     
1. "tBodyGyroJerk-mean()-Y"     
1. "tBodyGyroJerk-mean()-Z"     
1. "tBodyGyroJerk-std()-X"      
1. "tBodyGyroJerk-std()-Y"      
1. "tBodyGyroJerk-std()-Z"      
1. "tBodyAccMag-mean()"         
1. "tBodyAccMag-std()"          
1. "tGravityAccMag-mean()"      
1. "tGravityAccMag-std()"       
1. "tBodyAccJerkMag-mean()"     
1. "tBodyAccJerkMag-std()"      
1. "tBodyGyroMag-mean()"        
1. "tBodyGyroMag-std()"         
1. "tBodyGyroJerkMag-mean()"    
1. "tBodyGyroJerkMag-std()"     
1. "fBodyAcc-mean()-X"          
1. "fBodyAcc-mean()-Y"          
1. "fBodyAcc-mean()-Z"          
1. "fBodyAcc-std()-X"           
1. "fBodyAcc-std()-Y"           
1. "fBodyAcc-std()-Z"           
1. "fBodyAccJerk-mean()-X"      
1. "fBodyAccJerk-mean()-Y"      
1. "fBodyAccJerk-mean()-Z"      
1. "fBodyAccJerk-std()-X"       
1. "fBodyAccJerk-std()-Y"       
1. "fBodyAccJerk-std()-Z"       
1. "fBodyGyro-mean()-X"         
1. "fBodyGyro-mean()-Y"         
1. "fBodyGyro-mean()-Z"         
1. "fBodyGyro-std()-X"          
1. "fBodyGyro-std()-Y"          
1. "fBodyGyro-std()-Z"          
1. "fBodyAccMag-mean()"         
1. "fBodyAccMag-std()"          
1. "fBodyBodyAccJerkMag-mean()"
1. "fBodyBodyAccJerkMag-std()"  
1. "fBodyBodyGyroMag-mean()"    
1. "fBodyBodyGyroMag-std()"     
1. "fBodyBodyGyroJerkMag-mean()"
1. "fBodyBodyGyroJerkMag-std()"

### STEP 3 Ask: Use descriptive activity names to name the activities in the data set###
Changed df\_total data frame variable Activity(int) to Activity(Factor). Factors in R are stored as a vector of integer values with a corresponding set of character values to use when the factor is displayed.

Activities:

1. WALKING
1. WALKING\_UPSTAIRS
1. WALKING\_DOWNSTAIRS
1. SITTING
1. STANDING
1. LAYING	 

### STEP 4 Ask: Appropriately label the data set with descriptive variable names ###

Using Hadley Wickham' style guide to improve the variable names.  Essentially I use lower case and underscores to seperate words. Implemented the following changes to original variable names, working left to right:

- leading lower case "t" becomes "time"
- leading lower case "f" become "frequency"
- "BodyBody" becomes "Body"
- "mean()" becomes "Mean"
- "std()" becomes "Std"
-  any dashes "-" become blank
-  any capital is converted to underscore + capital
-  label converted to lowercase

These variables become of the form (frequency | time)\_(body | gravity)\_(acc | gyro)( &| \_jerk &| \_mag)(_mean | _std)( | _x | _y | _z)

New feature variable labels in same order as original feature labels above:

1. "time\_body\_acc\_mean_x"            
1. "time\_body\_acc\_mean\_y"
1. "time\_body\_acc\_mean\_z"
1. "time\_body\_acc\_std\_x"
1. "time\_body\_acc\_std\_y"
1. "time\_body\_acc\_std\_z"
1. "time\_gravity\_acc\_mean\_x"
1. "time\_gravity\_acc\_mean\_y"
1. "time\_gravity\_acc\_mean\_z"
1. "time\_gravity\_acc\_std\_x"
1. "time\_gravity\_acc\_std\_y"
1. "time\_gravity\_acc\_std\_z"
1. "time\_body\_acc\_jerk\_mean\_x"
1. "time\_body\_acc\_jerk\_mean\_y"
1. "time\_body\_acc\_jerk\_mean\_z"
1. "time\_body\_acc\_jerk\_std\_x"
1. "time\_body\_acc\_jerk\_std\_y"
1. "time\_body\_acc\_jerk\_std\_z"
1. "time\_body\_gyro\_mean\_x"
1. "time\_body\_gyro\_mean\_y"
1. "time\_body\_gyro\_mean\_z"
1. "time\_body\_gyro\_std\_x"
1. "time\_body\_gyro\_std\_y"
1. "time\_body\_gyro\_std\_z"
1. "time\_body\_gyro\_jerk\_mean\_x"
1. "time\_body\_gyro\_jerk\_mean\_y"
1. "time\_body\_gyro\_jerk\_mean\_z"
1. "time\_body\_gyro\_jerk\_std\_x"
1. "time\_body\_gyro\_jerk\_std\_y"
1. "time\_body\_gyro\_jerk\_std\_z"
1. "time\_body\_acc\_mag\_mean"
1. "time\_body\_acc\_mag\_std"
1. "time\_gravity\_acc\_mag\_mean"
1. "time\_gravity\_acc\_mag\_std"
1. "time\_body\_acc\_jerk\_mag\_mean"
1. "time\_body\_acc\_jerk\_mag\_std"
1. "time\_body\_gyro\_mag\_mean" 
1. "time\_body\_gyro\_mag\_std"
1. "time\_body\_gyro\_jerk\_mag\_mean"
1. "time\_body\_gyro\_jerk\_mag\_std" 
1. "frequency\_body\_acc\_mean\_x"
1. "frequency\_body\_acc\_mean\_y"
1. "frequency\_body\_acc\_mean\_z" 
1. "frequency\_body\_acc\_std\_x"
1. "frequency\_body\_acc\_std\_y"
1. "frequency\_body\_acc\_std\_z"
1. "frequency\_body\_acc\_jerk\_mean\_x"
1. "frequency\_body\_acc\_jerk\_mean\_y"
1. "frequency\_body\_acc\_jerk\_mean\_z"
1. "frequency\_body\_acc\_jerk\_std\_x"
1. "frequency\_body\_acc\_jerk\_std\_y"
1. "frequency\_body\_acc\_jerk\_std\_z" 
1. "frequency\_body\_gyro\_mean\_x"
1. "frequency\_body\_gyro\_mean\_y"
1. "frequency\_body\_gyro\_mean\_z"
1. "frequency\_body\_gyro\_std\_x"
1. "frequency\_body\_gyro\_std\_y"
1. "frequency\_body\_gyro\_std\_z" 
1. "frequency\_body\_acc\_mag\_mean"
1. "frequency\_body\_acc\_mag\_std"
1. "frequency\_body\_acc\_jerk\_mag\_mean" 
1. "frequency\_body\_acc\_jerk\_mag\_std" 
1. "frequency\_body\_gyro\_mag\_mean"
1. "frequency\_body\_gyro\_mag\_std"
1. "frequency\_body\_gyro\_jerk\_mag\_mean"
1. "frequency\_body\_gyro\_jerk\_mag\_std"

### STEP 5 Ask: From the data set in STEP 4, create a second, independent tidy data set with the average of each variable for each activity and each subject ###
A data frame of 180 rows (observations) and 68 variables represents the final tidy data file.  activity(Factor), subject\_id(int) and the 66 renamed feature variables(num) above constitute the 68 columns of the final file. The 180 rows represent 6 different activities by 30 different subjects (volunteers). The final value for each activity by subject by measurement is the average for each measurement variable.

## Tidy Data ##
As requested, the final gotten and cleaned data, the output of "run\_analysis.R", is written to a text file "tidydata.txt"

"The CodeBook is about the data, the README is about the code and run_analysis scripts my learning adventure."

© Andrew Konecny 2016 All Rights reserved.