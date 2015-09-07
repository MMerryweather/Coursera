Run Analysis
========

Version 1.0 - Wed August 13, 2015

by Mathew Merryweather  
<https://github.com/MMerryweather>


Code Book
---------

### run_analysis.r
#### Description
Main function that converts a folder of raw movement data into a tidied and
 averaged set grouped sbject and activity.

#### Inputs
*output*

Determines whether or not the output is written to file.

e.g. `run_analysis(output = TRUE)`

This writes the tidy dataset to a file called `run_analysis.txt` in the current 
working directoy.

#### Output
run_analysis.txt returns a data.table of dimensions 11880 rows x 4 cols.

* subject
	- Type: Factor
	- Levels: 30
	- Contains the indiviual who performed each activity (anonymized)
* activity
	- Type: Factor
	- Levels: 6
	- The activity the subject was performing when the measurements were taken
* measurement
	- Type: Factor
	- Levels: 66
	- The physical measure that was recorded at each time frame
* value
	- Type: num
	- The mean values for each measurement
	- units: g, standard gravity units	


