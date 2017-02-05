# loaded required package
library (plyr)
library (dplyr)

# download the file and save the raw data
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp <- tempfile()
download.file (fileurl, temp) # save tge file into temp file
filelist <- unzip(temp, list = TRUE) [ ,1] # create the file list in the zip file, with a list of file path in the zip file
activitylabels <- read.table(unzip(temp, filelist[1]))
features <- read.table(unzip(temp, filelist[2]))
subjecttest <- read.table (unzip(temp, filelist[16]))
xtest <- read.table (unzip(temp, filelist[17]))
ytest <- read.table (unzip(temp, filelist[18]))
subjecttrain <- read.table (unzip (temp, filelist[30]))
xtrain <- read.table (unzip (temp, filelist[31]))
ytrain <- read.table (unzip (temp, filelist[32]))
unlink (temp) #unlink the temp file with the zip
rm (temp) # remove temp from the object list

# fix the column name in xtest and xtrain
colnames (xtest) <- features [ ,2]
colnames (xtrain) <- features [ ,2]

# fix column name in ytest and ytrain and convert the variable to factor
colnames (ytest) <- "activity"
colnames (ytrain) <- "activity"
ytest[ ,1] <- as.factor(ytest[ ,1])
ytrain[ ,1] <- as.factor(ytrain[ ,1])

# fix column name in subjecttest and subjecttrain and convert the varialbe to factor
colnames (subjecttest) <- "subject"
colnames (subjecttrain) <- "subject"
subjecttest[ ,1] <- as.factor (subjecttest[ ,1])
subjecttrain[ ,1] <- as.factor (subjecttrain[ ,1])

##### Task 1 ##### merge the train and test set to one data set
test <- cbind (subjecttest, ytest, xtest) # create a test data frame that contain the subject and activities column by combining the 3 table
train <- cbind (subjecttrain, ytrain, xtrain) # creat a train data frame
fullset <- rbind (test, train) # combine the test and train dataset into one data set

##### Task 2 ##### Extracts only the measurements on the mean and standard deviation for each measurement
#Note - Gravitation means are not included
mean_std <- fullset [ , grepl ("subject|set|activity|mean\\(\\)|std\\(\\)", colnames(fullset))]

##### Task 3 ##### Uses descriptive activity names to name the activities in the data set
mean_std$activity <- mapvalues (mean_std$activity, c(1:6), c(as.character(activitylabels[ ,2])))

##### Task 4 ##### Appropriately labels the data set with descriptive variable names.
#name the subject in subject column
subjectnum <- c(1:30)
subjectlist <- character ()
for (i in subjectnum) {
        subjectlist <- c(subjectlist, paste ("Participant", i, sep = " "))
}
mean_std$subject <- mapvalues (mean_std$subject, c(1:30), c(subjectlist))
rm (subjectlist)
rm (subjectnum)

colnames (mean_std) <- gsub ("^t", "timedomain", colnames(mean_std) ) # replace t to timedomain
colnames (mean_std) <- gsub ("^f", "freqdomain", colnames(mean_std) ) # replace f to freqdomain
colnames (mean_std) <- gsub ("Acc", "accelerometer", colnames(mean_std) ) # replace Acc to accelerometer
colnames (mean_std) <- gsub ("Gyro", "gyroscope", colnames(mean_std) ) # replace Gyro to gyroscope
colnames (mean_std) <- gsub ("Mag", "magnitude", colnames(mean_std) ) # replace Mag to magnitude
colnames (mean_std) <- gsub ("mean\\(\\)", "mean", colnames(mean_std) )# replace mean() to mean
colnames (mean_std) <- gsub ("std\\(\\)", "standarddeviation", colnames(mean_std) )# replace std() to standarddeviation
colnames (mean_std) <- tolower (colnames(mean_std)) # convert all to lower case

##### Task 5 ##### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_dataset <- mean_std %>% group_by(subject, activity) %>% summarize_each(funs(mean))
write.table (tidy_dataset, "UCI HAR Dataset tidied.txt", row.names = FALSE) 

# Remove the irrelevant subject in the environment 
rm (activitylabels)
rm (features)
rm (subjecttest)
rm (subjecttrain)
rm (xtest)
rm (xtrain)
rm (ytest)
rm (ytrain)










