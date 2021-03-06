## read power data set
power <- read.table(file = "household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE, stringsAsFactors = FALSE)
## format time and date fields
power$Time <- strptime(power$Time, format = "%H:%M:%S")
power$Time <- as.POSIXct(power$Time, format = "%H:%M:%S", tz = "America/Los_Angeles")
power$Date <- strptime(power$Date, format = "%d/%m/%Y", usetz = FALSE)
power$Date <- as.Date(power$Date)
## limit data set to the two days needed
feb_data <- power$Date == "2007/02/01"| power$Date == "2007/02/02"
feb_dataset <- power[feb_data,]
## New column using Date and Time combined
feb_dataset$DateTime <- paste(as.Date(feb_dataset$Date), feb_dataset$Time)
## Format new column 
feb_dataset$DateTime <- as.POSIXlt(strptime(feb_dataset$DateTime, format = "%Y-%m-%d %H:%M:%S"))
## plot 4, copied to PNG
par(mfcol = c(2,2))
plot(feb_dataset$DateTime, feb_dataset$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)" , xlab = "")
plot(feb_dataset$DateTime, feb_dataset$Sub_metering_1, type = "l", ylab = "Energy sub metering" , xlab = "")
lines(feb_dataset$DateTime, feb_dataset$Sub_metering_2, type = "l", col = "red")
lines(feb_dataset$DateTime, feb_dataset$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", lty = "solid")
plot(feb_dataset$DateTime, feb_dataset$Voltage, type = "l", ylab = "Voltage" , xlab = "datetime")
plot(feb_dataset$DateTime, feb_dataset$Global_reactive_power, type = "l", ylab = "Global_reactive_power" , xlab = "datetime")
dev.copy(png, width = 480, height = 480, file = "plot4.png") ## needs to be wider than the others to not cut off legend
dev.off()