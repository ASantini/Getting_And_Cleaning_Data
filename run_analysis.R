library(reshape2)

testDataRaw <- read.table("./UCI HAR Dataset/test/X_test.txt", header=F)
trainDataRaw <- read.table("./UCI HAR Dataset/train/X_train.txt",header=F)

combineDataRaw <- rbind(testDataRaw, trainDataRaw)

## removing unnessary data frames from memory
rm(testDataRaw)
rm(trainDataRaw)

## importing column names
colNamesRaw <- read.table("./UCI HAR Dataset/features.txt", header=F)
colnames(combineDataRaw) <- colNamesRaw[,2]
head(combineDataRaw)

## extract just the columns with mean and standard deviations
colNames <- names(combineDataRaw)
## colNames[grepl("std|[Mm]ean", colNames)]
data <- combineDataRaw[, colNames[grepl("std|[Mm]ean", colNames)]]

## removing unnessary data frame from memory
rm(combineDataRaw)

## Add meaning full names to data columns
dataNames <- names(data)
dataNames <- sub("^t", "Time: ", dataNames)
dataNames <- sub("^f", "Freq: ", dataNames)
dataNames <- sub("Acc", " Acceleration ", dataNames)
dataNames <- sub("Gyro", " Angular Velocity ", dataNames)
dataNames <- sub("Mag", "Magnitude", dataNames)
dataNames <- sub("-mean", "Mean", dataNames)
dataNames <- sub("-std", "Standard Deviation", dataNames)
dataNames <- sub("-X", " X Axis", dataNames)
dataNames <- sub("-Y", " Y Axis", dataNames)
dataNames <- sub("-Z", " Z Axis", dataNames)
names(data) <- dataNames

## importing subject and test info
testSubjectRaw <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=F)
trainSubjectRaw <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=F)
combineSubjectRaw <- rbind(testSubjectRaw, trainSubjectRaw)

testActivityRaw <- read.table("./UCI HAR Dataset/test/y_test.txt", header=F)
trainActivityRaw <- read.table("./UCI HAR Dataset/train/y_train.txt",header=F)
combineActivityRaw <- rbind(testActivityRaw, trainActivityRaw)

## combine subject and activity data and then add meaningful 
## column identifiers to the data frame
identData <- cbind(combineSubjectRaw, combineActivityRaw)
names(identData) <- c("Subject", "Activity")

## add subject and activity data to data data frame
data <- cbind(identData, data)

## replace numeric "Activity" value with provided description
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", header=F)
data$Activity <- activities[data$Activity, 2]


## melt data 
dataNames <- names(data)
dataMelt <- melt(data,id=dataNames[1:2],measures.var=dataNames[3:88])

## reshape data to get final tidy data set
dataTidy <- dcast(dataMelt, Subject + Activity ~ variable,mean)

## write dataTidy to file
write.table(dataTidy, file="TidyData.txt", row.names=FALSE)
