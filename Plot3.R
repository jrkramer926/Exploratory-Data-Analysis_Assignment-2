directory <- "\\Users\\kcaj2\\Desktop\\Coursera\\Exploratory Data Analysis\\Assignment 2"
setwd(directory)

library("ggplot2")

#below reads the data and creates a subset with only Baltimore City
NEI <- readRDS("summarySCC_PM25.rds")
balt.subset <- with(NEI, subset(NEI, fips == "24510"))

#below creates a seperate dataframe to graph a line
linedata <- aggregate(balt.subset$Emissions, by=list(balt.subset$year, balt.subset$type), FUN = sum)
colnames(linedata) <-c("Year", "Type", "Emissions")
linedata$Type <- as.factor(linedata$Type)
linedata$Year <- as.factor(as.character(linedata$Year))


##below creates a PNG of the graph
png(filename = "plot3a.png", width = 640, height = 480)
plot3a <- ggplot(linedata, aes(x = Year, y = Emissions, group = Type, colour = Type)) + 
    geom_line() +
    geom_point() +
    labs(title = "Emissions by Type in Baltimore City from 1999-2008") +
    ylab("PM2.5 Emissions (Kilotons)")
print(plot3a)
dev.off()

#below creates a seperate dataframe to experiment with facets
bardata <- balt.subset
bardata$year <- as.factor(balt.subset$year)

png(filename = "plot3b.png", width = 960, height = 480)
plot3b <- ggplot(bardata, aes(x=year, y=Emissions, fill = year)) +
    geom_bar(stat = "identity") + facet_grid(.~type, scales = "free") + 
    scale_x_discrete(labels=c("1999", "2002", "2005", "2008")) +
    labs(title = "Emissions by Type in Baltimore City from 1999-2008") +
    ylab("PM2.5 Emissions (Kilotons)")
print(plot3b)
dev.off()
