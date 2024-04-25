
R version 4.3.3 (2024-02-29 ucrt) -- 
Copyright (C) 2024 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.


> 
> if(!file.exists("./data")){dir.create("./data")}
>
> fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
> download.file(fileUrl,destfile="./data/Dataset.zip")
trying URL 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
Content type 'application/zip' length 62556944 bytes (59.7 MB)
downloaded 59.7 MB

> 

> unzip(zipfile="./data/Dataset.zip",exdir="./data")
> 
>
> #Step 1
> 
> x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
> y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
> subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
> 
> 
> x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
> y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
> subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
> 
> 
> features <- read.table('./data/UCI HAR Dataset/features.txt')
> 
>
> activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')
> 
> 
> 
> colnames(x_train) <- features[,2]
> colnames(y_train) <-"activityId"
> colnames(subject_train) <- "subjectId"
> 
> colnames(x_test) <- features[,2] 
> colnames(y_test) <- "activityId"
> colnames(subject_test) <- "subjectId"
> 
> colnames(activityLabels) <- c('activityId','activityType')
> 
>
> 
> mrg_train <- cbind(y_train, subject_train, x_train)
> mrg_test <- cbind(y_test, subject_test, x_test)
> setAllInOne <- rbind(mrg_train, mrg_test)
> 
> #dim(setAllInOne)
> #[1] 10299   563
> 
>
> #Step 2
>
> 
> 
> 
> colNames <- colnames(setAllInOne)
> 
> 
> 
> mean_and_std <- (grepl("activityId" , colNames) | 
+                      grepl("subjectId" , colNames) | 
+                      grepl("mean.." , colNames) | 
+                      grepl("std.." , colNames) 
+ )
> 
> 
> 
> setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]
> 
> 
> #Step 3
> 
> setWithActivityNames <- merge(setForMeanAndStd, activityLabels,
+                               by='activityId',
+                               all.x=TRUE)
> 
> 
> #Step 4.

> secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
There were 50 or more warnings (use warnings() to see the first 50)
> secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]
> 
> 
> 
> write.table(secTidySet, "secTidySet.txt", row.name=FALSE)
> 
> View(secTidySet)
> View(secTidySet)
> View(secTidySet)
> View(secTidySet)