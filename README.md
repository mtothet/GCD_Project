# GCD_Project
Course Project for Getting and Cleaning Data on Coursera

## R and additional packages
R: version 3.2.3 (2015-12-10) -- "Wooden Christmas-Tree"

dplyr: version 0.4.3

tidyr: version 0.3.1

## Script files
run_analysis.R

## Input data files
All data files should be located in "UCI HAR Dataset" directory.

## Script description
1. Data is loaded from files in following order: 
  * activity_labels.txt,
  * train/X_train.txt,
  * train/y_train.txt,
  * train/subject_train.txt,
  * test/X_test.txt,
  * test/y_test.txt,
  * test/subject_test.txt,
  * files from the "Inertial Signals" directory are omitted.

2. Train and test data sets are merged together:
  * X_train and X_test,
  * y_train and y_test,
  * subject_train nad subject_test.

3. Mean and standard deviation for each measurement are extracted into new data frame.

4. Subject numbers and activity data are merged with previously extracted measurements.

5. Variables are named properly.

6. Activity names are used instead of activity codes.

7. Subject numbers and activity names are converted to factors.

8. New independent tidy data set is created, with the average of each variable for each activity and each subject.
