# Code Book

##  Source Data
Raw data for this project can downloaded [from here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

## Data Processing Pipeline
`run_analysis.R` does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Variables
- `xTrain`, `yTrain`, `xTest`, `yTest`, `subjectTrain`, and `subjectTest` contain data from the original raw data files. `features` is used to provide correct feature names for `xTrain` and `xTest` datasets.
- `trainData` and `testData` contain merged data for the train and test sets.
- `allData` is the set obtained from merging `trainData` and `testData`.
- `finalData` is the set obtained from `allData` by keeping only measurements on the mean and standard deviation for each measurement.
- `replacements` is used to give descriptive activity names to name the activities in the `finalData` data set.
- `tidyData` is a second, independent tidy data set obtained from `finalData` with the average of each variable for each activity and each subject.
