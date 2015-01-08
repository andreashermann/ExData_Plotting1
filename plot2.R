Sys.setlocale("LC_ALL","en_US")
library(sqldf)

if (!file.exists("household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                "exdata-data-household_power_consumption.zip", method="curl")
  unzip("exdata-data-household_power_consumption.zip")
}

## read and cleanup data
df1 <- read.csv.sql("household_power_consumption.txt", 
                    "select Date,Time,Global_active_power from file where Date = '1/2/2007' or Date = '2/2/2007'", 
                    header=TRUE, sep = ";")
df1$DateTime <- strptime(paste(df1$Date, df1$Time), format="%d/%m/%Y %H:%M:%S")

## create plot
png("plot2.png",width = 480, height = 480)
plot(df1$DateTime, df1$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()