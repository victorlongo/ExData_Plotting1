plot2 <- function(x) {
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
  mydata <- select(mydata, Global_active_power, datetime)
  mydata <- rename(mydata,
                   "ActPwr" = "Global_active_power")
  png(filename = "plot2.png")
  plot(mydata$datetime, mydata$ActPwr, type = "o", pch = ".", xlab = " ", ylab = "Global Active Power (kilowatts)")
  dev.off()
}