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
