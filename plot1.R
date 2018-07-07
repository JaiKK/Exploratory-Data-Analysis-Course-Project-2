source(file = "EPA_Data_Analysis.R")

# Answer 1: 
par("mfrow" = c(1,1))
png('plot1.png', width=480, height=480)

tmp <- NEI %>% select(Emissions, year) %>% group_by(year) %>% summarise(Total = sum(Emissions))
plot(x= tmp$year, 
     y= tmp$Total,
     xlab = "Emisson Year",
     ylab = "Emission [ Tons ]",
     main = "Yearwise Emission of PM2.5 (Tons)",
     type = "l")

dev.off()