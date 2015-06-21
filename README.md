# tidydataset
Getting and Cleaning Data Project

run_analysis.R first loads 2 librarys: dplyr and plyr. Please note that these  packages should be installed before loading them.
The script assums that the "UCI HAR Dataset" is located in the R working directory.
It first loads all the training and test data and then merges the test and training data (STEP 1)
It then renames the dataset column headers with the column "V2" in the "feature" data set (STEP 4)
It then removes all duplicate columns which are not required as part of this assignment and can cause issues (STEP 2)
It then gets all columns with "mean()" in their name and also gets all columns with "sd()" in their name
It then combines the "mean()" and "sd()" columns to create a new dataset
It then changes the dataset column names with valid R names.
STEP 3 tries to merge "y" and "activity_labels" in the right order
Activity and Subject columns are attached to the dataset then.
In STEP 5 the dataset will be groupd by "Subject" and "Activity" and the average of the columns will be calculate for each 
subject and activity group.
At the end the tidy data set column names will be set to be the same as the extracted data set.
