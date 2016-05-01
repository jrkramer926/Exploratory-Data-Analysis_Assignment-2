directory <- "\\Users\\kcaj2\\Desktop\\Coursera\\Exploratory Data Analysis\\Assignment 2"
setwd(directory)

##below reads the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

balt.subset <- with(NEI, subset(NEI, fips == "24510"))
histdata <- aggregate(balt.subset$Emissions, by=list(balt.subset$year), FUN = sum)

png(filename = "plot2.png")

barplot(histdata[,2],
        names.arg = c("1999","2002","2005","2008"),
        xlab = "Year", 
        ylab = "PM2.5 Emissions (Tons)",
        main = "Total PM2.5 Emissions in Baltimore City")
dev.off()
