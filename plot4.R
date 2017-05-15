########################################################
# PLOT 4                                               #
# Course-3 Week-1 Project-1                            #
#                                                      #
# Line Plots from household_power_consumption data     #
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

# 4 plots as 2x2
par(mfrow=c(2,2))

# plot 1st graph 
with(df, plot(Date, Global_active_power,
              type = "l",
              xlab = "",
              ylab = "Global Active Power"))

# plot 2nd graph 
with(df, plot(Date, Voltage,
              type = "l",
              xlab = "datetime"))

# plot 3rd graph 
# plot line graph for Sub_metering_1 in 3rd graph
  with(df, plot(Date, Sub_metering_1,
       type = "l",
       xlab = "",
       ylab = "Energy sub metering"))

# add line graph for Sub_metering_2 in 3rd graph
  with(df, lines(Date, Sub_metering_2,
                col = "Red"))
  
# add line graph for Sub_metering_3 in 3rd graph
  with(df, lines(Date, Sub_metering_3,
                 col = "Blue"))

  # add legends wihout box in 3rd graph
  legend("topright", 
         lwd = c(2, 2, 2),
         col = c("Black", "Red", "Blue"),
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         bty = "n")

# plot 4th graph 
# plot line graph without y-axis in 4th graph
  with(df, plot(Date, Global_reactive_power,
                type = "l",
                xlab = "datetime",
                yaxt="n"))

# plot add y-axis to accomodate all tick labels in 4th graph
  axis(2,cex.axis=0.7)

# save to png file
dev.print(device=png, filename='plot4.png', width=480, height=480) 
dev.off()
