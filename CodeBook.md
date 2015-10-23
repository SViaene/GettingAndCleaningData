==================================================================
Data cleaning for the Human Activity Recognition Using Smartphones Dataset
performed by Sébastien Viaene
October 21st 2015

Origin of the data described below:
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit� degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

Here, we describe the data processing from the raw dataset.
A full description of the data acquisition itself can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data consists of a test and training set in the test/ and train/ folders.
In both folders, there is another folder called Inertial Signals/ This folder contains the raw measurements and is not considered here. We make use of the pre-processed table of measurements X_test.txt and X_train.txt. Furthermore, the test and train folders have respective files for the subject IDs: subject_test.txt and subject_train.txt, and for the activity IDs: y_test.txt and y_train.txt.

* Step 1: merging test and train set.
First, the subject_test, y_test and X_test files are joined together using a dummy ID column. The column names for X_test are taken from the features.txt file in the main directory. A column named testSet is added, with all values to True to indicate that this is the test set.
Second, the subject_train, y_train and X_train files are joined together in the same way as the test set. A column named testSet is added, with all values to False to indicate that this is the training set.
Last, the rows of the train set dataframe are added below the rows of the test set dataframe to create a full dataset. The testSet column differentiates between rows beloning to the test set and rows beloning to the training set.

* Step 2: Extracting mean and std data
The full dataset is trimmed in the sense that only column names that represent mean and standard deviations (std) of the measurements are kept. This was done by searching the column names for the word 'mean' and 'std' and to keep those columns. Of course, the basic columns subjec, y and testSet are kept as well.

* Step 3: rename activity IDs
The activity IDs in the y-column are renamed following the activity_labels.txt file in the main directory.

* Step 4: Descriptive column names
The column names are renamed to make them more descriptive. They are described at the end of this file.

* Step 5: Create aggregate dataset
A smaller dataset is created as a summary. The set give the mean of all measurements for different subject, activities and makes the distinction between test set and training set.


Description of the column names
==================================================================
"subject"  = ID of the person that carried the measurements device
"activity" = Description of the activity of the subject at time of measurement
"testSet"  = Does this row belong to the test set? boolean value.
"timeBodyAcceleration_meanX" = time domain averaged acceleration of the body in the X direction
"timeBodyAcceleration_meanY" = time domain averaged acceleration of the body in the Y direction
"timeBodyAcceleration_meanZ" = time domain averaged acceleration of the body in the Z direction
"timeBodyAcceleration_stdX"  = time domain standard deviation on the acceleration of the body in the X direction
"timeBodyAcceleration_stdY"  = time domain standard deviation on the acceleration of the body in the Y direction
"timeBodyAcceleration_stdZ"  = time domain standard deviation on the acceleration of the body in the Z direction
"timeGravityAcceleration_meanX" = time domain averaged acceleration due to gravity in the X direction
"timeGravityAcceleration_meanY" = time domain averaged acceleration due to gravity in the X direction
"timeGravityAcceleration_meanZ" = time domain averaged acceleration due to gravity in the X direction
"timeGravityAcceleration_stdX"  = time domain standard deviation on the acceleration due to gravity in the X direction
"timeGravityAcceleration_stdY"  = time domain standard deviation on the acceleration due to gravity in the Y direction
"timeGravityAcceleration_stdZ"  = time domain standard deviation on the acceleration due to gravity in the Z direction
"timeBodyAccelerationJerk_meanX" = time domain averaged jerk acceleration of the body in the X direction
"timeBodyAccelerationJerk_meanY" = time domain averaged jerk acceleration of the body in the Y direction
"timeBodyAccelerationJerk_meanZ" = time domain averaged jerk acceleration of the body in the Z direction
"timeBodyAccelerationJerk_stdX"  = time domain standard deviation on the jerk acceleration of the body in the X direction
"timeBodyAccelerationJerk_stdY"  = time domain standard deviation on the jerk acceleration of the body in the Y direction
"timeBodyAccelerationJerk_stdZ"  = time domain standard deviation on the jerk acceleration of the body in the Z direction
"timeBodyGyroscope_meanX" = time domain averaged angular velocity of the body in the X direction
"timeBodyGyroscope_meanY" = time domain averaged angular velocity of the body in the Y direction
"timeBodyGyroscope_meanZ" = time domain averaged angular velocity of the body in the Z direction
"timeBodyGyroscope_stdX"  = time domain standard deviation on the angular velocity of the body in the X direction
"timeBodyGyroscope_stdY"  = time domain standard deviation on the angular velocity of the body in the Y direction
"timeBodyGyroscope_stdZ"  = time domain standard deviation on the angular velocity of the body in the Z direction
"timeBodyGyroscopeJerk_meanX" = time domain averaged jerk angular velocity of the body in the X direction
"timeBodyGyroscopeJerk_meanY" = time domain averaged jerk angular velocity of the body in the Y direction
"timeBodyGyroscopeJerk_meanZ" = time domain averaged jerk angular velocity of the body in the Z direction
"timeBodyGyroscopeJerk_stdX"  = time domain standard deviation on the jerk angular velocity of the body in the X direction
"timeBodyGyroscopeJerk_stdY"  = time domain standard deviation on the jerk angular velocity of the body in the Y direction
"timeBodyGyroscopeJerk_stdZ"  = time domain standard deviation on the jerk angular velocity of the body in the Z direction
"timeBodyAccelerationMagnitude_mean" = time domain mean magnitude of the total acceleration of the body
"timeBodyAccelerationMagnitude_std"  = time domain standard deviation on the total magnitude of the acceleration of the body
"timeGravityAccelerationMagnitude_mean" = time domain mean magnitude of the total acceleration due to gravity
"timeGravityAccelerationMagnitude_std"  = time domain standard deviation on the total magnitude of the acceleration due to gravity
"timeBodyAccelerationJerkMagnitude_mean" = time domain mean magnitude of the total jerk acceleration
"timeBodyAccelerationJerkMagnitude_std"  = time domain standard deviation on the total magnitude of the jerk acceleration
"timeBodyGyroscopeMagnitude_mean" = time domain mean magnitude of the total angular velocity of the body
"timeBodyGyroscopeMagnitude_std"  = time domain standard deviation on the total magnitude of the angular velocity
"timeBodyGyroscopeJerkMagnitude_mean"  = time domain mean magnitude of the total jerk angular velocity of the body
"timeBodyGyroscopeJerkMagnitude_std" = time domain standard deviation on the total magnitude of the jerk angular velocity

An analogous set of column names are in the following columns. The prefix 'time' is simply replaced by 'frequency'. Consequently, they probe the same measurements, but they are Fourier transformed into the frequency domain. e.g. "timeBodyAcceleration_meanX" becomes "frequencyBodyAcceleration_meanX". Their description is completely analogous as the above 'time' parameters, but now mean and standard deviation occur in the frequency domain in stead of the time domain.
