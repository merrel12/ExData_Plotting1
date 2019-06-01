##Plot 3##
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp, method="curl")
unzip(temp)
fh<-file("household_power_consumption.txt","r")
df<- read.table(text = grep("^[1,2]/2/2007",readLines(fh),value=TRUE), sep=";",na.strings="?")
unlink(temp)
colnames(df)<- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
DateTime <-paste(df$Date,df$Time)
df$DateTime <-strptime(DateTime, "%d/%m/%Y %H:%M:%S")
with(df, {
  plot(DateTime, Sub_metering_1,type="l",ylab="Energy sub metering",xlab="") 
  lines(DateTime, Sub_metering_2, col="red")
  lines(DateTime, Sub_metering_3, col="blue")
  legend ("topright",lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))}
)
dev.copy(png,file="plot3.png",width=480, height=480) 
dev.off()