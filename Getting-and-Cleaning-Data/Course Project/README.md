Run Analysis
========

Version 1.0 - Wed August 13, 2015

by Mathew Merryweather  
<https://github.com/MMerryweather>

Software Version
-----
R: 3.2.1 (2015-06-18) -- "World-Famous Astronaut"

RStudio: 0.99.447

data.table: 1.9.4

dplyr: 0.4.2

plyr: 1.8.3

Abstract
----------
Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

Source
------
Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
1 - Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy. 
2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain
activityrecognition '@' smartlab.ws

Background
----------
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Analysis Description
------------
This script requires the data below to be extracted into its working directory:
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

Running this script via `run_analysis` will return a summary of the original 
data.table in a tidy. The summary is the means for each mean and standard 
deviation reading grouped by subject and activity (See code book).

Analysis Method
------

1. Key packages are loaded
2. Raw data is read into memory using fread where possible or read.table
	2.1 Descriptive data is loaded: features, subjects and activity labels
3. Descriptive names are added for all variables. X data has its column names stored in the features file.
4. The X datasets (training and test) are reduced to only samples containing
mean and standard deviation data using logical vectors combined with `grepl`
5. The reduced data is merged with the subject and activity label data for 
training and testing data
6. The training and testing data is then merged into a single data table
7. The activity labels are inner-joined onto the single data set 
(subject_x.txt only had the activity identifier, not the label)
8. The data set produced here: `data` completes step 4
9. Keys are added to allow for speedy summarization using the `dplyr` library
10. Means are calculated for each column and are grouped by activityLabel 
and subject
11. Using the `tidyr` library, the wide data is transformed into long form.
12. A tidy data set is reorganized and sorted before being returned to the user