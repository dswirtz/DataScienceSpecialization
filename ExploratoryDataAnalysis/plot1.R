## Plot 1 - Course Project 1

## The data set is unzipped in the current working directory

## Loading and cleaning data
data <- read.csv("household_power_consumption.txt", sep = ";")
data[,1] <- as.Date(data$Date, "%d/%m/%Y")
data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")
data$DateTime <- paste(as.character(data[,1]), data[,2])
data[,3] <- as.numeric(as.character(data[,3]))

## plot 1
png("plot1.png", width = 480, height = 480)
hist(data[,3], col = "red", xlab = "Global Active Power (Kilowatts)",
     ylab = "Frequency", main = "Global Active Power")
dev.off()
