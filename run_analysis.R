library(dplyr)
library(tidyr)

## Loading data
activity_labels <- read.table(file = "UCI HAR Dataset/activity_labels.txt", sep = " ", stringsAsFactors = FALSE)

X_train <- read.table(file = "UCI HAR Dataset/train/X_train.txt", sep = "\t", stringsAsFactors = FALSE)
y_train <- read.table(file = "UCI HAR Dataset/train/y_train.txt", sep = "\n", stringsAsFactors = FALSE)
subject_train <- read.table(file = "UCI HAR Dataset/train/subject_train.txt", sep = "\n", stringsAsFactors = FALSE)

X_test <- read.table(file = "UCI HAR Dataset/test/X_test.txt", sep = "\n", stringsAsFactors = FALSE)
y_test <- read.table(file = "UCI HAR Dataset/test/y_test.txt", sep = "\n", stringsAsFactors = FALSE)
subject_test <- read.table(file = "UCI HAR Dataset/test/subject_test.txt", sep = "\n", stringsAsFactors = FALSE)

## Binding train and test data sets
X <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

## Extracting mean and standard deviation for each measurement
my_data <- data.frame(array(dim = c(0, 3)))
for (i in 1:nrow(X)) {
  num_row <- X$V1[i] %>%
    strsplit(split = " ") %>%
    sapply(as.numeric)
  
  my_data <- rbind(my_data, c(mean(num_row, na.rm = TRUE), sd(num_row, na.rm = TRUE)))
}

## Binding extracted measurements with subject and activity data
my_data <- cbind(subject, y, my_data)

## Adding new variable names
names(my_data) <- c("subject", "activity", "mean", "sd")

## Adding descriptive activity names
my_data$activity <- sapply(my_data$activity, function(x) { activity_labels$V2[activity_labels$V1 == x] })

## Preparing tidy data set
my_data$subject <- factor(x = my_data$subject)
my_data$activity <- factor(x = my_data$activity, levels = activity_labels$V2)

my_tidy_data <- my_data %>%
  group_by(subject, activity) %>%
  summarise(average_mean = mean(mean), average_sd = mean(sd)) %>%
  gather(measurement, result, average_mean:average_sd) %>%
  arrange(subject, activity)
