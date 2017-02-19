library(data.table)
library(plyr)
#Read activity lables
activity_labels <-fread("./UCI HAR Dataset/activity_labels.txt")
#Read variables' names
var_names<-fread("./UCI HAR Dataset/features.txt")
#Read training files
subject_train <-fread("./UCI HAR Dataset/train/subject_train.txt")
x_train <-fread("./UCI HAR Dataset/train/X_train.txt")
y_train <-fread("./UCI HAR Dataset/train/y_train.txt")
# Read Test Files
subject_test <-fread("./UCI HAR Dataset/test/subject_test.txt")
x_test <-fread("./UCI HAR Dataset/test/X_test.txt")
y_test <-fread("./UCI HAR Dataset/test/y_test.txt")


#1.Merges the training and the test sets to create one data set.
x_bind <-rbind(x_train,x_test)
y_bind <-rbind(y_train,y_test)
subject_bind <-rbind(subject_test,subject_train)
combined_data <- cbind(subject_bind,y_bind,x_bind)

#1.1ASSIGN NAMES TO MERGED DATA
colnames(combined_data) <-c("subject","activity",as.character(var_names$V2))

#2Extracts only the measurements on the mean and standard deviation for each measurement.
#2.1 get index of column names with "mean" and "std"
mean_std_vars<-grep("mean|std",colnames(combined_data))
# 2.2 combine column(1)-subject column (2)-activity, with columns for mean and std.
extracted_data<-cbind(combined_data[,1:2],combined_data[,mean_std_vars,with=FALSE])


#3. Uses descriptive activity names to name the activities in the data set

extracted_data$activity<-factor(extracted_data$activity,levels = as.character(activity_labels$V1),labels = as.character(activity_labels$V2))

# 4.Appropriately labels the data set with descriptive variable names.
names(extracted_data) <- gsub('\\(|\\)',"",names(extracted_data), perl = TRUE)
names(extracted_data) <- gsub('-',"",names(extracted_data), perl = TRUE)
names(extracted_data) <- gsub("Acc", "Accelerator", names(extracted_data))
names(extracted_data) <- gsub("Mag", "Magnitude", names(extracted_data))
names(extracted_data) <- gsub("Gyro", "Gyroscope", names(extracted_data))
names(extracted_data) <- gsub("^t", "time", names(extracted_data))
names(extracted_data) <- gsub("^f", "frequency", names(extracted_data))

# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for 
#each activity and each subject.

tidy_data<-ddply(extracted_data,c("subject","activity"),numcolwise(mean))
write.table(tidy_data, file = "tidydata.txt", row.names = FALSE)
