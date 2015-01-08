Sys.setlocale("LC_ALL","en_US")
library(sqldf)

if (!file.exists("household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                "exdata-data-household_power_consumption.zip", method="curl")
  unzip("exdata-data-household_power_consumption.zip")
}

## read and cleanup data
df4 <- read.csv.sql("household_power_consumption.txt", 
                    "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", 
                    header=TRUE, sep = ";")
df4$DateTime <- strptime(paste(df4$Date, df4$Time), format="%d/%m/%Y %H:%M:%S")

## create plot
png("plot4.png",width = 480, height = 480)
par(mfcol = c(2,2))

## top left
plot(df4$DateTime, df4$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

## bottom left
plot(df4$DateTime, df4$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")
lines(df4$DateTime, df4$Sub_metering_2, col="red")
lines(df4$DateTime, df4$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black","blue","red"), lty = c(1,1), bty = "n")

## top right
plot(df4$DateTime, df4$Voltage, type="l", xlab = "datetime", ylab = "Voltage")

## bottom right
plot(df4$DateTime, df4$Global_reactive_power, type="l", xlab = "datetime", ylab="Global_reactive_power")

dev.off()