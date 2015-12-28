# CourseraGettingCleaningData
The script run_analysis.R performs several steps that is outlined in the course description.

1) Merges the training and the test sets to create one data set.
* Load X_test.txt data into R
* Load X_train.txt data into R
* Merge/stack both files together

2) Extract only the measurements on the mean and standard deviation for each measurement.
*Reading in ("features.txt") identify what features are relative to the fulldata set.  When you review the feature labels - all 561 of them are present and we want to identify only
the mean and standard deviation measurements.  Using the grep command, you can isolate the labels that are reflective of the measurements needed in the analysis.
*Once you understand the subset of the feature labels then you need to use the locations from the 'subset' features as an indication of what columns
to keep relative to the means or std in the full dataset.  In other words, you create a subset of the labels and then a subset of the dataset that are corresponding.

3) Uses descriptive activity names to name the activities in the data set.
* Load y_test.txt data into R
* Load y_train.txt data into R
* Merge/stack both files together
* Bring in the labels from the activity labels
* Merge the activity labels into the y merged/stacked data file 

4) Appropriately label the data set with descriptive variable names
* Load subject_test.txt data into R
* Load subject_train.txt data into R
* Merge/stack both files together

Based on the above steps there are three 3 datasets 1) fulldatasub 2) activity 3) subjectfulldata - combine them and provide variable names

5) From the data set in Step4, this script creates a second, independent tidy data set with the average of each variable for each activity and each subject.
