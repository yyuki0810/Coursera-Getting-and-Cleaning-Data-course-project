
library(dplyr)

  
#donwload,and unzip the file.

download.file(myURL,destfile = "./data/Week4Assignment.zip",method="curl")
unzip("./data/Week4Assignment.zip",exdir = "./data/Week4Assignment")
list.files("./data/Week4Assignment",recursive = T,full.names = T)->ls

#read the data frame and name it.(Step 0)

df15<-read.table(ls[15])#UCI HAR Dataset/test/X_test.txt"
feature<-as.vector(read.table(ls[3])[2])
colnames(df15)<-feature[,]
df16<-read.table(ls[16])#UCI HAR Dataset/test/y_test.txt"
colnames(df16)<-("activity")

df27<-read.table(ls[27])#UCI HAR Dataset/train/X_train.txt"
colnames(df27)<-feature[,]
df28<-read.table(ls[28])#UCI HAR Dataset/train/y_train.txt"
colnames(df28)<-("activity")

df14<-read.table(ls[14])#/UCI HAR Dataset/test/subject_test.txt" 
df26<-read.table(ls[26])#UCI HAR Dataset/train/subject_train.txt" 

rbind(df14,df26)->sub
colnames(sub)<-("subject")
rbind(df15,df27)->X_sets
rbind(df16,df28)->Y_sets


#1;Merges the training and the test sets to create one data set.
cbind(sub,Y_sets,X_sets)->merged


#2;Extracts only the measurements on the mean and standard deviation for each measurement.

column.names.filtered <- grep("std|mean|activity|subject", colnames(merged), value=TRUE)
df.filtered<-merged[,column.names.filtered]

#3;Uses descriptive activity names to name the activities in the data set

df.filtered$activity <- factor(df.filtered$activity, labels= c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))


#4;Appropriately labels the data set with descriptive variable names.

#>already performed in step 0.

#5;From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


Output <- df.filtered %>%
  group_by(subject, activity) %>%
  summarise_all(mean)

write.table(Output, "Output.txt", row.name=FALSE)



