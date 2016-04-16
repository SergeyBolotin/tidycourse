library("dplyr")

test <- read.table("./UCI HAR Dataset/test/X_test.txt",header = FALSE)
subject_test<- read.table("./UCI HAR Dataset/test/subject_test.txt",header = FALSE)
colnames(subject_test)[1] = "Subject"
activity_test<- read.table("./UCI HAR Dataset/test/y_test.txt",header = FALSE)
colnames(activity_test)[1] = "Activity"
test <-bind_cols(test, subject_test, activity_test)
test <- mutate(test, Sample = "test")

train<- read.table("./UCI HAR Dataset/train/X_train.txt",header = FALSE)
subject_train<- read.table("./UCI HAR Dataset/train/subject_train.txt",header = FALSE)
colnames(subject_train)[1] = "Subject"
activity_train<- read.table("./UCI HAR Dataset/train/y_train.txt",header = FALSE)
colnames(activity_train)[1] = "Activity"
train <-bind_cols(train, subject_train, activity_train)
train <- mutate(train, Sample = "train")

#Merges the training and the test sets to create one data set.
set <- bind_rows(test, train)

#Appropriately labels the data set with descriptive variable names.
lbls <- read.table("./UCI HAR Dataset/features.txt",header = FALSE)
lbls$V2 <- as.character(lbls$V2)
colnames(set)[1:561] <- paste(1:561,lbls$V2,sep="-")

#Extracts only the measurements on the mean and standard deviation for each measurement.
ext <- select(set, Sample, Subject, Activity, contains("mean"), contains("std"))

#Uses descriptive activity names to name the activities in the data set
activity_names <- read.table("./UCI HAR Dataset/activity_labels.txt",header = FALSE)
ext <-merge(ext, activity_names,by.x = "Activity", by.y="V1")
colnames(ext)[90] <- "activityname"

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject.
library(tidyr)
tid <- gather(ext,feature,value,-Activity,-Sample,-Subject,-activityname)
tidg <- group_by(tid,activityname, Subject, feature)
tidgsum <- summarise(tidg,mean(value))
tidgsum$feature <- sub("^[0-9]+-","",tidgsum$feature)


write.table(tidgsum,"./step5result.txt",row.name=FALSE)