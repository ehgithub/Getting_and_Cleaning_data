Getting_and_Cleaning_data
=========================

Repo for Getting and Cleaning data Coursera final project


**Introduction**

This is the final Coursera Getting and Cleaning Course project. The objective is to achieve the goals described in the "project objectives" seccion below.
This readme file will walk you through the process I followed.


**Data sources**

The data for the projects is coming from this site [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones][1]
The downdoable zip file is in this link:
[link text][2] 


**Study Description**

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.
Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments have been video-recorded to label the data manually. 
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). 
The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. 
The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used.
From each window, a vector of features was obtained by calculating variables from the time and frequency domain"


Detailed information about variables and summarization of those variables can be found in the “CodeBook” file in this Repo.


  [1]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  [2]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


**Project Objectives**


1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



**Run_analysis.r script description**

The run_anlaysis script contains the steps followed to accomplish the project objectives mentioned above.


 1. Script assumptions:

 a- Data files MUST be stored in the working directory. The script did not validate and not verify the existence of those files in the working directory. 
It assumes they can be found in the working directory.

 b- Package "data.table" must be installed in your R studio instance.


 2. Data files
Following files *MUST* be stored in the working directory:

 subject_test.txt  (2947 obs x 1 Variable)

 X_test.txt (2947 x 561) 

 y_test.txt  (2947 x 1)

 subject_train.txt (7352 x 1)

 X_train.txt (7352 x 561)

 y_train.txt (7352 x)

 if they are not stored, please save them in .txt format in your working directory from this zip file:
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip][1]

 Description of files and its variables can be found in CodeBook fie in this Repo

 3. Phase I. Reading data files

 The script reads the 6 data files above using read.table command

 4. Phase II.
 Assigns descriptive names to columns (variables) in files subjecttest and subject_train (to "subject")
and y_test and y_train (to "activity"), using names() command

 5. Phase III. Data Merge

 Using cbind command merges the test data files to obtain a one data frame with test data, activities and subjects altogether (x_test – 2947 x 563). 
And do the same operation with the train files to obtain one train data frame with train data, activities and subjects joined (x_train 7352 x 563).

 Once I have complete test and data frames,I merge the 2 data frames into one (alldata – 10299 x 563) using rbind command. 
This data set contains all rows from test and train datasets combined.

 I decided not to use merge() command because it re-arranges the data and that should not happen.

 *This phase accomplishes objective # 1 of the project.*


 6. Phase IV – extracts only measurements of mean and standard deviation
  
 Using features file as base, generates a vector (col – 79 elements) using grep() command
selecting only those measurements that contains “mean” and “std” as part of measurement name.

 Using a loop ( for{} ), it goes thru the col vector, and for each element, it generates a new data frame (mydata) with ONLY the columns in vector col. 
Remember, col vector only has measurements whose name contains “mean” or “std”. 
During the loop, it also label the column (variable) with descriptive variable names.

 The result is mydata data frame with 10299 obs x 79 variables. 
Note the number of variables (columns) was reduced from 563 to 79.

 And finally assigns the “subject” and “activity” colums to mydata. (10299 x 81)

 *This phase accomplishes objectives #2 and #4*


 7. Phase V. Uses descriptive activity names to name the activities in the data set

 I decided to do objective 4 before 3 because once I have all new data frame with good variable labels and only the desired columns,
to use descriptive values for the activities would be a lot easier.

 Activities descriptions are as follows: 
 1-Walking, 2-Walking upstairs, 3-Walking downstairs, 4-Sitting, 5-Standing, 6-Laying.

 *This phase accomplishes objective #3*


 8. Phase VI  - creates a second, independent tidy data set with the average of each variable for each activity and each subject.

 Using data.table function from data.table library it generates a new data.table(finaldt) with the average (mean) of all columns grouped by activity and subject.
For this purpose use laply command.

 It also sorts the new data table by activity and subject for easy further data analysis.

 Finally creates a new txt file (data_final.txt) in the working directory with this new tidy data.

 Note this is a wide tidy data.

 *This phase accomplishes objective # 5.*
 
 Note: command to read the final file should be data <- read.table(“data_final.txt”, header = TRUE)

Explanation of data_final.txt file can be found in the codebook file in this repo. 


  [1]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

