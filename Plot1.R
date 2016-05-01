directory <- "\\Users\\kcaj2\\Desktop\\Coursera\\Exploratory Data Analysis\\Assignment 2"
setwd(directory)


##below reads the data
NEI <- readRDS("summarySCC_PM25.rds")

NEI1999 <- subset(NEI, NEI$year == 1999)
NEI2002 <- subset(NEI, NEI$year == 2002)
NEI2005 <- subset(NEI, NEI$year == 2005)
NEI2008 <- subset(NEI, NEI$year == 2008)

NEI1999$Emissions <- as.numeric(NEI1999$Emissions)
NEI2002$Emissions <- as.numeric(NEI2002$Emissions)
NEI2005$Emissions <- as.numeric(NEI2005$Emissions)
NEI2008$Emissions <- as.numeric(NEI2008$Emissions)

histdata <- c(
    sum(NEI1999$Emissions, na.rm = TRUE)/1000,
    sum(NEI2002$Emissions, na.rm = TRUE)/1000,
    sum(NEI2005$Emissions, na.rm = TRUE)/1000,
    sum(NEI2008$Emissions, na.rm = TRUE)/1000)

png(filename = "plot1.png")

barplot(histdata, 
        names.arg = c("1999","2002","2005","2008"),
        xlab = "Year", ylab = "PM2.5 Emissions (Kilotons)",
        main = "Total PM2.5 Emissions By Year")

dev.off()
