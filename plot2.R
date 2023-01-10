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
png(filename="plot2.png", width=480, height=480)

# plot
plot(data$Global_active_power~data$DateTime, type="l",
      ylab="Global Active Power (kilowatts)", xlab="")

# Save histogram to png
dev.off()
