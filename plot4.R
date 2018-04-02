plot4 <- function(x) {
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
                   "ReactPwr" = "Global_reactive_power",
                   "SubMet1" = "Sub_metering_1",
                   "SubMet2" = "Sub_metering_2",
                   "SubMet3" = "Sub_metering_3")
  
  png(filename = "plot4.png")
  par(mfrow = c(2, 2))
  plot(mydata$datetime, 
       mydata$ActPwr, 
       type = "o", 
       pch = ".", 
       xlab = " ", 
       ylab = "Global Active Power (kilowatts)",
       cex.lab = 0.7,
       cex.axis = 0.5,
       cex.axis = 0.7)
  
  plot(mydata$datetime, 
       mydata$Voltage, type = "o", 
       pch = ".", 
       xlab = "datetime", 
       ylab = "Voltage",
       cex.lab = 0.7,
       cex.axis = 0.7)
  
  plot(mydata$datetime, 
       mydata$SubMet1, 
       type = "o", 
       pch = ".", 
       xlab = " ", 
       ylab = "Energy sub metering",
       cex.lab = 0.7,
       cex.axis = 0.7)
  points(mydata$datetime, mydata$SubMet2, type = "o", pch = ".", xlab = " ", ylab = " ", col = "red")
  points(mydata$datetime, mydata$SubMet3, type = "o", pch = ".", xlab = " ", ylab = " ", col = "blue")
  legend("topright", legend = c("Sub_metering_1 ", "Sub_metering_2 ", "Sub_metering_3 "), lwd=1, cex=0.6, col=c("black", "red", "blue"), lty=1:1, box.lwd = 0)

  plot(mydata$datetime, 
       mydata$ReactPwr, type = "o", 
       pch = ".", 
       xlab = "datetime", 
       ylab = "Global_reactive_power",
       cex.lab = 0.7,
       cex.axis = 0.7)
  dev.off()
}