##################################################################
## Step 1
## Check for the existence of the required zip file, download if 
## absent and unzip
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
##################################################################

dataSource <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataDestination <- "household_power_consumption.zip" 

# if dataDestination file doesn't exist download and unzip
if (!file.exists(dataDestination)) {
  download.file(dataSource,dataDestination)
}

#if household_power_consumption.txt doesn't exist unzip the file just downloaded
if (!file.exists("household_power_consumption.txt")) {
  unzip(dataDestination)
}

##################################################################
## Step 2 
## Read .txt file into a table, starting at row 66638 to row 69517
## which correspond to the dates 01/02/2007 to 02/02/2007
##################################################################

hpc <- read.table("household_power_consumption.txt",sep=";"
                  ,header=FALSE,skip=66637,nrows= 2879
                  ,col.names = c("Date","Time",	"Global_active_power",	"Global_reactive_power",	"Voltage",	"Global_intensity",	"Sub_metering_1",	"Sub_metering_2",	"Sub_metering_3"))

##################################################################
## Step 3
## Manipulate data and create required png file
##################################################################
## load lubridate
library(lubridate)

## create datetime column
hpc$DateTime <- dmy_hms(paste(hpc$Date, hpc$Time))

png("plot2.png", height = 480, width = 480)
plot(hpc$DateTime,hpc$Global_active_power,type="l",xlab="",ylab="Global Active Power(kilowatts)")
dev.off()