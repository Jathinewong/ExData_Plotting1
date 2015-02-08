## Objective : 	Examine how household energy usage varies from 01-02 Feb 2007
## Method :  	Histogram of Global Active Power
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
		
	## No missing data
		attach(household)

	## Plot graph to screen
		hist(Global_active_power, col="red", 
				xlab="Global Active Power (kilowatts)", 
				main="Global Active Power"
			)

	## Check for file existence
		ifelse(file.exists("plot1.png"), "file already exists", "ok")
			
	## Output plot to a png file
	## Setup file width, height and pixel
		png(filename = "plot1.png", width = 480, height = 480, units = "px")
	
		hist(Global_active_power, col="red", 
				xlab="Global Active Power (kilowatts)", 
				main="Global Active Power"
			)
					
		dev.off()