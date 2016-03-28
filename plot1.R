#read the two files 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Question 1
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years.
# Calculate sum of emissions grouped by year
SumEmissions <- aggregate(Emissions ~ year, data = NEI, FUN = sum)
#initiate png file
png("plot1.png", width=480,height=480)
#Create plot
barplot((height = SumEmissions$Emissions), names.arg = SumEmissions$year, xlab = "Year", ylab = "Total PM2.5 Emissions (tons)", main = "Total PM2.5 Emissions for all US Sources")
dev.off()