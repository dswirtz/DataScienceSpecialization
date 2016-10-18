## Plot 3 - Course Project 1

## The data set is unzipped in the current working directory

## Loading and cleaning data
data <- read.csv("household_power_consumption.txt", sep = ";")
data$DateTime <- paste(as.character(data[,1]), data[,2])
data[,1] <- as.Date(data$Date, "%d/%m/%Y")
data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")
data[,3] <- as.numeric(as.character(data[,3]))
data$data <- strptime(data$DateTime, "%d/%m/%Y %H:%M")
data$Sub_metering_1 <- (as.numeric(as.character(data$Sub_metering_1)))
data$Sub_metering_2 <- (as.numeric(as.character(data$Sub_metering_2)))
data$Sub_metering_3 <- (as.numeric(as.character(data$Sub_metering_3)))

## plot 3
png("plot3.png", width = 480, height = 480)
plot(data$data, data$Sub_metering_1, ylab = "Energy sub metering",
     xlab = "", type = "l")
lines(data$data, data$Sub_metering_2, col = "red")
lines(data$data, data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2",
                              "Sub_metering_3"), col = c("black", "red",
                                                         "blue"),
       lty = 1)
dev.off()
