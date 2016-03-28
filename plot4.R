# read the two files 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# Question 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

library(ggplot2)
#Find all coal-combustion-related sources in the data set. 
coalsources <- grepl("coal", SCC$SCC.Level.Four, ignore.case = TRUE)
combustsources <-grepl("combust", SCC$SCC.Level.One, ignore.case = TRUE)
coalcombust <- (combustsources & coalsources)
combustSCC <- SCC[coalcombust,]$SCC
combustNEI <- NEI[NEI$SCC %in% combustSCC,]


#initiate png file
png("plot4.png", width=640,height=480)

ggplot <- ggplot(combustNEI, aes(factor(year), Emissions/10^5))
ggplot <- ggplot + geom_bar(stat ="identity", fill = "grey", width = 0.75)  + xlab("Year") + ylab("Total PM2.5 Emissions (10^5 tons)") + ggtitle("Total Emissions from Coal Combustion-Related Sources from 1999 to 2008")

print(ggplot)
dev.off()
