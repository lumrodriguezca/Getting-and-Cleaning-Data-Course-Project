The run_analysis.R script allows us to prepare and order the data set 
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
for further analysis, as follows:
0.	Workspace is prepared
      Loading dplyr library
1.  Download the dataset
      The .zip file is downloaded and extracted in the UCI HAR Dataset folder
2.	Read and assign each data frame to a variable
      - Variable: Activities
        file: activity_labels.txt 
        dimensions: 6 rows, 2 columns
        description: List of activities performed when the corresponding measurements were taken
      - Variable: features 
        file: features.txt
        dimensions: 561 rows, 2 columns
        description:The features vector is obtained from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ
      -	Variable: subject_test
        file: test/subject_test.txt
        dimensions: 2947 rows, 1 column
        description: test data of 9/30 volunteer test subjects being observed
      -	Variable: y_test
        file: test/y_test.txt
        dimensions: 2947 rows, 1 column
        description: test data of activities’code labels
      -	Variable: x_test
        file: test/X_test.txt
        dimensions: 2947 rows, 561 column
        description: recorded features test data
      -	Variable: subject_train
        file: test/subject_train.txt
        dimensions: 7352 rows, 1 column
        description: train data of 21/30 volunteer subjects being observed
      -	Variable: y_train
        file: test/y_train.txt
        dimensions: 7352 rows, 1 column
        description: train data of activities’code labels
      -	Variable: x_train
        file: test/X_train.txt
        dimensions: 7352 rows, 561 column
        description: recorded features train data
3.	Merges the training and the test sets to create one data set
      -	Variable: subject
        dimensions: 7352 rows, 561 column
        description: is created by merging subject_train and subject_test using rbind() function.
      -	Variable: y
        dimensions: 10299 rows, 1 column
        description: is created by merging y_train and y_test using rbind() function
      -	Variable: x
        dimensions: 10299 rows, 561 column
        description: is created by merging x_train and x_test using rbind() function
      -	Variable: data
        dimensions: 10299 rows, 563 column
        description: is created by merging subject, y and x using cbind() function
4.	Extracts only the measurements on the mean and standard deviation for each measurement
      -	Variable: data
        dimensions: 10299 rows, 88 columns
        description: is created by subsetting data, selecting only columns: subject, code and the measurements on the mean and standard deviation for each measurement
5.	Uses descriptive activity names to name the activities in the data set
        Entire numbers in code column of the data replaced with corresponding activity taken from second column of the activities variable
6.	Appropriately labels the data set with descriptive variable names
      -	code column in data renamed into activities
      -	All start with character t in column’s name replaced by Time
      -	All start with character f in column’s name replaced by Frequency
      -	All Acc in column’s name replaced by Accelerometer
      -	All Gyro in column’s name replaced by Gyroscope
      -	All Mag in column’s name replaced by Magnitude
      -	All BodyBody in column’s name replaced by Body
7.	From the data set in last step, creates a second, independent tidy data set with the average of each variable for each activity and each subject
      -	Variable: data
        Dimensions: 180 rows, 88 columns
        Description: it is created by grouping by subject and activity, and then summarizing the data by taking the means of each variable for each activity and each subject.

