# Code Book

## Subject and Activity



 - Subject: the integer subject ID(1-30).
 - Activity: the string activity name:
  - 1-Walking
  - 2-Walking Upstairs
  - 3-Walking Downstairs
  - 4-Sitting
  - 5-Standing
  - 6-Laying


### Data transformation
-------------------

The raw data sets are processed with run_analisys.R script to create a tidy data
set

### Merges the training and the test sets to create one data set.

Test and training data (X_train.txt, X_test.txt), subject ids (subject_train.txt,
subject_test.txt) and activity ids (y_train.txt, y_test.txt) are merged to obtain
a single data set. Variables are labelled with the names assigned by original
collectors (features.txt).

### Extracts only the measurements on the mean and standard deviation for each measurement.

by using grep function to get all the measurements with"std" or "mean" Then subset the dataset wtih only measurements
with stand divation and mean.

### Use descriptive activity names

Activity id column is used to look up descriptions in activity_labels.txt.

### Label variables appropriately

Variables name have been changed
* to obtain valid R names without parentheses"()", dashes"-" and commas","
* clearer name
    * Variable names have been changed by following way to properly descripe variables
    * Acc -> Accelerator
    * Mag -> Magnitute
    * Gyro -> Gyroscope
    * t -> time
    * f -> frequency
    
### Create a tidy data set

The tidy data set contains 10299 observations with 81 variables

