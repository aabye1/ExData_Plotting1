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


#Open a png connection
png("plot2.png", width = 480, height = 480)
#Create the line plot
plot(power$Global_active_power ~ power$datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()