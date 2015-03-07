library(data.table)
library(datasets)
## read file create data frame
data <- fread("household_power_consumption.txt",sep=";")

## create data frame with only the dates of interest
filtered <- subset(data,data$Date=="2/2/2007" | data$Date=="1/2/2007")

## formats the fields numerics as numerics
filtered$Global_reactive_power <- as.numeric(filtered$Global_reactive_power)
filtered$Global_active_power <- as.numeric(filtered$Global_active_power)
filtered$Voltage <- as.numeric(filtered$Voltage)
filtered$Global_intensity <- as.numeric(filtered$Global_intensity)
filtered$Sub_metering_1 <- as.numeric(filtered$Sub_metering_1)
filtered$Sub_metering_2 <- as.numeric(filtered$Sub_metering_2)
filtered$Sub_metering_3 <- as.numeric(filtered$Sub_metering_3)

## formats the Date Time POSIX and inserts value in new column
DateHour <- paste(filtered$Date,filtered$Time)
DateHour <- strptime(DateHour, "%d/%m/%Y %H:%M:%S")
filteredDH <- cbind(filtered,DateHour)

## Open PNG file device; create 'plot1.png'
png(file = "plot2.png") 

## Create plot with lines, name the ylabel and unname the xlabel)
## The abreviated weekdays appears in my language Portuguese (qui=Thu, sex=Fri, sab=Sat)
with(filteredDH, plot(DateHour,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab=""))

## Close the PNG file device
dev.off()