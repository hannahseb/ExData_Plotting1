library(readr)
library(tidyverse)

# read data
household_power_consumption <- read.csv('household_power_consumption.txt', sep=';',
                                        na.strings="?", 
                                        colClasses=c("character","character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))



# transform data types
str(household_power_consumption)
household_power_consumption$Date <- as.Date(household_power_consumption$Date,  format = "%d/%m/%Y")


# subset
data <- subset(household_power_consumption, Date >= "2007-02-01")
data <- subset(data, Date <= "2007-02-02")
table(data$Date)

str(data)

datetime <- paste(as.Date(data$Date), data$Time)
data$DateTime <- as.POSIXct(datetime)
data

# Open PNG Graphics device
png(filename="plot4.png", width=480, height=480)


# plot
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
      plot(Global_active_power~DateTime, type="l", 
           ylab="Global Active Power", xlab="")
      
      plot(Voltage~DateTime, type="l", 
           ylab="Voltage", xlab="")
      
      plot(Sub_metering_1~DateTime, type="l", 
           ylab="Energy sub metering", xlab="")
      lines(Sub_metering_2~DateTime,col='Red')
      lines(Sub_metering_3~DateTime,col='Blue')
      legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
             legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      
      plot(Global_reactive_power~DateTime, type="l", 
           ylab="Global Reactive Power",xlab="")
})
      
# Save histogram to png
dev.off()