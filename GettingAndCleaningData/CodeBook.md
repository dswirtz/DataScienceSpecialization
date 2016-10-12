#The CodeBook
A description of this file is broken down into three sections:

1. A description of the data in the raw form
2. A description of the variables used in the analysis
3. A description of the transfomrations used to clean up the data

##Data
The raw data file can be found here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This data is collected from the accelerometers from the Samsung Galaxy S smartphone. The experiments have been carried out with a group 
of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, 
WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) while wearing the phone on the waist. The obtained dataset has been randomly partitioned 
into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The goal of this project is to take all the components and merge them into a clean single dataset.

Additional information can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

##Variables
* `x_train`, `y_train`, `subject_train`, `x_test`, `y_test`, `subject_test` are all variables used to read in the raw files.
* `x_data`, `y_data`, `subject_data` are variables used to merge the components of x, y, and subject data.
* `features` reads in the data from `features.txt`which contains the column names for `x_data`.
* `features_mean_std` is a subset of `features` that contains all of the columns with mean() or std().
* `activity_labels` reads in the data from `activity_labels.txt` which contains the correct names for `y_data`.
* `final_data` merges `x_data`, `y_data`, and `subject_data` into a single dataset.
* `avg_data` is more compact version of `final_data` by averaging the columns based on subject and activity. This is later printed to a `.txt` file called `avg_data.txt`.

##Transformations
`run_analysis.R` performs the 5 steps as described in the `README.md`.
* The plyr package loads a set of clean and consistent tools that implement the split-apply-combine pattern in R.
* After all the components of the data are read in, the x-components, y-components, and subject-components are merged seperately using the `rbind()` function.
* To extract the columns with mean() or std(), the `grep()` function is used to match and extract from `features`, and is later applied to `x_data` using the `names()` function to change the column numbers with the correct names. 
* Similarly, the 6 activity labels are applied to the `y_data`, then using the `names()` function, the column name is changed to "activity"
* Using the `names()` function again, the column name for `subject_data` is changed to "subject"
* With all the components adjusted according to the instructions, the `cbind()` function is used to combine all the data into a neat dataset
* Finally, the `ddply()` function, along with the `colMeans()`function, is used on the `final_data` to average every column based on subject and activity. This is then used with the `write.table()` function to generate the output file `avg_data.txt`.
