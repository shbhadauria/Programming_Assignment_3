#setting working directory where samsung data is stored
setwd("C:/Users/shbhadauria/Desktop/coursera/getting nd cleaning data")
#read data into variables
train=read.csv("C:/Users/shbhadauria/Desktop/coursera/getting nd cleaning data/UCI HAR Dataset/train/X_train.txt",header = FALSE, sep = "",dec=".")
test=read.csv("C:/Users/shbhadauria/Desktop/coursera/getting nd cleaning data/UCI HAR Dataset/test/X_test.txt",header = FALSE, sep = "", dec = ".")

train_label=read.csv("C:/Users/shbhadauria/Desktop/coursera/getting nd cleaning data/UCI HAR Dataset/train/y_train.txt",header = FALSE, sep = "")
test_label=read.csv("C:/Users/shbhadauria/Desktop/coursera/getting nd cleaning data/UCI HAR Dataset/test/y_test.txt",header = FALSE, sep = "", stringsAsFactors = FALSE)


label=read.csv("C:/Users/shbhadauria/Desktop/coursera/getting nd cleaning data/UCI HAR Dataset/features.txt",header = FALSE, sep = "")
activity_label<-read.csv("C:/Users/shbhadauria/Desktop/coursera/getting nd cleaning data/UCI HAR Dataset/activity_labels.txt",header = FALSE, sep = "")

subject_train<-read.csv("C:/Users/shbhadauria/Desktop/coursera/getting nd cleaning data/UCI HAR Dataset/train/subject_train.txt",header = FALSE, sep = "")
subject_test<-read.csv("C:/Users/shbhadauria/Desktop/coursera/getting nd cleaning data/UCI HAR Dataset/test/subject_test.txt",header = FALSE, sep = "")


#1.Tidy Dataset with column names
train=cbind(train,train_label,subject_train)
test=cbind(test,test_label,subject_test)
data=rbind(train,test)

#4. Label dataset with variables names
colnames(data)<-label[,2]
colnames(data)[562:563]<-c("Activity","Subject")

#2 extracting the mean and stddev of measurments
library(dplyr)
# creating data without duplicate columns
data1 <- data[ , !duplicated(colnames(data))]
#Subsetting
ex_data<-select(data1,contains("mean"),contains("std"))

#3 Giving Activity names to activities
ac_labels<-activity_label[,2] 
names(ac_labels) <- c(1,2,3,4,5,6)
data$Activity <- ac_labels[ as.character(data$Activity)]

#5 Calculating mean of the data after grouping according to Activity and Subject
summ_data<-group_by(data1,Activity,Subject)
result<-summarise_all(summ_data,"mean")
