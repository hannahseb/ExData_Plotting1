library(readr)
library(tidyverse)

# read data
household_power_consumption <- read_delim("household_power_consumption.txt", 
                                          delim = ";", escape_double = FALSE, trim_ws = TRUE)



# transform data types
str(household_power_consumption)

household_power_consumption$Date <- as.Date(household_power_consumption$Date,  format = "%d/%m/%Y")


household_power_consumption$Time <- strftime(as.POSIXct("00:00:00", format="%H:%M:%S") + 
                                                   household_power_consumption$Time, format="%H:%M:%S")

# subset
data <- subset(household_power_consumption, Date >= "2007-02-01")
data <- subset(data, Date <= "2007-02-02")
table(data$Date)

str(data)

# Open PNG Graphics device
png(filename="plot1.png", width=480, height=480)

# plot
hist(as.numeric(as.character(data$Global_active_power)), main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")

# Save histogram to png
dev.off()
     