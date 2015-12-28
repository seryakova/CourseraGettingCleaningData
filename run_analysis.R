setwd("C:\\WORK")


#Step1 - Merge the training and test sets into one dataset.

##Load the X_test.txt data into R
testdata = read.table("X_test.txt")
head (testdata)

##Load the X_train.txt data into R
traindata = read.table("X_train.txt")
head (traindata)

##combine both files - stack them
fulldata <-rbind(testdata,traindata)

#Step 2 - Extract only the measurements on the mean and standard deviation
##for each measurement.

#Identify what the features are relative to the fulldata set.
features = read.table("features.txt")
head (features)
#take a look at the feature labels - all 561 of them and we want to identify only
#the mean and standard deviation measurements
View(features)

#if you put [Mm] -- it looks for both upper and lower case
#grep will only find numbers and letters, but if you have symbols,
#you must put \\ before each one.
#you must specify the dataset that you are grep - in this case features
#you want to look at the 2nd column for every row
#since we are looking for both mean and std -- you must use | (or) in between
#you must eliminate any spaces as well so it doesn't look for spaces
subset<-grep("[Mm]ean\\(\\)|[Ss]td\\(\\)", features[ ,2])

#Use the locations from the 'subset' features as an indication of what columns
#to keep relative to the means or std.
fulldatasub<-fulldata[ ,subset]
#above gives you your dataset subsetted, but it's important to keep only the labels
#associated with that subset as well.. see below for features subset
featuressub<-features[subset, "V2"]
View(featuressub)


#####Step3.
###Uses descriptive activity names to name the activities in the data set.
##Load the y_test.txt data into R
ytestdata = read.table("y_test.txt")
head (ytestdata)

##Load the y_train.txt data into R
ytraindata = read.table("y_train.txt")
head (ytraindata)

##combine both files - stack them
yfulldata <-rbind(ytestdata,ytraindata)
#too many observations to view, so run a table to summarize the data.
table(yfulldata)

###Bring in the labels from the activity labels.
activitylabel = read.table("activity_labels.txt")

#merge the activity labels into the yfulldata file.
#remember, when merging it doesn't keep the original order, you must specify if you want.
#below labels each of rows in the yfulldata set.
yfulldata$label<-1:nrow(yfulldata)

#merge your yfulldataset with the activity label
#merging by V1 for both datasets
activity<- merge(yfulldata, activitylabel, by.x = "V1", by.y = "V1")
#put it back in the original order to merge into the original dataset
#also, all you need is the V1 and V2, so you can build in the subset in this command
activity<- activity[order(activity$label), c("V1","V2")]


#####Step4.
#Appropriately labels the data set with descriptive variable names.
#Create a total subject file.

##Load the subject_test.txt data into R
subjecttestdata = read.table("subject_test.txt")
head (subjecttestdata)

##Load the subject_train.txt data into R
subjecttraindata = read.table("subject_train.txt")
head (subjecttraindata)

##combine both files - stack them (unique identifier subject)
subjectfulldata <-rbind(subjecttestdata,subjecttraindata)
#too many observations to view, so run a table to summarize the data.
table(subjectfulldata)

##Now I have 3 datasets 1) fulldatasub 2) activity 3) subjectfulldata - combine them
full<-cbind(fulldatasub, activity, subjectfulldata)
names(full)

#featuressub - are the labels from the fulldatasub [1:66]
#activity - V1, V2 at the end [67:68]
#subjectfulldata - V1 at the end [69]

featuressub <- gsub("-"," ",featuressub) # Clean Vars by dropping the " - " in order to make it a character and not a list
featuressub <- gsub("\\(\\)","",featuressub) # Clean Vars by dropping the " () " 
featuressub <- gsub(" ","_",featuressub) # Clean Vars by replacing spaces " 
varnames<- c(featuressub, "Activity_Number", "Activity_Label", "UniqueID")

str(featuressub)

##Take dataset of full and apply the names from varnames to it.
names(full)<-varnames
#check to make sure it worked
names(full)

#Step5 - From the data set in Step4, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.
#My notes for what I labeled things: Activity = Activity_Label, Subject = UniqueID for each featuressub

#for the variables in full, do the function by each of the groups 'activity_label, uniqueid'
final<-aggregate(full[featuressub], by = full[c("Activity_Label","UniqueID")], mean, na.rm = TRUE)

write.table(final, file ="Final_Analysis.txt", row.name=FALSE)


