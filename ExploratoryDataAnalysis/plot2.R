## Plot 2 - Course Project 1

## The data set is unzipped in the current working directory

## Loading and cleaning data
data <- read.csv("household_power_consumption.txt", sep = ";")
data$DateTime <- paste(as.character(data[,1]), data[,2])
data[,1] <- as.Date(data$Date, "%d/%m/%Y")
data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")
data[,3] <- as.numeric(as.character(data[,3]))
data$data <- strptime(data$DateTime, "%d/%m/%Y %H:%M")

## plot 2
png("plot2.png", width = 480, height = 480)
plot(data$data, data$Global_active_power, ylab = "Global Active Power(Kilowatts)",
     xlab = "", type = "l")
dev.off()
