## plot3.R

## Downloading the data

if(!file.exists("./data")){
        dir.create("./data")
        
        # Download the data if it is not there
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile="./data.zip")
        
        # Unzip the downloaded zip file
        zipF<- "./data.zip"
        outDir<-"./data"
        unzip(zipF,exdir=outDir)
        
        # Remove the zip file
        unlink("./data.zip")
}

## Reading in the data
household_data <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors=FALSE)

## Reducing the data
library(dplyr)
household_data_reduced <- filter(household_data, Date == "2/2/2007" | Date == "1/2/2007")

## Plot 3 Specific -------------------------------------------------------------

## Open the PNG file
png("plot3.png")

## Modify the dataframe to have a variable for date and time combined
household_data_reduced <- mutate(household_data_reduced,
                                 Datetime = as.POSIXct(paste(household_data_reduced$Date,
                                                             household_data_reduced$Time),
                                                       format="%d/%m/%Y %H:%M:%S"))

## Create the plot 
plot(Sub_metering_1 ~ Datetime, data = household_data_reduced, type = "l",
     xlab = "",
     ylab = "Energy sub metering")
points(Sub_metering_2 ~ Datetime, data = household_data_reduced, type = "l", col = "red")
points(Sub_metering_3 ~ Datetime, data = household_data_reduced, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black","red","blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))


## Close the file
dev.off()