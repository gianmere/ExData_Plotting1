#if the datatable file doesn't exist, downloads and unzips it
if (!file.exists("household_power_consumption.txt")) {
    
    dataset_file <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(dataset_file, "data.zip", method = "curl")
    unzip("data.zip")
}

#Load the first row and the headers
dt_for_name <- read.table("household_power_consumption.txt", sep = ";", header = T, nrow = 1, na.strings = "?")

#Load only the data that will be used
dt <- read.table("household_power_consumption.txt", sep = ";", header = F, skip = 66637, nrow = 2880)

#Give a name to the columns of the datatable
names(dt) <- names(dt_for_name)

#Create an array with the relevant dates
date_time_str <- paste(dt$Date, dt$Time, sep = "-")
date_time <- strptime(date_time_str, "%d/%m/%Y-%H:%M:%S")

#Create the file with the graphic
png(file="plot2.png", width = 480, height = 480)
plot(date_time, dt$Global_active_power, type = "l", xlab = "", ylab = "Global Archive Power (kilowatts)")
dev.off()