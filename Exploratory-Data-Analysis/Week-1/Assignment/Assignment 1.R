## Course Project 1
filePath = "household_power_consumption.txt"
if(!file.exists(filePath)){
    url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url = url,destfile = "data.zip",method="curl")
    unzip("data.zip",overwrite = TRUE)
}
