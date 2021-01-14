# Set working directory
setwd("C:/Users/Luis Maria Rodriguez/Desktop/DataScience")

# Loading required packages
library(dplyr)

# --------------------------------------------------------
# Download data set

fileName <- "courseProject.zip"
# Checking if file already exists
if (!file.exists(fileName)) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, fileName)
}
# Checking if folder already exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(fileName) 
}

# --------------------------------------------------------
# Reading data frames

activities <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("n","feature"))

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "code")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$feature)

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "code")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$feature)

# --------------------------------------------------------
# 1) Merges the training and the test sets to create one data set

subject <- rbind(subject_train, subject_test)
y <- rbind(y_train, y_test)
x <- rbind(x_train, x_test)
data <- cbind(subject, y, x)

# --------------------------------------------------------
# 2) Extracts only the measurements on the mean and standard deviation for each measurement

data <- select(data, subject, code, contains("mean"), contains("std"))

# --------------------------------------------------------
# 3) Uses descriptive activity names to name the activities in the data set

data$code <- activities[data$code, 2]

# --------------------------------------------------------
# 4) Changes labels the data set with descriptive variable names

names(data) <- gsub("code", "activity", names(data))
names(data) <- gsub("^t", "Time", names(data))
names(data) <- gsub("^f", "Frequency", names(data))
names(data) <- gsub("Acc", "Accelerometer", names(data))
names(data) <- gsub("Gyro", "Gyroscope", names(data))
names(data) <- gsub("Mag", "Magnitude", names(data))
names(data) <- gsub("-mean()", "Mean", names(data), ignore.case = TRUE)
names(data) <- gsub("-std()", "STD", names(data), ignore.case = TRUE)
names(data) <- gsub("-freq()", "Frequency", names(data), ignore.case = TRUE)
names(data) <- gsub("BodyBody", "Body", names(data))
names(data) <- gsub("angle", "Angle", names(data))
names(data) <- gsub("gravity", "Gravity", names(data))

# --------------------------------------------------------
# 5) From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject

newData <- data %>% group_by(subject, activity) %>% summarise_all(mean)
write.table(newData, "newData.txt", row.name=FALSE)