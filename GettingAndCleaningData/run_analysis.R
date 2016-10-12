### The data set for this project was downloaded and extracted in the working
### directory: "C:/Users/Douglas/Desktop/DataScience/Getting and Cleaning Data
### Course Project"
library(plyr)

### Step 1: Merges the training and test sets to create one data set

# Read in the .txt files
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# create the data sets
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

### Step 2: Extracts only the measurements on the mean and standard deviation
### for each measurement

# Read in the .txt file
features <- read.table("UCI HAR Dataset/features.txt")

# return only columns with mean() or std() in their names
features_mean_std <- grep("-(mean|std)\\(\\)", features[, 2])

# use column numbers to return measurements with mean() or std()
x_data <- x_data[, features_mean_std]

# change column numbers with names
names(x_data) <- features[features_mean_std, 2]

### Step 3: Uses descriptive activity names to name the activities in
### the data set

# Read in the .txt file
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

# assign values with the correct activity names
y_data[, 1] <- activity_labels[y_data[, 1], 2]

# change the column name
names(y_data) <- "activity"

### Step 4: Appropriately labels the data set with descriptive variable names

# change to correct column name
names(subject_data) <- "subject"

# combine all the pieces into a single dataset
final_data <- cbind(x_data, y_data, subject_data)

### Step 5: From the data set in step 4, creates a second, independent tidy
### data set with the average of each variable for each activity and
### each subject

# 66 columns of measurements -- columns 67 and 68 are activity and subject
avg_data <- ddply(final_data, .(subject, activity), 
                       function(x) colMeans(x[, 1:66]))

write.table(avg_data, "avg_data.txt", row.name=FALSE)
