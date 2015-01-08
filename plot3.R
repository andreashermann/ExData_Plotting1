Sys.setlocale("LC_ALL","en_US")
library(sqldf)

if (!file.exists("household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                "exdata-data-household_power_consumption.zip", method="curl")
  unzip("exdata-data-household_power_consumption.zip")
}

## read and cleanup data
df3 <- read.csv.sql("household_power_consumption.txt", 
                    "select Date,Time,Sub_metering_1,Sub_metering_2,Sub_metering_3 from file where Date = '1/2/2007' or Date = '2/2/2007'", 
                    header=TRUE, sep = ";")
df3$DateTime <- strptime(paste(df3$Date, df3$Time), format="%d/%m/%Y %H:%M:%S")

## create plot
png("plot3.png",width = 480, height = 480)
plot(df3$DateTime, df3$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")
lines(df3$DateTime, df3$Sub_metering_2, col="red")
lines(df3$DateTime, df3$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black","blue","red"), lty = c(1,1))
dev.off()