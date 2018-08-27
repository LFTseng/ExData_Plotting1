## Load dplyr and pubridate packages
library(dplyr)
library(lubridate)

filename <- "dataset.zip"

## Download and unzip the dataset
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method ="curl")
}  
if (!file.exists("household_power_consumption")) { 
  unzip(filename) 
}

## Load dataset
AllData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

## Convert Date and Time variables
AllData[, 1] <- as.Date(AllData[, 1], "%d/%m/%Y")

## Filter data on 2007-02-01 and 2007-02-02
SelectData <- filter(AllData, Date == c("2007-02-01", "2007-02-02"))

## Include weekday into filtered dataset
SelectData <- mutate(SelectData, DateTime = as.POSIXct(paste(as.Date(SelectData$Date), SelectData$Time)))

## Plot and save into a png file
with(SelectData, {
  plot(Sub_metering_1 ~ DateTime, xlab = "", ylab = "Energy sub metering", type = "l", col = "black")
  lines(SelectData$Sub_metering_2 ~ DateTime, type = "l", col = "red")
  lines(SelectData$Sub_metering_3 ~ DateTime, type = "l", col = "blue")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)
})
dev.copy(png, filename = "plot3.png", width = 480, height = 480)
dev.off()

