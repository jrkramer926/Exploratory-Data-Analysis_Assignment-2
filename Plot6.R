directory <- "\\Users\\kcaj2\\Desktop\\Coursera\\Exploratory Data Analysis\\Assignment 2"
setwd(directory)

library(ggplot2)
##below reads the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
data <- merge(NEI,SCC, all.x = TRUE, by = "SCC")

#below subsets Baltimore City data and aggregates it by year
balt.subset <- with(data, subset(data, fips == "24510" & type == "ON-ROAD"))
balt.graph.data <- aggregate(balt.subset$Emissions, list(balt.subset$year, balt.subset$fips), FUN = sum)
colnames(balt.graph.data) <- c("Year", "County", "Emissions")

#below subsets Los Angeles data and aggregates it by year
LA.subset <- with(data, subset(data, fips == "06037" & type == "ON-ROAD"))
LA.graph.data <- aggregate(LA.subset$Emissions, list(LA.subset$year, LA.subset$fips), FUN = sum)
colnames(LA.graph.data) <- c("Year", "County", "Emissions")

#below combines the above subsets into one frame and makes it more presentable for a graph
graphdata <- rbind(balt.graph.data, LA.graph.data)
graphdata$County[graphdata$County=="24510"] <- "Baltimore City"
graphdata$County[graphdata$County=="06037"] <- "Los Angeles"
graphdata$Year <- as.factor(graphdata$Year)


#below creates a graph and outputs it to PNG
png("plot6.png")
ggplot(graphdata, aes(x = Year, y = Emissions, group = County, colour = County)) + 
    geom_line() +
    labs(title = "Vehicle Emissions between 1999 and 2008") +
    theme(plot.title = element_text(size = 16), axis.title = element_text(size=14)) +
    ylab("PM2.5 Emissions (tons)")
dev.off()

