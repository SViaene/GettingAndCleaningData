# Read in the list of subjects 
testSet <- read.table("test/subject_test.txt",col.names = "subject")

# Construct an ID column to falicitate joining dataframes
IDs <- c(1:length(testSet[[1]]))
testSet <- mutate(testSet, ID = IDs)
# Add a logical vector indicating if a row belongs to the test set.
testSet <- mutate(testSet, test = !logical(length=length(IDs)))

# Read in the activity list and join to the test set dataframe
y_test <- read.table("test/y_test.txt", col.names = "y")
y_test <- mutate(y_test, ID = IDs)
testSet <- join(testSet,y_test)

# Read in the features names and the dataframe and join to 
# the test set dataframe
features <-read.table("features.txt")
featureSet <- read.table("test/X_test.txt", col.names = features[[2]])
featureSet <- mutate(featureSet, ID = IDs)
testSet <- join(testSet,featureSet)

# Construct a training set  dataframe with the subjects as first column
trainSet <- read.table("train/subject_train.txt",col.names = "subject")
# Add ID and test set column to label the data and falicitate 
# joining of the dataframes
IDs <- c(1:length(trainSet[[1]]))
trainSet <- mutate(trainSet, ID = IDs)
trainSet <- mutate(trainSet, test = logical(length=length(IDs)))

# add the activity vector as a column to the training set
y_train <- read.table("train/y_train.txt", col.names = "y")
y_train <- mutate(y_train, ID = IDs)
trainSet <- join(trainSet,y_train)

# add the features dataframe to the training set 
# using the features column names.
featureSet <- read.table("train/X_train.txt", col.names = features[[2]])
featureSet <- mutate(featureSet, ID = IDs)
trainSet <- join(trainSet,featureSet)

# Merge the test and training sets. i.e. rows of the training set are added
# below the test set.
fullSet <- merge(testSet,trainSet, all=T, sort=F)
# uncomment the next line to write out the full dataset.
# write.table(fullSet,"fullset.dat",row.names = F)

# Search for column names which have the string 'mean' or 'std' in them and 
# store their indices
meanCols <- grep('mean', names(fullSet))
stdCols  <- grep('std', names(fullSet))
# join both vectors and add the subject, y and testSet column indices
extractCols <- sort(c(1,3,4,meanCols,stdCols))
# extract a dataframe based on the above column indices
extractSet  <- fullSet[extractCols]

# rename the y (activity) number codes to readable activity descriptions
extractSet$y[extractSet$y == 1] <- "WALKING"
extractSet$y[extractSet$y == 2] <- "WALKING_UPSTAIRS"
extractSet$y[extractSet$y == 3] <- "WALKING_DOWNSTAIRS"
extractSet$y[extractSet$y == 4] <- "SITTING"
extractSet$y[extractSet$y == 5] <- "STANDING"
extractSet$y[extractSet$y == 6] <- "LAYING"

# Construct a string vector with new column names that are
# more human readable and descriptive.
newNames <- c("subject","testSet","activity","timeBodyAcceleration_meanX",
              "timeBodyAcceleration_meanY","timeBodyAcceleration_meanZ",
              "timeBodyAcceleration_stdX","timeBodyAcceleration_stdY",
              "timeBodyAcceleration_stdZ","timeGravityAcceleration_meanX",
              "timeGravityAcceleration_meanY","timeGravityAcceleration_meanZ",
              "timeGravityAcceleration_stdX","timeGravityAcceleration_stdY",
              "timeGravityAcceleration_stdZ","timeBodyAccelerationJerk_meanX",
              "timeBodyAccelerationJerk_meanY","timeBodyAccelerationJerk_meanZ",
              "timeBodyAccelerationJerk_stdX","timeBodyAccelerationJerk_stdY",
              "timeBodyAccelerationJerk_stdZ","timeBodyGyroscope_meanX",
              "timeBodyGyroscope_meanY","timeBodyGyroscope_meanZ",
              "timeBodyGyroscope_stdX","timeBodyGyroscope_stdY",
              "timeBodyGyroscope_stdZ","timeBodyGyroscopeJerk_meanX",
              "timeBodyGyroscopeJerk_meanY","timeBodyGyroscopeJerk_meanZ",
              "timeBodyGyroscopeJerk_stdX","timeBodyGyroscopeJerk_stdY",
              "timeBodyGyroscopeJerk_stdZ","timeBodyAccelerationMagnitude_mean",
              "timeBodyAccelerationMagnitude_std","timeGravityAccelerationMagnitude_mean",
              "timeGravityAccelerationMagnitude_std","timeBodyAccelerationJerkMagnitude_mean",
              "timeBodyAccelerationJerkMagnitude_std","timeBodyGyroscopeMagnitude_mean",
              "timeBodyGyroscopeMagnitude_std","timeBodyGyroscopeJerkMagnitude_mean",
              "timeBodyGyroscopeJerkMagnitude_std","frequencyBodyAcceleration_meanX",
              "frequencyBodyAcceleration_meanY","frequencyBodyAcceleration_meanZ",
              "frequencyBodyAcceleration_stdX","frequencyBodyAcceleration_stdY",
              "frequencyBodyAcceleration_stdZ","frequencyBodyAcceleration_meanFrequencyX",
              "frequencyBodyAcceleration_meanFrequencyY","frequencyBodyAcceleration_meanFrequencyZ",
              "frequencyBodyAccelerationJerk_meanX","frequencyBodyAccelerationJerk_meanY",
              "frequencyBodyAccelerationJerk_meanZ","frequencyBodyAccelerationJerk_stdX",
              "frequencyBodyAccelerationJerk_stdY","frequencyBodyAccelerationJerk_stdZ",
              "frequencyBodyAccelerationJerk_meanFrequencyX","frequencyBodyAccelerationJerk_meanFrequencyY",
              "frequencyBodyAccelerationJerk_meanFrequencyZ","frequencyBodyGyroscope_meanX",
              "frequencyBodyGyroscope_meanY","frequencyBodyGyroscope_meanZ",
              "frequencyBodyGyroscope_stdX","frequencyBodyGyroscope_stdY",
              "frequencyBodyGyroscope_stdZ","frequencyBodyGyroscope_meanFrequencyX",
              "frequencyBodyGyroscope_meanFrequencyY","frequencyBodyGyroscope_meanFrequencyZ",
              "frequencyBodyAccelerationMagnitude_mean","frequencyBodyAccelerationMagnitude_std",
              "frequencyBodyAccelerationMagnitude_meanFrequency","frequencyBodyBodyAccelerationJerkMagnitude_mean",
              "frequencyBodyBodyAccelerationJerkMagnitude_std","frequencyBodyBodyAccelerationJerkMagnitude_meanFrequency",
              "frequencyBodyBodyGyroscopeMagnitude_mean","frequencyBodyBodyGyroscopeMagnitude_std",
              "frequencyBodyBodyGyroscopeMagnitude_meanFrequency","frequencyBodyBodyGyroscopeJerkMagnitude_mean",
              "frequencyBodyBodyGyroscopeJerkMagnitude_std","frequencyBodyBodyGyroscopeJerkMagnitude_meanFrequency")

# apply new column names to the dataset
names(extractSet) <- newNames
# uncomment the next line to write out the extracted dataset
# write.table(extractSet,"extractSet.dat",row.names = F)

# Construct an smaller and aggregate data frame by giving the mean of the measurements 
# for each subject, activity and test-or training situation 
aggregateSet <- aggregate(extractSet, by=list(extractSet$subject,extractSet$activity,extractSet$testSet), FUN =mean)
# Clean up new set: rename grouped columns and remove 
# the old subject, activity and testSet columns
aggregateSet$subject <- NULL
aggregateSet$activity <- NULL
aggregateSet$testSet <- NULL
aggregateSet <- rename(aggregateSet, c("Group.1"="subject","Group.2"="activity", "Group.3"="testSet"))

# Write out the final dataset 
write.table(aggregateSet,"aggregateSet.dat",row.names = F)

