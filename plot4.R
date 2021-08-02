##Read The Data

consump <- read.table("household_power_consumption.txt", header=TRUE,  na.strings = "?",colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'), sep=";")
consump$Date <- as.Date(consump$Date, "%d/%m/%Y")

consump <- subset(consump,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
consump <- consump[complete.cases(consump),]
time_date <- paste(consump$Date, consump$Time)
time_date <- setNames(time_date, "DateTime")
consump <- consump[ ,!(names(consump) %in% c("Date","Time"))]
consump<- cbind(time_date, consump)
consump$time_date <- as.POSIXct(time_date)

##Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(consump, {
  plot(Global_active_power~time_date, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~time_date, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~time_date, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~time_date,col='Red')
  lines(Sub_metering_3~time_date,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~time_date, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

#dev.copy(png, file="plot4.png", height=480, width=480)
#dev.off()

