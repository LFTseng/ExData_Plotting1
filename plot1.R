## Load dplyr package
library(dplyr)

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

## Convert Date variable
AllData[, 1] <- as.Date(AllData[, 1], "%d/%m/%Y")

## Filter data on 2007-02-01 and 2007-02-02
SelectData <- filter(AllData, Date == c("2007-02-01", "2007-02-02"))

## Plot histogram and save into a png file
hist(SelectData$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.copy(png, filename = "plot1.png", width = 480, height = 480)
dev.off()


