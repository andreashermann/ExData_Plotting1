Sys.setlocale("LC_ALL","en_US")
library(sqldf)

if (!file.exists("household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                "exdata-data-household_power_consumption.zip", method="curl")
  unzip("exdata-data-household_power_consumption.zip")
}

## read and cleanup data
df1 <- read.csv.sql("household_power_consumption.txt", 
                    "select Date,Global_active_power from file where Date = '1/2/2007' or Date = '2/2/2007'", 
                    header=TRUE, sep = ";")

## create plot
png("plot1.png",width = 480, height = 480)
hist(df1$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()