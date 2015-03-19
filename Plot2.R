# Loads RDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Samples data for testing
sample_NEI <- NEI[sample(nrow(NEI), size = 5000, replace = F), ]

# Subsets and appends two years data into one data frame
Balt_MD <- subset(NEI, fips == '24510')

png(filename = 'plot2.png')
barplot(tapply(X = Balt_MD$Emissions, INDEX = Balt_MD$year, FUN = sum), main = 'Total Emission in Baltimore, Maryland', xlab = 'Year', ylab = expression('PM'[2.5]))
dev.off()