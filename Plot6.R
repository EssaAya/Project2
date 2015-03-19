# Loads RDS
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
NEI$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))
SCC <- readRDS("Source_Classification_Code.rds")

# Baltimore City, Maryland
# Los Angeles County, California
MD_onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
CA_onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

# Aggregates
MD_aggr <- aggregate(MD_onroad[, 'Emissions'], by = list(MD_onroad$year), sum)
colnames(MD_aggr) <- c('year', 'Emissions')
MD_aggr$City <- paste(rep('MD', 4))

CA_aggr <- aggregate(CA_onroad[, 'Emissions'], by = list(CA_onroad$year), sum)
colnames(CA_aggr) <- c('year', 'Emissions')
CA_aggr$City <- paste(rep('CA', 4))

plot_data <- as.data.frame(rbind(MD_aggr, CA_aggr))

png('plot6.png')
ggplot(data = plot_data, aes(x = year, y = Emissions)) + geom_bar(aes(fill = year),stat = "identity") + guides(fill = F) + ggtitle('Comparison of total Emissions by Motor Vehicle in Los Angeles California and Baltimore, Maryland') + ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position = 'none') + facet_grid(. ~ City) + geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = -1))
dev.off()