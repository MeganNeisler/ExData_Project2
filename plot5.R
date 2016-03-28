# read the two files 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# Question 5. How have emissions from motor vehical sources changed from 1999-2008 in Baltimore City, MD?

library(ggplot2)
#Find all motor vehicle sources in the data set. 
vehicleSources <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehicleSourceSCC <- SCC[vehicleSources,]$SCC
vehicleSourceNEI <- NEI[NEI$SCC %in% vehicleSourceSCC, ]

#subset for Baltimore data.
BaltimoreVehiclesNEI <- vehicleSourceNEI[vehicleSourceNEI$fips=="24510",]

#initiate png file
png("plot5.png", width=640,height=480)
#creat plot
ggplot <- ggplot(BaltimoreVehiclesNEI, aes(factor(year), Emissions))
ggplot <- ggplot + geom_bar(stat ="identity", fill = "grey", width = 0.75)  + xlab("Year") + ylab("Total PM2.5 Emissions (tons)") + ggtitle("Total Emissions from Motor Vehicle Sources in Baltimore from 1999 to 2008")

print(ggplot)
dev.off()
