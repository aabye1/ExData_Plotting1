#Script to read in table and create R plot per Coursera Exploratory Analysis, May 2014 Guidelines

#The script does the following in the first chunk
#Change the date and time columns to one combined column
#Change the power data frame to add the datetime vector instead of the two date and time columns.
#Choose only the days specified
#Change the variables to numeric

power <- read.table("household_power_consumption/household_power_consumption.txt", sep = ";", h=T)
datetime <- paste(power$Date, power$Time)
datetime <- as.POSIXct(strptime(datetime, "%d/%m/%Y %H:%M:%S"))
power <- cbind(datetime, power[,-(1:2)])
power <- subset(power, datetime >= as.POSIXct("2007-02-01 00:00:00 PST") & datetime <= as.POSIXct("2007-02-02 23:59:59 PST"))
power$Global_active_power = as.numeric(as.character(power$Global_active_power))
power$Sub_metering_1 = as.numeric(as.character(power$Sub_metering_1))
power$Sub_metering_2 = as.numeric(as.character(power$Sub_metering_2))
power$Sub_metering_3 = as.numeric(as.character(power$Sub_metering_3))
power$Voltage = as.numeric(as.character(power$Voltage))
power$Global_reactive_power = as.numeric(as.character(power$Global_reactive_power))


#Open the png connection
png("plot4.png", width = 480, height = 480)
#Make a 2x2 plots
par(mfcol = c(2,2))
#Plot same as in 2, with change xlab
plot(power$Global_active_power ~ power$datetime, type = "l", ylab = "Global Active Power", xlab = "")
#Plot same as in 3, with changed legend
plot(power$Sub_metering_1 ~ power$datetime, type = "l", main = "", ylab = "Energy sub metering", xlab = "")
lines(power$Sub_metering_2 ~ power$datetime, col = "Red")
lines(power$Sub_metering_3 ~ power$datetime, col = "Blue")
legend("topright", col = c("Black", "Red", "Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, bty ="n")
#Plot the line voltage vs time
plot(power$Voltage ~ power$datetime, xlab = "datetime", ylab = "Voltage", type = "l")
#Plot the line reactive power vs time
plot(power$Global_reactive_power ~ power$datetime, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
#Close the connection
dev.off()