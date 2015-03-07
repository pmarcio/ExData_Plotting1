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
png(file = "plot3.png") 

## Create plots with lines, name the ylabel and unname the xlabel on first)
## and the next without any label names and using lines
## The abreviated weekdays appears in my language Portuguese (qui=Thu, sex=Fri, sab=Sat)
plot(filteredDH$DateHour,filtered$Sub_metering_1,type="l",col="black",ylab="Energy sub metering",xlab="")
lines(filteredDH$DateHour,filteredDH$Sub_metering_2,type="l",col="red",ylab="",xlab="")
lines(filteredDH$DateHour,filteredDH$Sub_metering_3,type="l",col="blue",ylab="",xlab="")

## legend put at top right
legend("topright" , c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lwd=1, lty=1)

## Close the PNG file device
dev.off()