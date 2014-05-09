#Script to read in table and create R plot per Coursera Exploratory Analysis, May 2014 Guidelines
power <- read.table("household_power_consumption/household_power_consumption.txt", sep = ";", h=T)
#Change the date and time columns to one combined column
datetime <- paste(power$Date, power$Time)
datetime <- as.Date(strptime(datetime, "%d/%m/%Y %H:%M:%S"))
#Change the power data frame to add the datetime vector instead of the two date and time columns.
power <- cbind(datetime, power[,-(1:2)])
#Choose only the days specified
power <- subset(power, datetime >= as.Date("2007-02-01") & datetime <= as.Date("2007-02-02"))
#Change the variables to numeric
power$Global_active_power = as.numeric(as.character(power$Global_active_power))
#Open a png connection
png("plot1.png", width = 480, height = 480)
#Create histogram
hist(power$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "Red")
dev.off()