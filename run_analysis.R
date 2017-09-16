library(dplyr)

filename <- "getdata_dataset.zip"
## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, mode = "wb")
}  

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

##Load test and train datasets
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

##Merges the training and the test sets to create one data set.
##Column bind on test & train datasets
test_data <- cbind(subject_test,y_test,x_test)
train_data <- cbind(subject_train,y_train,x_train)
merged_data<-rbind(train_data,test_data)

##Read features and Activity set
features <- read.table("UCI HAR Dataset/features.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")

##Assigning columns to merged data
columnnames<-c("subject_id","activity_id",as.character(features[,2]))
colnames(merged_data)<- columnnames

##Extracting only mean and SD
mean_and_Std_dev <- (grepl("activity_id",columnnames)|
                     grepl("subject_id",columnnames)|
                     grepl("mean..",columnnames)|
                     grepl("std..",columnnames)
                     )
setForMeanAndStd <- merged_data[,mean_and_Std_dev==TRUE]

#Descriptive activity name
colnames(activityLabels) <- c('activity_id','activityType')
setWithActivityNames <- merge(setForMeanAndStd,activityLabels,by='activity_id',all.x = TRUE)

#Final tidy dataset
grouped_data<-group_by(setWithActivityNames,activity_id,subject_id)
tidy_data<-summarise_all(grouped_data,funs(mean))
write.table(tidy_data, "tidy.txt", row.name=FALSE)






