library(dplyr)

# read features names
features <- read.table("./UCI HAR Dataset/features.txt")[, 2]

# read data for the train set
xtrain <- read.table(
    "./UCI HAR Dataset/train/X_train.txt", 
    col.names=features, header=FALSE
)
xtrain <- xtrain[ , grepl("mean|std", names(xtrain))]
ytrain <- read.table(
    "./UCI HAR Dataset/train/y_train.txt",
    col.names = "activity"
)
subject_train <- read.table(
    "./UCI HAR Dataset/train/subject_train.txt",
    col.names="subject"
)

# read data for the test set
xtest <- read.table(
    "./UCI HAR Dataset/test/X_test.txt", 
    col.names=features, header=FALSE
)
xtest <- xtest[ , grepl("mean|std", names(xtest))]
ytest <- read.table(
    "./UCI HAR Dataset/test/y_test.txt",
    col.names = "activity"
)
subject_test <- read.table(
    "./UCI HAR Dataset/test/subject_test.txt", 
    col.names="subject"
)

# merge train and test set into the one data set
df <- rbind(cbind(xtrain, ytrain, subject_train), cbind(xtest, ytest, subject_test))

# use descriptive activity names to name the activities in the data set 
activitylabels <- read.table(
    "./UCI HAR Dataset/activity_labels.txt", col.names = c("activitynum", "activity")
)
df$activity <- activitylabels$activity[match(df$activity, activitylabels$activitynum)]

# prepare tidy data set
tidydf <- as_tibble(df) %>% 
    group_by(subject, activity) %>% 
    summarise(across(contains(c("mean", "std")), mean, .names = "avg_{.col}"))

# write tidy data set into a file
write.table(tidydf, file="tidy.txt", row.names = FALSE)
