# Loads RDS
require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Coal related SCC
SCC_coal = SCC[grepl("coal", SCC$Short.Name, ignore.case = TRUE), ]

# Merg two data sets
merged <- merge(x = NEI, y = SCC_coal, by = 'SCC')
merge_sum <- aggregate(merged[, 'Emissions'], by = list(merged$year), sum)
colnames(merge_sum) <- c('Year', 'Emissions')

png(filename = 'plot4.png')
ggplot(data = merge_sum, aes(x = Year, y = Emissions / 1000)) + geom_line(aes(group = 1, col = Emissions)) + geom_point(aes(size = 2, col = Emissions)) + ggtitle(expression('Total Emissions of PM'[2.5])) + ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) + geom_text(aes(label = round(Emissions / 1000, digits = 2), size = 2, hjust = 1.5, vjust = 1.5)) + theme(legend.position = 'none') + scale_colour_gradient(low = 'black', high = 'red')
dev.off()