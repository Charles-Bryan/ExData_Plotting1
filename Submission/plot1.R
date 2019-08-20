## plot1.R

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
household_data <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";")

## Reducing the data
library(dplyr)
household_data_reduced <- filter(household_data, Date == "2/2/2007" | Date == "1/2/2007")

## Plot 1 Specific -------------------------------------------------------------

## Open the PNG file
png("plot1.png")

## Create the plot 
hist(as.numeric(as.character(household_data_reduced$Global_active_power)),
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     main = "Global Active Power",
     ylim = c(0,1200))

## Close the file
dev.off()