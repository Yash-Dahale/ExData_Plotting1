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

##Plot 2
plot(consump$Global_active_power~consump$time_date, type="l", ylab="Global Active Power (kilowatts)", xlab="")
#dev.copy(png,"plot2.png", width=480, height=480)
#dev.off()
