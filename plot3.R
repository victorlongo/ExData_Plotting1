plot3 <- function(x) {
  library(data.table)
  library(lubridate)
  library(dplyr)
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                destfile = "./rawdata.zip")
  unzip("rawdata.zip")
  rawdata <- read.table("household_power_consumption.txt", 
                        header = TRUE, 
                        sep = ";", 
                        na.strings = "?")
  mydata <- filter(rawdata, 
                   Date == "1/2/2007" | Date == "2/2/2007")
  mydata$datetime <- dmy_hms(apply(mydata[,1:2], 
                                   1, 
                                   paste, 
                                   collapse=" "))
  mydata <- rename(mydata,
                   "ActPwr" = "Global_active_power",
                   "SubMet1" = "Sub_metering_1",
                   "SubMet2" = "Sub_metering_2",
                   "SubMet3" = "Sub_metering_3")
  mydata <- select(mydata, datetime, ActPwr, SubMet1, SubMet2, SubMet3)
  png(filename = "plot3.png")
  plot(mydata$datetime, mydata$SubMet1, type = "o", pch = ".", xlab = " ", ylab = "Energy sub metering")
  points(mydata$datetime, mydata$SubMet2, type = "o", pch = ".", xlab = " ", ylab = " ", col = "red")
  points(mydata$datetime, mydata$SubMet3, type = "o", pch = ".", xlab = " ", ylab = " ", col = "blue")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), bty = "o", lty = 1)
  dev.off()
}