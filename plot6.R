# read the two files 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# Question 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vechicle sources in
#Los Angeles County, California. Which city has seen greater changes over time in emissions?

library(ggplot2)
#Find all motor vehicle sources in the data set. 
vehicleSources <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehicleSourceSCC <- SCC[vehicleSources,]$SCC
vehicleSourceNEI <- NEI[NEI$SCC %in% vehicleSourceSCC, ]

#subset the vehicles NEI data for each city.
subsetVehicleNEI <- vehicleSourceNEI[(vehicleSourceNEI$fips=="24510"|vehicleSourceNEI$fips=="06037"), ]

#sum by year and city

sumCityEmissions <- aggregate(Emissions ~ year + fips, data = subsetVehicleNEI, FUN = sum)
#add city names
sumCityEmissions$fips[sumCityEmissions$fips=="24510"] <- "Baltimore, MD"
sumCityEmissions$fips[sumCityEmissions$fips=="06037"] <- "Los Angeles, CA"

#initiate png file
png("plot6.png", width=640,height=480)

#create plot with appropriate labels
ggplot <- ggplot(sumCityEmissions, aes(factor(year), Emissions))
ggplot <- ggplot + facet_grid(.~fips) 
ggplot <- ggplot + geom_bar(stat = "identity") + xlab("Year") + ylab("Total PM2.5 Emissions (tons)") + ggtitle("Total Emissions from Motor Vehicle Sources in Baltimore and Los Angeles,1999 to 2008") 


print(ggplot)
dev.off()