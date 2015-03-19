# Loads RDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
 
# Samples data
sample_NEI <- NEI[sample(nrow(NEI), size = 1000, replace = F), ]

# Aggregating and rounding
aggemiss <- aggregate(NEI[, 'Emissions'], by = list(NEI$year), FUN = sum)
roundemiss <- round(aggemiss[, 2] / 1000, 2)
 
png(filename = "plot1.png")
barplot(roundemiss, names.arg = aggemiss$Group.1, main = expression('Total Emission of PM'[2.5]), xlab = 'Year', ylab = expression(paste('PM', ''[2.5], ' in Kilotons')))
dev.off()