##Download the file and put the file in the data folder

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")
# 2.Unzip the file

unzip(zipfile="./data/Dataset.zip",exdir="./data")
Get the list of the files
path_rf <- file.path("D:\\Coursera-R\\getting and cleaning data\\data(week4)" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
files
# Read the files

dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)
dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)
dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)


# 3.Merge columns to get the data frame Data for all data

dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)

# Extracts only the measurements on the mean and standard deviation for each measurement
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
# Subset the data frame Data by seleted names of Features
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)
# 1.Read descriptive activity names from “activity_labels.txt”

activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)
# facorize Variale activity in the data frame Data using descriptive activity names
Data$activity <- as.character(Data$activity)
for (i in 1:6){
  Data$activity[Data$activity == i] <- as.character(activityLabels[i,2])
}
Data$activity <- as.factor(Data$activity)

# # Appropriately labels the data set with descriptive variable names
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

# # Creates a second,independent tidy data set and ouput it
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "D:\\Coursera-R\\getting and cleaning data\\data(week4)\\UCI HAR Dataset\\tidydata.txt",row.name=FALSE)

Varuable list of tidy data:
Important variables:
 "subject"                                       
 "activity" 
 other variables:
 [1]"timeBodyAccelerometer-mean()-X"                
 [2] "timeBodyAccelerometer-mean()-Y"                
 [3] "timeBodyAccelerometer-mean()-Z"                
 [4] "timeBodyAccelerometer-std()-X"                 
 [5] "timeBodyAccelerometer-std()-Y"                 
 [6] "timeBodyAccelerometer-std()-Z"                 
 [7] "timeGravityAccelerometer-mean()-X"             
 [8] "timeGravityAccelerometer-mean()-Y"             
 [9] "timeGravityAccelerometer-mean()-Z"             
[10] "timeGravityAccelerometer-std()-X"              
[11] "timeGravityAccelerometer-std()-Y"              
[12] "timeGravityAccelerometer-std()-Z"              
[13] "timeBodyAccelerometerJerk-mean()-X"            
[14] "timeBodyAccelerometerJerk-mean()-Y"            
[15] "timeBodyAccelerometerJerk-mean()-Z"            
[16] "timeBodyAccelerometerJerk-std()-X"             
[17] "timeBodyAccelerometerJerk-std()-Y"             
[18] "timeBodyAccelerometerJerk-std()-Z"             
[19] "timeBodyGyroscope-mean()-X"                    
[20] "timeBodyGyroscope-mean()-Y"                    
[21] "timeBodyGyroscope-mean()-Z"                    
[22] "timeBodyGyroscope-std()-X"                     
[23] "timeBodyGyroscope-std()-Y"                     
[24] "timeBodyGyroscope-std()-Z"                     
[25] "timeBodyGyroscopeJerk-mean()-X"                
[26] "timeBodyGyroscopeJerk-mean()-Y"                
[27] "timeBodyGyroscopeJerk-mean()-Z"                
[28] "timeBodyGyroscopeJerk-std()-X"                 
[29] "timeBodyGyroscopeJerk-std()-Y"                 
[30] "timeBodyGyroscopeJerk-std()-Z"                 
[31] "timeBodyAccelerometerMagnitude-mean()"         
[32] "timeBodyAccelerometerMagnitude-std()"          
[33] "timeGravityAccelerometerMagnitude-mean()"      
[34] "timeGravityAccelerometerMagnitude-std()"       
[35] "timeBodyAccelerometerJerkMagnitude-mean()"     
[36] "timeBodyAccelerometerJerkMagnitude-std()"      
[37] "timeBodyGyroscopeMagnitude-mean()"             
[38] "timeBodyGyroscopeMagnitude-std()"              
[39] "timeBodyGyroscopeJerkMagnitude-mean()"         
[40] "timeBodyGyroscopeJerkMagnitude-std()"          
[41] "frequencyBodyAccelerometer-mean()-X"           
[42] "frequencyBodyAccelerometer-mean()-Y"           
[43] "frequencyBodyAccelerometer-mean()-Z"           
[44] "frequencyBodyAccelerometer-std()-X"            
[45] "frequencyBodyAccelerometer-std()-Y"            
[46] "frequencyBodyAccelerometer-std()-Z"            
[47] "frequencyBodyAccelerometerJerk-mean()-X"       
[48] "frequencyBodyAccelerometerJerk-mean()-Y"       
[49] "frequencyBodyAccelerometerJerk-mean()-Z"       
[50] "frequencyBodyAccelerometerJerk-std()-X"        
[51] "frequencyBodyAccelerometerJerk-std()-Y"        
[52] "frequencyBodyAccelerometerJerk-std()-Z"        
[53] "frequencyBodyGyroscope-mean()-X"               
[54] "frequencyBodyGyroscope-mean()-Y"               
[55] "frequencyBodyGyroscope-mean()-Z"               
[56] "frequencyBodyGyroscope-std()-X"                
[57] "frequencyBodyGyroscope-std()-Y"                
[58] "frequencyBodyGyroscope-std()-Z"                
[59] "frequencyBodyAccelerometerMagnitude-mean()"    
[60] "frequencyBodyAccelerometerMagnitude-std()"     
[61] "frequencyBodyAccelerometerJerkMagnitude-mean()"
[62] "frequencyBodyAccelerometerJerkMagnitude-std()" 
[63] "frequencyBodyGyroscopeMagnitude-mean()"        
[64] "frequencyBodyGyroscopeMagnitude-std()"         
[65] "frequencyBodyGyroscopeJerkMagnitude-mean()"    
[66] "frequencyBodyGyroscopeJerkMagnitude-std()"     
[67] "subject"                                       
[68] "activity"                                      
> 

summary of the variables
important variables:
  subject                   activity  timeBodyAccelerometer-mean()-X
 Min.   : 1.0   LAYING            :30   Min.   :0.2216                
 1st Qu.: 8.0   SITTING           :30   1st Qu.:0.2712                
 Median :15.5   STANDING          :30   Median :0.2770                
 Mean   :15.5   WALKING           :30   Mean   :0.2743                
 3rd Qu.:23.0   WALKING_DOWNSTAIRS:30   3rd Qu.:0.2800                
 Max.   :30.0   WALKING_UPSTAIRS  :30   Max.   :0.3015 
 other variables:
 timeBodyAccelerometer-mean()-Y timeBodyAccelerometer-mean()-Z
 Min.   :-0.040514              Min.   :-0.15251              
 1st Qu.:-0.020022              1st Qu.:-0.11207              
 Median :-0.017262              Median :-0.10819              
 Mean   :-0.017876              Mean   :-0.10916              
 3rd Qu.:-0.014936              3rd Qu.:-0.10443              
 Max.   :-0.001308              Max.   :-0.07538              
 timeBodyAccelerometer-std()-X timeBodyAccelerometer-std()-Y
 Min.   :-0.9961               Min.   :-0.99024             
 1st Qu.:-0.9799               1st Qu.:-0.94205             
 Median :-0.7526               Median :-0.50897             
 Mean   :-0.5577               Mean   :-0.46046             
 3rd Qu.:-0.1984               3rd Qu.:-0.03077             
 Max.   : 0.6269               Max.   : 0.61694             
 timeBodyAccelerometer-std()-Z timeGravityAccelerometer-mean()-X
 Min.   :-0.9877               Min.   :-0.6800                  
 1st Qu.:-0.9498               1st Qu.: 0.8376                  
 Median :-0.6518               Median : 0.9208                  
 Mean   :-0.5756               Mean   : 0.6975                  
 3rd Qu.:-0.2306               3rd Qu.: 0.9425                  
 Max.   : 0.6090               Max.   : 0.9745                  
 timeGravityAccelerometer-mean()-Y timeGravityAccelerometer-mean()-Z
 Min.   :-0.47989                  Min.   :-0.49509                 
 1st Qu.:-0.23319                  1st Qu.:-0.11726                 
 Median :-0.12782                  Median : 0.02384                 
 Mean   :-0.01621                  Mean   : 0.07413                 
 3rd Qu.: 0.08773                  3rd Qu.: 0.14946                 
 Max.   : 0.95659                  Max.   : 0.95787                 
 timeGravityAccelerometer-std()-X timeGravityAccelerometer-std()-Y
 Min.   :-0.9968                  Min.   :-0.9942                 
 1st Qu.:-0.9825                  1st Qu.:-0.9711                 
 Median :-0.9695                  Median :-0.9590                 
 Mean   :-0.9638                  Mean   :-0.9524                 
 3rd Qu.:-0.9509                  3rd Qu.:-0.9370                 
 Max.   :-0.8296                  Max.   :-0.6436                 
 timeGravityAccelerometer-std()-Z timeBodyAccelerometerJerk-mean()-X
 Min.   :-0.9910                  Min.   :0.04269                   
 1st Qu.:-0.9605                  1st Qu.:0.07396                   
 Median :-0.9450                  Median :0.07640                   
 Mean   :-0.9364                  Mean   :0.07947                   
 3rd Qu.:-0.9180                  3rd Qu.:0.08330                   
 Max.   :-0.6102                  Max.   :0.13019                   
 timeBodyAccelerometerJerk-mean()-Y timeBodyAccelerometerJerk-mean()-Z
 Min.   :-0.0386872                 Min.   :-0.067458                 
 1st Qu.: 0.0004664                 1st Qu.:-0.010601                 
 Median : 0.0094698                 Median :-0.003861                 
 Mean   : 0.0075652                 Mean   :-0.004953                 
 3rd Qu.: 0.0134008                 3rd Qu.: 0.001958                 
 Max.   : 0.0568186                 Max.   : 0.038053                 
 timeBodyAccelerometerJerk-std()-X timeBodyAccelerometerJerk-std()-Y
 Min.   :-0.9946                   Min.   :-0.9895                  
 1st Qu.:-0.9832                   1st Qu.:-0.9724                  
 Median :-0.8104                   Median :-0.7756                  
 Mean   :-0.5949                   Mean   :-0.5654                  
 3rd Qu.:-0.2233                   3rd Qu.:-0.1483                  
 Max.   : 0.5443                   Max.   : 0.3553                  
 timeBodyAccelerometerJerk-std()-Z timeBodyGyroscope-mean()-X
 Min.   :-0.99329                  Min.   :-0.20578          
 1st Qu.:-0.98266                  1st Qu.:-0.04712          
 Median :-0.88366                  Median :-0.02871          
 Mean   :-0.73596                  Mean   :-0.03244          
 3rd Qu.:-0.51212                  3rd Qu.:-0.01676          
 Max.   : 0.03102                  Max.   : 0.19270          
 timeBodyGyroscope-mean()-Y timeBodyGyroscope-mean()-Z timeBodyGyroscope-std()-X
 Min.   :-0.20421           Min.   :-0.07245           Min.   :-0.9943          
 1st Qu.:-0.08955           1st Qu.: 0.07475           1st Qu.:-0.9735          
 Median :-0.07318           Median : 0.08512           Median :-0.7890          
 Mean   :-0.07426           Mean   : 0.08744           Mean   :-0.6916          
 3rd Qu.:-0.06113           3rd Qu.: 0.10177           3rd Qu.:-0.4414          
 Max.   : 0.02747           Max.   : 0.17910           Max.   : 0.2677          
 timeBodyGyroscope-std()-Y timeBodyGyroscope-std()-Z timeBodyGyroscopeJerk-mean()-X
 Min.   :-0.9942           Min.   :-0.9855           Min.   :-0.15721              
 1st Qu.:-0.9629           1st Qu.:-0.9609           1st Qu.:-0.10322              
 Median :-0.8017           Median :-0.8010           Median :-0.09868              
 Mean   :-0.6533           Mean   :-0.6164           Mean   :-0.09606              
 3rd Qu.:-0.4196           3rd Qu.:-0.3106           3rd Qu.:-0.09110              
 Max.   : 0.4765           Max.   : 0.5649           Max.   :-0.02209              
 timeBodyGyroscopeJerk-mean()-Y timeBodyGyroscopeJerk-mean()-Z
 Min.   :-0.07681               Min.   :-0.092500             
 1st Qu.:-0.04552               1st Qu.:-0.061725             
 Median :-0.04112               Median :-0.053430             
 Mean   :-0.04269               Mean   :-0.054802             
 3rd Qu.:-0.03842               3rd Qu.:-0.048985             
 Max.   :-0.01320               Max.   :-0.006941             
 timeBodyGyroscopeJerk-std()-X timeBodyGyroscopeJerk-std()-Y
 Min.   :-0.9965               Min.   :-0.9971              
 1st Qu.:-0.9800               1st Qu.:-0.9832              
 Median :-0.8396               Median :-0.8942              
 Mean   :-0.7036               Mean   :-0.7636              
 3rd Qu.:-0.4629               3rd Qu.:-0.5861              
 Max.   : 0.1791               Max.   : 0.2959              
 timeBodyGyroscopeJerk-std()-Z timeBodyAccelerometerMagnitude-mean()
 Min.   :-0.9954               Min.   :-0.9865                      
 1st Qu.:-0.9848               1st Qu.:-0.9573                      
 Median :-0.8610               Median :-0.4829                      
 Mean   :-0.7096               Mean   :-0.4973                      
 3rd Qu.:-0.4741               3rd Qu.:-0.0919                      
 Max.   : 0.1932               Max.   : 0.6446                      
 timeBodyAccelerometerMagnitude-std() timeGravityAccelerometerMagnitude-mean()
 Min.   :-0.9865                      Min.   :-0.9865                         
 1st Qu.:-0.9430                      1st Qu.:-0.9573                         
 Median :-0.6074                      Median :-0.4829                         
 Mean   :-0.5439                      Mean   :-0.4973                         
 3rd Qu.:-0.2090                      3rd Qu.:-0.0919                         
 Max.   : 0.4284                      Max.   : 0.6446                         
 timeGravityAccelerometerMagnitude-std() timeBodyAccelerometerJerkMagnitude-mean()
 Min.   :-0.9865                         Min.   :-0.9928                          
 1st Qu.:-0.9430                         1st Qu.:-0.9807                          
 Median :-0.6074                         Median :-0.8168                          
 Mean   :-0.5439                         Mean   :-0.6079                          
 3rd Qu.:-0.2090                         3rd Qu.:-0.2456                          
 Max.   : 0.4284                         Max.   : 0.4345                          
 timeBodyAccelerometerJerkMagnitude-std() timeBodyGyroscopeMagnitude-mean()
 Min.   :-0.9946                          Min.   :-0.9807                  
 1st Qu.:-0.9765                          1st Qu.:-0.9461                  
 Median :-0.8014                          Median :-0.6551                  
 Mean   :-0.5842                          Mean   :-0.5652                  
 3rd Qu.:-0.2173                          3rd Qu.:-0.2159                  
 Max.   : 0.4506                          Max.   : 0.4180                  
 timeBodyGyroscopeMagnitude-std() timeBodyGyroscopeJerkMagnitude-mean()
 Min.   :-0.9814                  Min.   :-0.99732                     
 1st Qu.:-0.9476                  1st Qu.:-0.98515                     
 Median :-0.7420                  Median :-0.86479                     
 Mean   :-0.6304                  Mean   :-0.73637                     
 3rd Qu.:-0.3602                  3rd Qu.:-0.51186                     
 Max.   : 0.3000                  Max.   : 0.08758                     
 timeBodyGyroscopeJerkMagnitude-std() frequencyBodyAccelerometer-mean()-X
 Min.   :-0.9977                      Min.   :-0.9952                    
 1st Qu.:-0.9805                      1st Qu.:-0.9787                    
 Median :-0.8809                      Median :-0.7691                    
 Mean   :-0.7550                      Mean   :-0.5758                    
 3rd Qu.:-0.5767                      3rd Qu.:-0.2174                    
 Max.   : 0.2502                      Max.   : 0.5370                    
 frequencyBodyAccelerometer-mean()-Y frequencyBodyAccelerometer-mean()-Z
 Min.   :-0.98903                    Min.   :-0.9895                    
 1st Qu.:-0.95361                    1st Qu.:-0.9619                    
 Median :-0.59498                    Median :-0.7236                    
 Mean   :-0.48873                    Mean   :-0.6297                    
 3rd Qu.:-0.06341                    3rd Qu.:-0.3183                    
 Max.   : 0.52419                    Max.   : 0.2807                    
 frequencyBodyAccelerometer-std()-X frequencyBodyAccelerometer-std()-Y
 Min.   :-0.9966                    Min.   :-0.99068                  
 1st Qu.:-0.9820                    1st Qu.:-0.94042                  
 Median :-0.7470                    Median :-0.51338                  
 Mean   :-0.5522                    Mean   :-0.48148                  
 3rd Qu.:-0.1966                    3rd Qu.:-0.07913                  
 Max.   : 0.6585                    Max.   : 0.56019                  
 frequencyBodyAccelerometer-std()-Z frequencyBodyAccelerometerJerk-mean()-X
 Min.   :-0.9872                    Min.   :-0.9946                        
 1st Qu.:-0.9459                    1st Qu.:-0.9828                        
 Median :-0.6441                    Median :-0.8126                        
 Mean   :-0.5824                    Mean   :-0.6139                        
 3rd Qu.:-0.2655                    3rd Qu.:-0.2820                        
 Max.   : 0.6871                    Max.   : 0.4743                        
 frequencyBodyAccelerometerJerk-mean()-Y frequencyBodyAccelerometerJerk-mean()-Z
 Min.   :-0.9894                         Min.   :-0.9920                        
 1st Qu.:-0.9725                         1st Qu.:-0.9796                        
 Median :-0.7817                         Median :-0.8707                        
 Mean   :-0.5882                         Mean   :-0.7144                        
 3rd Qu.:-0.1963                         3rd Qu.:-0.4697                        
 Max.   : 0.2767                         Max.   : 0.1578                        
 frequencyBodyAccelerometerJerk-std()-X frequencyBodyAccelerometerJerk-std()-Y
 Min.   :-0.9951                        Min.   :-0.9905                       
 1st Qu.:-0.9847                        1st Qu.:-0.9737                       
 Median :-0.8254                        Median :-0.7852                       
 Mean   :-0.6121                        Mean   :-0.5707                       
 3rd Qu.:-0.2475                        3rd Qu.:-0.1685                       
 Max.   : 0.4768                        Max.   : 0.3498                       
 frequencyBodyAccelerometerJerk-std()-Z frequencyBodyGyroscope-mean()-X
 Min.   :-0.993108                      Min.   :-0.9931                
 1st Qu.:-0.983747                      1st Qu.:-0.9697                
 Median :-0.895121                      Median :-0.7300                
 Mean   :-0.756489                      Mean   :-0.6367                
 3rd Qu.:-0.543787                      3rd Qu.:-0.3387                
 Max.   :-0.006236                      Max.   : 0.4750                
 frequencyBodyGyroscope-mean()-Y frequencyBodyGyroscope-mean()-Z
 Min.   :-0.9940                 Min.   :-0.9860                
 1st Qu.:-0.9700                 1st Qu.:-0.9624                
 Median :-0.8141                 Median :-0.7909                
 Mean   :-0.6767                 Mean   :-0.6044                
 3rd Qu.:-0.4458                 3rd Qu.:-0.2635                
 Max.   : 0.3288                 Max.   : 0.4924                
 frequencyBodyGyroscope-std()-X frequencyBodyGyroscope-std()-Y
 Min.   :-0.9947                Min.   :-0.9944               
 1st Qu.:-0.9750                1st Qu.:-0.9602               
 Median :-0.8086                Median :-0.7964               
 Mean   :-0.7110                Mean   :-0.6454               
 3rd Qu.:-0.4813                3rd Qu.:-0.4154               
 Max.   : 0.1966                Max.   : 0.6462               
 frequencyBodyGyroscope-std()-Z frequencyBodyAccelerometerMagnitude-mean()
 Min.   :-0.9867                Min.   :-0.9868                           
 1st Qu.:-0.9643                1st Qu.:-0.9560                           
 Median :-0.8224                Median :-0.6703                           
 Mean   :-0.6577                Mean   :-0.5365                           
 3rd Qu.:-0.3916                3rd Qu.:-0.1622                           
 Max.   : 0.5225                Max.   : 0.5866                           
 frequencyBodyAccelerometerMagnitude-std()
 Min.   :-0.9876                          
 1st Qu.:-0.9452                          
 Median :-0.6513                          
 Mean   :-0.6210                          
 3rd Qu.:-0.3654                          
 Max.   : 0.1787                          
 frequencyBodyAccelerometerJerkMagnitude-mean()
 Min.   :-0.9940                               
 1st Qu.:-0.9770                               
 Median :-0.7940                               
 Mean   :-0.5756                               
 3rd Qu.:-0.1872                               
 Max.   : 0.5384                               
 frequencyBodyAccelerometerJerkMagnitude-std()
 Min.   :-0.9944                              
 1st Qu.:-0.9752                              
 Median :-0.8126                              
 Mean   :-0.5992                              
 3rd Qu.:-0.2668                              
 Max.   : 0.3163                              
 frequencyBodyGyroscopeMagnitude-mean() frequencyBodyGyroscopeMagnitude-std()
 Min.   :-0.9865                        Min.   :-0.9815                      
 1st Qu.:-0.9616                        1st Qu.:-0.9488                      
 Median :-0.7657                        Median :-0.7727                      
 Mean   :-0.6671                        Mean   :-0.6723                      
 3rd Qu.:-0.4087                        3rd Qu.:-0.4277                      
 Max.   : 0.2040                        Max.   : 0.2367                      
 frequencyBodyGyroscopeJerkMagnitude-mean()
 Min.   :-0.9976                           
 1st Qu.:-0.9813                           
 Median :-0.8779                           
 Mean   :-0.7564                           
 3rd Qu.:-0.5831                           
 Max.   : 0.1466                           
 frequencyBodyGyroscopeJerkMagnitude-std()
 Min.   :-0.9976                          
 1st Qu.:-0.9802                          
 Median :-0.8941                          
 Mean   :-0.7715                          
 3rd Qu.:-0.6081                          
 Max.   : 0.2878                          

