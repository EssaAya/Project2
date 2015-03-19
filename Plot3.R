library(plyr)
library(ggplot2)

# Loads RDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Balt_MD <- subset(NEI, fips == "24510")

type_year <- ddply(Balt_MD, .(year, type), function(x) sum(x$Emissions))
colnames(type_year)[3] <- "Emissions"

png("plot3.png")
qplot(year, Emissions, data=type_year, color=type, geom="line") +
ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emissions by Source Type and Year")) +
xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()