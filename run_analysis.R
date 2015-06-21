library(dplyr)
library(plyr)

# Load data sets
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

# STEP 1 - Merge data sets
dataset <- rbind(x_train, x_test)
subject <- rbind(subject_train, subject_test)
y <- rbind(y_train, y_test)

# STEP 4 of the assignment - Label data set column headers with descriptive variavle names 
names(dataset) <- features$V2  

# STEP 2 of the assignment - Extract mean and standard deviation
dataset_no_duplicate <- dataset[!duplicated(names(dataset))]
mean <- select(dataset_no_duplicate, contains("mean()"))
sd <- select(dataset_no_duplicate, contains("std()"))
extract_dataset <- cbind(mean, sd)
names(extract_dataset) <- make.names(names(extract_dataset))

# STEP 3 of the assignment - Descriptive Activity names in the data set
Activity <- sapply(y$V1, function(x,y) {return (y[[x]])}, activity_labels$V2)
extract_dataset <- cbind(Activity, extract_dataset)

# Combine data set and Subjects
subject <- dplyr::rename(subject, Subject=V1)
extract_dataset <- cbind(subject, extract_dataset)

# STEP 5 of the assignment - Independent tidy data set with the average of ....
tidy_dataset <- ddply(extract_dataset, .(Subject, Activity), function(p) {
                meanColumn <- c()
                for(i in 3:68) {
                       meanColumn[i - 2] <- mean(p[[i]])
                }
                meanColumn
        }) 

names(tidy_dataset) <- names(extract_dataset)

