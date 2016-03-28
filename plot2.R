# read the two files 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# Question 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
#subset for Baltimore data.
BaltimoreNEI <- NEI[NEI$fips=="24510",]
# Calculate sum of emissions grouped by year
SumBEmissions <- aggregate(Emissions ~ year, data = BaltimoreNEI, FUN = sum)
#initiate png file
png("plot2.png", width=480,height=480)
#Create plot
barplot((height = SumBEmissions$Emissions), names.arg = SumBEmissions$year, xlab = "Year", ylab = "Total PM2.5 Emissions (tons)", main = "Total PM2.5 Emissions in Baltimore City, MD")
dev.off()