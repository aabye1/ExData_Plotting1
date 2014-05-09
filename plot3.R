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
power$Sub_metering_1 = as.numeric(as.character(power$Sub_metering_1))
power$Sub_metering_2 = as.numeric(as.character(power$Sub_metering_2))
power$Sub_metering_3 = as.numeric(as.character(power$Sub_metering_3))


#Open a png connection
png("plot3.png", width = 480, height = 480)
#Create the first plot for sub_1
plot(power$Sub_metering_1 ~ power$datetime, type = "l", main = "", ylab = "Energy sub metering", xlab = "")
#Add the lines for the sub_2, colored red
lines(power$Sub_metering_2 ~ power$datetime, col = "Red")
#Add the lines for the sub_3, colored blue
lines(power$Sub_metering_3 ~ power$datetime, col = "Blue")
#Add a legend
legend("topright", col = c("Black", "Red", "Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1)
#Close the connection
dev.off()