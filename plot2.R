########################################################
# PLOT 2                                               #
# Course-3 Week-1 Project-1                            #
#                                                      #
# Line Plot from household_power_consumption data      #
# Save plot to png file                                #
########################################################          

# Download household energy usage data set file and unzip it
if (!file.exists("household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                "./power.zip", method = "curl")
  unzip("./power.zip")
  }

# read into data frame
df <- read.table(file="household_power_consumption.txt",
                 sep = ";", na.strings = "?", header = TRUE,
                 colClasses = c(rep("character",2), rep("numeric",7)))

# filter out the 2 dates required
df <- df[(df$Date == "1/2/2007" | df$Date == "2/2/2007"),]

# concatenate Date, Time columns and change to POSIXlt date type
df$Date <- strptime(paste(df$Date,df$Time), format = "%d/%m/%Y %H:%M:%S")

# plot line graph with Titles as mentioned
plot(df$Date,
     df$Global_active_power, 
     type = "l", 
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

# save to png file
dev.print(device=png, filename='plot2.png', width=480, height=480) 
dev.off()
