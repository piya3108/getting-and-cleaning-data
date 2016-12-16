##Download the file and put the file in the data folder

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")
# 2.Unzip the file

unzip(zipfile="./data/Dataset.zip",exdir="./data")
# 3.unzipped files are in the folderUCI HAR Dataset. Get the list of the files
path_rf <- file.path("D:\\Coursera-R\\getting and cleaning data\\data(week4)" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
files
# 2.Read data from the files into the variables
# 
# Read the Activity files

dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)
# Read the Subject files

dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)
# Read Fearures files

dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)

# Look at the properties of the above varibles
str(dataActivityTest)
str(dataActivityTrain)
str(dataSubjectTrain)
str(dataSubjectTest)
str(dataFeaturesTest)
str(dataFeaturesTrain)
# Merges the training and the test sets to create one data set
# 1.Concatenate the data tables by rows

dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)
# 2.set names to variables

names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2
# 3.Merge columns to get the data frame Data for all data

dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)
# Extracts only the measurements on the mean and standard deviation for each measurement
# Subset Name of Features by measurements on the mean and standard deviation
# i.e taken Names of Features with "mean()" or "std()"

subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
# Subset the data frame Data by seleted names of Features
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)
# Check the structures of the data frame Data
str(Data)
# Uses descriptive activity names to name the activities in the data set
# 1.Read descriptive activity names from "activity_labels.txt"

activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)
# facorize Variale activity in the data frame Data using descriptive activity names
# 
# Data$Activity<-ifelse(Data$activity==1,Data$Activity=="walking",Data$Activity=="")
# Data$Activity<-ifelse(Data$activity==2,Data$Activity=="walking_upstairs",Data$Activity=="")
# Data$Activity<-ifelse(Data$activity==3,Data$Activity=="walking_downstairs",Data$Activity=="")
# Data$Activity<-ifelse(Data$activity==4,Data$Activity=="sitting",Data$Activity=="")
# Data$Activity<-ifelse(Data$activity==5,Data$Activity=="standing",Data$Activity=="")
# Data$Activity<-ifelse(Data$activity==6,Data$Activity=="laying",Data$Activity=="")
### Create column names for activity labels

# colnames(activityLabels)<- c("activity","activityname")
# # Add the activity label to the dataset using a merge on activityid
# data1 <- merge(x=Data, y=activityLabels, by="activity")
# Data$activity<-Data$activityname
# rownames(ata)
# # Check that activity has been merged correctly
# unique(data[,c("activity")])
# 
# 
# # check
# facorize Variale activity in the data frame Data using descriptive activity names
Data$activity <- as.character(Data$activity)
for (i in 1:6){
  Data$activity[Data$activity == i] <- as.character(activityLabels[i,2])
}
Data$activity <- as.factor(Data$activity)

head(Data$Activity,30)
# # Appropriately labels the data set with descriptive variable names
# prefix t is replaced by time
# Acc is replaced by Accelerometer
# Gyro is replaced by Gyroscope
# prefix f is replaced by frequency
# Mag is replaced by Magnitude
# BodyBody is replaced by Body
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
# check

names(Data)
# # Creates a second,independent tidy data set and ouput it
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "D:\\Coursera-R\\getting and cleaning data\\data(week4)\\UCI HAR Dataset\\tidydata.txt",row.name=FALSE)
