directory <- "\\Users\\kcaj2\\Desktop\\Coursera\\Exploratory Data Analysis\\Assignment 2"
setwd(directory)


##below reads the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
data <- merge(NEI,SCC, all.x = TRUE, by = "SCC")

coaldata <- subset(data, grepl("coal", data$SCC.Level.Three, ignore.case = TRUE))
graphdata <- aggregate(coaldata$Emissions, by = list(coaldata$type, coaldata$year), FUN =sum)
colnames(graphdata) <- c("Type", "Year", "Emissions")
agdata <- aggregate(graphdata$Emissions, by = list(graphdata$year), FUN = sum)
agdata$Type <- "AGGREGATE"
colnames(agdata) <- c("Year", "Emissions", "Type")
netgraphdata <- rbind(graphdata, agdata)
netgraphdata$Emissions <- netgraphdata$Emissions/1000
netgraphdata$Year <- as.factor(netgraphdata$Year)

png("plot4.png", width = 640, height = 480)
ggplot(netgraphdata, aes(x = Year, y = Emissions, group = Type, colour = Type)) + 
    geom_line(size=1.5) + 
    labs(title = "Coal Emissions by Type from 1999 to 2008" ) +
    ylab("PM2.5 Emissions (Kilotons)")
dev.off()
