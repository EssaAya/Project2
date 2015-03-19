# Loads RDS
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
NEI_year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))
SCC <- readRDS("Source_Classification_Code.rds")

# Baltimore City, Maryland == fips
Balt_onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

# Aggregates
Balt_aggr <- aggregate(Balt_onroad[, 'Emissions'], by = list(Balt_onroad$year), sum)
colnames(Balt_aggr) <- c('year', 'Emissions')

png('plot5.png')
ggplot(Balt_aggr, aes(factor(year), Emissions)) + geom_bar(aes(fill = year), stat = "identity") + guides(fill = F) + ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore, Maryland') + ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position = 'none') + geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = 2))
dev.off()