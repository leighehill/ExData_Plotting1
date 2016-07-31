## read main data
dat <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                  na.strings = "?", stringsAsFactors = FALSE)

##convert date column to date
dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y")

## subset data
##   I tried to do this with the || operator, but I must have done it wrong 
##   because the result data frame was wonky.  :\
conddat <- dat[dat$Date == "2007-02-01", ]
temp <- dat[dat$Date == "2007-02-02", ]
conddat <- rbind(conddat, temp)

## combine datetime together and add it as a column
datetime <- strptime(paste(conddat$Date, conddat$Time), 
                     format = "%Y-%m-%d %H:%M:%S")
conddat <- cbind(conddat, datetime = datetime)

## open graphics device
png(filename = "plot2.png")

## plot
plot(conddat$datetime, conddat$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")

## close plot
dev.off()