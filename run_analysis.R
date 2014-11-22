
############################
## Getting and cleaning data course - final project
## Author: Edgar Hamon          11/13/2014
############################  

# Asumptions:
# 1. Data file MUST be stored in the working directory.
# 2. link for data dawnload: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 3. package "data.table" must be installed

# Objective:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

dir <- getwd()      # working directory
library(data.table)


##### files to read subject_test.txt, X_test.txt, y_test.txt and subject_train.txt, X_train.txt and y_train.txt. 

## reading data
# test
subject_test <- read.table("subject_test.txt")
# - 'test/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
x_test <- read.table("X_test.txt")
# 'test/X_test.txt': Test data set
y_test <- read.table("y_test.txt")
# 'test/y_test.txt': Test labels. 
features <- read.table("features.txt",stringsAsFactors=FALSE)
# 'features' names of data columns

## training
subject_train <- read.table("subject_train.txt")
# - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
x_train <- read.table("X_train.txt")
# 'train/X_test.txt': train data set
y_train <- read.table("y_train.txt")
# 'train/y_test.txt': Test labels. 

names(subject_test)[1] <- "subject" ## change column name
names(y_test)[1] <- "activity"
names(subject_train)[1] <- "subject" ## change column name
names(y_train)[1] <- "activity"

#####  merges all test & train plain data with subject and activity
x_test <- cbind(x_test,subject_test)
x_test <- cbind(x_test,y_test)
x_train <- cbind(x_train,subject_train)
x_train <- cbind(x_train,y_train)

alldata <- rbind(x_train,x_test) # joins test and train data


##### extracts only columns which name contains "mead" or "std". 

col <- append(grep("mean",features$V2), grep("std",features$V2))  # joins the vectors


##### create data with only columns selected in above step

mydata <- alldata[col[1]]
for (i in 1:79) {
        
        mydata[i] <- alldata[col[i]]      # select only mean or std columns      
        names(mydata)[i] <- features[col[i],2]  # asigns appropiate name
                
}
## now joins subject and activity
mydata$subject <- alldata$subject
mydata$activity <- alldata$activity



## asign descriptive names to actitities
## activities: 1-Walking, 2-Walking upstairs, 3-Walking downstairs, 4-Sitting, 5-Standing, 6-Laying

mydata$activity[mydata$activity == 1] <- "WALKING"
mydata$activity[mydata$activity == 2] <- "WALKING_UPSTAIRS"
mydata$activity[mydata$activity == 3] <- "WALKING_DOWNSTAIRS"
mydata$activity[mydata$activity == 4] <- "SITTING"
mydata$activity[mydata$activity == 5] <- "STANDING"
mydata$activity[mydata$activity == 6] <- "LAYING"


## create tidy data with avegare(mean) for all selected columns by activity and subject 

finaldt <- data.table(mydata)      # convierte data.frame a data.table
finaldt <- finaldt[, lapply(.SD, mean), by = c("activity", "subject")]  # calcula avegare (mean) by activity and subject
finaldt <- finaldt[order(activity,subject)]  ## ordena data table by activity and subject for easy review

## write final file in working directory

write.table(finaldt, file="data_final.txt",row.name=FALSE)

## to read final file, use this command data <- read.table("data_final.txt", header = TRUE) 



