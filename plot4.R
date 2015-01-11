# Course Project 1
# Our overall goal here is simply to examine how household energy usage 
# varies over a 2-day period in February, 2007.

# Source: This assignment uses data from the UC Irvine Machine Learning 
# Repository, a popular repository for machine learning datasets.

# Code to read the data so that the plot can be fully reproduced.
zipFileName <- "exdata-data-household_power_consumption.zip"
if(!file.exists(zipFileName))
{
        fileUrl1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl1,destfile=zipFileName,method="curl")
}
        
#if (!file.exists("household_power_consumption.txt"))
#{
#        file <- unzip(zipFileName)
#}
file <- unzip(zipFileName)
household <- read.table(file, header=T, sep=";")
household$Date <- as.Date(household$Date, format="%d/%m/%Y")
df <- household[(household$Date=="2007-02-01") | (household$Date=="2007-02-02"),]
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
df$Global_intensity <- as.numeric(as.character(df$Global_intensity))
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

# generate the plot for Global_active_power
df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

par(mfrow=c(2,2))

plot(df$timestamp,df$Global_active_power, type="l", 
     xlab="", ylab="Global Active Power")

plot(df$timestamp,df$Voltage, type="l", 
     xlab="datetime", ylab="Voltage")

plot(df$timestamp,df$Sub_metering_1, type="l", 
     xlab="", ylab="Energy sub metering")
lines(df$timestamp,df$Sub_metering_2,col="red")
lines(df$timestamp,df$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), 
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=c(1,1), bty="n", cex=.5)

plot(df$timestamp,df$Global_reactive_power, type="l", 
     xlab="datetime", ylab="Global_reactive_power")

# Code that creates the PNG file
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
