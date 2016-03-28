# read the two files 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# Question 3. Of the four types of sources indicated by the type varaible, which of these four sources have seen decreases
# in emissions from 1999-2008 for Baltimore City? Which have seen increases?
#subset for Baltimore data.
BaltimoreNEI <- NEI[NEI$fips=="24510",]
# Calculate sum of emissions grouped by year and type.
SumBEmissions <- aggregate(Emissions ~ year + type, data = BaltimoreNEI, FUN = sum)
#initiate png file
png("plot3.png", width=640,height=480)
#crate ggplot of emissions in Baltimore City showing type variable.
library(ggplot2)

ggplot <- ggplot(SumBEmissions, aes(year, Emissions, color = type))
ggplot <- ggplot + geom_line()  + xlab("Year") + ylab("Total PM2.5 Emissions (tons)") + ggtitle("Total Emissions in Baltimore City, MD from 1999 to 2008 by Source Type")

print(ggplot)
dev.off()
