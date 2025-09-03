#Author: atamazian, 2025-09-03

library(dplyr)

# Read features names
features <- read.table("./UCI HAR Dataset/features.txt")[, 2]

# Read the train data
xTrain <- read.table(
    "./UCI HAR Dataset/train/X_train.txt", 
    col.names = features, header = FALSE
)
yTrain <- read.table(
    "./UCI HAR Dataset/train/y_train.txt",
    col.names = "activityID"
)
subjectTrain <- read.table(
    "./UCI HAR Dataset/train/subject_train.txt",
    col.names = "subjectID"
)

# Read the test data
xTest <- read.table(
    "./UCI HAR Dataset/test/X_test.txt", 
    col.names = features, header = FALSE
)
yTest <- read.table(
    "./UCI HAR Dataset/test/y_test.txt",
    col.names = "activityID"
)
subjectTest <- read.table(
    "./UCI HAR Dataset/test/subject_test.txt", 
    col.names = "subjectID"
)

# Merge the train and test data to one data set
trainData <- cbind(subjectTrain, xTrain, yTrain)
testData <- cbind(subjectTest, xTest, yTest)
allData <- rbind(trainData, testData)

# Leave only mean and std measurements
selCol <- grepl("activityID|subjectID|mean|std", colnames(allData))
finalData <- allData[, selCol]

# Use descriptive activity names to name activities in the data set 
activityLabels <- read.table(
    "./UCI HAR Dataset/activity_labels.txt", 
    col.names = c("activityID", "activityDesc")
)
finalData <- merge(
    finalData, activityLabels, by = "activityID", all.x = TRUE
)

# Use descriptive variable names to name variables in the data set
replacements <- list(
    "^t"       = "time",
    "^f"       = "frequency",
    "Acc"      = "Accelerometer",
    "Gyro"     = "Gyroscope",
    "Mag"      = "Magnitude",
    "BodyBody" = "Body"
)
for (pattern in names(replacements)) {
    colnames(finalData) <- gsub(
        pattern,
        replacements[[pattern]],
        colnames(finalData)
    )
}

# Create a second, independent tidy data set and write it to the file
tidyData <- finalData %>%
    group_by(subjectID, activityID, activityDesc) %>%
    summarize_all(mean)

write.table(tidyData, "tidy_data.txt", row.names = FALSE)
