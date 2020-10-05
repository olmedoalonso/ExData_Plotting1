# Plot 1
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

# Changing the date column format from character to date.
sub_power_cons$Date <- as.Date(sub_power_cons$Date, format = "%d/%m/%Y")

#Plot 1 as PNG
png("./EDAWeek1/plot1.png", width = 480, height = 480)
hist(sub_power_cons$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "Red")
dev.off()

