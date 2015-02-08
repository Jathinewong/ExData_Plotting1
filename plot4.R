## Objective : 	Examine how household energy usage varies from 01-02 Feb 2007
## Method :  	4 graphs in a single page

	## set working directory to where the household_power_consumption.txt file
	## before reading in data
	## Read in subset of data file, from 1/2/2007 to 2/2/2007 
		library(sqldf)

		household = read.csv.sql("household_power_consumption.txt", 
						sql = "select * from file 
								where Date in (\"2/2/2007\", \"1/2/2007\")", 
						sep = ";", eol="\n"
						)

	## Replace coded missing value '?' to na 
	## check for missing data
		is.na(household) <- household == "?"
		household[!complete.cases(household),]
		
	## No missing value
	## Combine Date and Time 
		library(lubridate)
		household$date_time = dmy_hms(paste(household$Date, household$Time, sep=" "))
	
	## Order the dataset by date_time before plotting
		household=household[order(household$date_time),]
		
		attach(household)

	## Plot 4 graphs to the screen
		plot.new()
		par(mfrow=c(2,2))
		
		## 1st plot - line graph of datetime vs Global Active Power
			plot(date_time, Global_active_power, type="n", 
				xlab="", ylab = "Global Active Power"
				)
			lines(date_time, Global_active_power)
			
		## 2nd plot - line graph of datetime vs Voltage
			plot(date_time, Voltage, type="n", xlab="datetime")
			lines(date_time, Voltage)
			
		## 3rd plot - line graph of date_time vs Sub_metering
		## use the highest max value from Sub_metering for the initial plot setup
			summary(household)
			
		## the highest max value of the 3 Sub_metering is Sub_metering_1
			plot(date_time, Sub_metering_1, type="n", 
					xlab="", ylab = "Energy sub metering"
				)
			lines(date_time, Sub_metering_1, col="black")
			lines(date_time, Sub_metering_2, col="red")
			lines(date_time, Sub_metering_3, col="blue")
			legend("topright", lty=c(1,1,1), col=c("black", "red", "blue"), 
				legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
				)
		
		## 4th plot - line graph datetime vs Global_reactive_power
			plot(date_time, Global_reactive_power, type="n", xlab = "datetime")
			lines(date_time, Global_reactive_power)
			
	## Check for file existence
		ifelse(file.exists("plot4.png"), "file already exists", "ok")
		
	## Output to png file
	## Setup file width, height and pixel
		png(filename = "plot4.png", width = 480, height = 480, units = "px")
		
		par(mfrow=c(2,2))
		
		## 1st plot - line graph of datetime vs Global Active Power
			plot(date_time, Global_active_power, type="n", 
					xlab="", ylab = "Global Active Power"
				)
			lines(date_time, Global_active_power)
			
		## 2nd plot - line graph of datetime vs Voltage
			plot(date_time, Voltage, type="n", xlab="datetime")
			lines(date_time, Voltage)
			
		## 3rd plot - line graph of date_time vs Sub_metering
		## the highest max value of the 3 Sub_metering is Sub_metering_1
			plot(date_time, Sub_metering_1, type="n", 
					xlab="", ylab = "Energy sub metering"
				)
			lines(date_time, Sub_metering_1, col="black")
			lines(date_time, Sub_metering_2, col="red")
			lines(date_time, Sub_metering_3, col="blue")
			legend("topright", lty=c(1,1,1), col=c("black", "red", "blue"), 
				legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
				)
		
		## 4th plot - line graph datetime vs Global_reactive_power
			plot(date_time, Global_reactive_power, type="n", xlab = "datetime")
			lines(date_time, Global_reactive_power)
			
		dev.off()
