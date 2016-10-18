## Plot 4 - Course Project 1

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
data$Voltage <- (as.numeric(as.character(data$Voltage)))
data$Global_reactive_power <- (as.numeric(as.character(data$Global_reactive_power)))

## plot 4
par(mfrow = c(2,2), cex = 0.75)
plot(data$data, data$Global_active_power, ylab = "Global Active Power", 
     xlab ="", type="l")
plot(data$data, data$Voltage, ylab = "Voltage", xlab = "datetime", 
     type = "l")
plot(data$data, data$Sub_metering_1, ylab = "Energy sub metering", 
     xlab = "", type = "l")
lines(data$data, data$Sub_metering_2, col = "red")
lines(data$data, data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1   ", "Sub_metering_2   ",
                              "Sub_metering_3   "), col = c("black","red",
                                                            "blue"), 
       bty = "n", lty = 1, y.intersp = 1.5)
plot(data$data, data$Global_reactive_power, xlab = "datetime",
     ylab = "Global_reactive_power", type = "l")
dev.copy(png,"plot4.png", width = 480, height = 480)
dev.off()