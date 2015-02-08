## Objective : 	Examine how household energy usage varies from 01-02 Feb 2007
## Method :  	Line Graph of Global Active Power by date time
##
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
		
	## plot graph to screen
		par(mfrow=c(1,1))
		plot(date_time, Global_active_power, type="n", 
			xlab="", ylab = "Global Active Power (kilowatts)"
			)
		lines(date_time, Global_active_power)
	
	## Check for file existence
		ifelse(file.exists("plot2.png"), "file already exists", "ok")
		
	## Output to png file
	## Setup file width, height and pixel
		png(filename = "plot2.png", width = 480, height = 480, units = "px") 
		plot(date_time, Global_active_power, type="n", 
			xlab="", ylab = "Global Active Power (kilowatts)"
			)
		lines(date_time, Global_active_power)
						
		dev.off()