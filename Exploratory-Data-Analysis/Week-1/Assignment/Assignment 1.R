## Course Project 1

## Load libraries
library(dplyr)
library(lubridate)

filePath = "household_power_consumption.txt"
if(!file.exists(filePath)){
    url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url = url,destfile = "data.zip",method="curl")
    unzip("data.zip",overwrite = TRUE)
}
## Want to use fread from data.table but na.strings parameter borks out.
## See: http://stackoverflow.com/questions/15784138/bad-interpretation-of-n-a-using-fread
data = read.table(file = filePath,header=T,sep=";",na.strings = "?")