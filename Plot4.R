# script to generate plot 4 of Exploratory data analysis project 1
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="powerdata.zip",method="curl")

# reading the data into R
path2data<-"household_power_consumption.txt"
powrdata<-read.csv(path2data,sep=";",na.strings="?",colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),nrows=69550)

# Parsing the "Date" & "Time" columns as date-time objects using lubridate
library(dplyr)
library(lubridate)
date<-dmy(powrdata$Date)
time<-hms(powrdata$Time)
hrs<-hour(time)
mins<-minute(time)
date<-update(date,hour=hrs,minutes=mins)
powrdata2<-select(powrdata,Global_active_power:Sub_metering_3)
powrdata2<-cbind(date,powrdata2)
tbl_df(powrdata2)

# subsetting powrdata2 to get only the relevant data for the plots; done manually

# Plot 4
par(mfrow=c(2,2),mar=c(4,4,2,1))
plot(powrdata2$date[66637:69516],powrdata2$Global_active_power[66637:69516],"l",main="",xlab="",ylab="Global Active Power(kilowatts)")
plot(powrdata2$date[66637:69516],powrdata2$Voltage[66637:69516],"l",main="",xlab="datetime",ylab="Voltage")
plot(powrdata2$date[66637:69516],powrdata2$Sub_metering_1[66637:69516],type="n",main="",xlab="",ylab="Energy sub metering")
points(powrdata2$date[66637:69516],powrdata2$Sub_metering_2[66637:69516],"l",col="red")
points(powrdata2$date[66637:69516],powrdata2$Sub_metering_3[66637:69516],"l",col="blue")
points(powrdata2$date[66637:69516],powrdata2$Sub_metering_1[66637:69516],"l")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=1,bty="n")
plot(powrdata2$date[66637:69516],powrdata2$Global_reactive_power[66637:69516],"l",main="",xlab="",ylab="Global_Reactive_Power")
dev.copy(png,filename="Plot4.png",width=480,height=480,units="px")
dev.off()
