# Getting and Cleaning Data Course Project
####Welcome!
This repository is dedicated to the course project for Coursera's "Getting and Cleaning Data" course. The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.
####Background and Dataset Used
One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
####Instructions for the Project
You should create one R script called run_analysis.R that does the following: 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

####Repository Files
`CodeBook.md` describes the variables, the data, and any transformations or work that is performed to clean up the data. `run_analysis.R` contains the .R code used for the analysis as described above. `avg_data.txt` is the output file produced from step 5. This analysis can be reproduced by downloading the dataset from the link above and extracting the files into the current working directory of RStudio. Load `run_analysis.R` and run. 
