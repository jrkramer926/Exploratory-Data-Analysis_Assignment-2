directory <- "\\Users\\kcaj2\\Desktop\\Coursera\\Exploratory Data Analysis\\Assignment 2"
setwd(directory)

library(ggplot2)
##below reads the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
data <- merge(NEI,SCC, all.x = TRUE, by = "SCC")

#below makes a subset of the data showing "ON-ROAD" emissions in Baltimore City
balt.subset <- with(data, subset(data, fips == "24510" & type == "ON-ROAD"))

#below sums the emissions of our subset
balt.graph.data <- aggregate(balt.subset$Emissions, list(balt.subset$year), FUN = sum)
colnames(balt.graph.data) <- c("Year", "Emissions")

#below graphs total emissions by year and outputs it as a PNG
png("plot5.png")
ggplot(balt.graph.data, aes(x = Year, y = Emissions)) + 
    geom_line() +
    labs(title = "Vehicle Emissions in Baltimore City between 1999 and 2008") +
    theme(plot.title = element_text(size = 16), axis.title = element_text(size=14)) +
    ylab("PM2.5 Emissions (tons)")
dev.off()

