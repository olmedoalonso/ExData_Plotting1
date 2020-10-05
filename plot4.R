# Plot 4
#- Download the file and put it in the folder
if(!file.exists("./EDAWeek1")){dir.create(./EDAWeek1")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./EDAWeek1/EDAWeek1PeerGraded.zip")

#- Unzip the file to the folder
unzip(zipfile = ".//EDAWeek1/EDAWeek1PeerGraded.zip", exdir = "./EDAWeek1")

#- Unzip the files that are in the folder.  I created a function "pathway" for the path.
pathway <- file.path("./EDAWeek1", "household_power_consumption.txt")

# - Read the file
power_cons <- read.table(pathway, header = TRUE, sep = ";", dec = ".", na.strings = "?")

# - Subsetting to the dates required
sub_power_cons <- power_cons %>% filter(Date == "1/2/2007" | Date == "2/2/2007")
sub_power_cons$Date <- as.Date(sub_power_cons$Date, format="%d/%m/%Y") 

# Merging the Date and Time column and formatting to posixct for the name of the weekdays.
sub_power_cons_D_T <- paste(sub_power_cons$Date, sub_power_cons$Time) 
sub_power_cons_D_T <- as.POSIXct(sub_power_cons_D_T)

# #Plot 4 as PNG
png(file = "./EDAWeek1/plot4.png", width = 480, height = 480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(sub_power_cons, {
     plot(Global_active_power ~ sub_power_cons_D_T, type="l", ylab="Global Active Power (kilowatts)", xlab=" ")
     plot(Voltage ~ sub_power_cons_D_T, type="l", ylab="Voltage (volt)", xlab="")
     plot(Sub_metering_1 ~ sub_power_cons_D_T, type = "l", ylab="Energy sub metering", xlab = " ")
         lines(Sub_metering_2 ~ sub_power_cons_D_T, col = "Red")
         lines(Sub_metering_3 ~ sub_power_cons_D_T, col = "Blue")
         legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, lwd = 2)
     plot(Global_reactive_power ~ sub_power_cons_D_T, type="l", ylab="Global Reactive Power (kilowatts)",xlab="")
})
dev.off()


