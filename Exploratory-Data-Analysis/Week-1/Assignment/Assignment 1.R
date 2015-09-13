## Course Project 1
# Description: Measurements of electric power consumption in one household with
# a one-minute sampling rate over a period of almost 4 years. Different
# electrical quantities and some sub-metering values are available.
#
# The following descriptions of the 9 variables in the dataset are taken from
# the UCI web site:
#
#   Date: Date in format dd/mm/yyyy
#   Time: time in format hh:mm:ss
#   Global_active_power: household global minute-averaged active power (kW)
#   Global_reactive_power: household global minute-averaged reactive power (kW)
#   Voltage: minute-averaged voltage (V)
#   Global_intensity: household global minute-averaged current intensity (A)
#   Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy).
#       It corresponds to the kitchen, containing mainly a dishwasher, an oven
#       and a microwave (hot plates are not electric but gas powered).
#   Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy).
#       It corresponds to the laundry room, containing a washing-machine,
#       a tumble-drier, a refrigerator and a light.
#   Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy).
#       It corresponds to an electric water-heater and an air-conditioner.

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
