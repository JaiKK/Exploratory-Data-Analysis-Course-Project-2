source(file = "EPA_Data_Analysis.R")

library(ggplot2)

# Answer 1: 
par("mfrow" = c(1,1))
png('plot4.png', width=1200, height=800)


tmpCoal <- SCC %>% mutate(coal = ifelse( grepl("COAL",toupper(EI.Sector)) , 1, 0 ))

tmpCoal$SCC <- as.character(tmpCoal$SCC)

tmp <- NEI %>% 
  inner_join(tmpCoal, by = "SCC") %>%
  select(Emissions, year, coal) %>% 
  filter(coal == 1) %>%
  group_by(year) %>% 
  summarise(Total = sum(Emissions))

plot(x= tmp$year,
     y= tmp$Total,
     xlab = "Emisson Year",
     ylab = "Emission [ Tons ]",
     main = "Yearwise Emission of PM2.5 (Tons) from Coal Sources",
     type = "l")

dev.off()
