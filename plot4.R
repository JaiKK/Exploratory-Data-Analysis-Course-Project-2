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


# ggplot(tmp) +
#   geom_point(aes(x= year, y = Total, colour = factor(type))) +
#   geom_line(aes(x= year, y = Total, colour = factor(type))) +
#   xlab("Year wise") +
#   ylab("Totle Emission / Type wise") +
#   ggtitle("Type and Year wise Emission (Tons) in Baltimore City") +
#   theme_minimal() +
#   theme(
#     text = element_text(size = 12),
#     axis.text.x = element_text(angle = 90),
#     plot.title = element_text(hjust = 0.5)
#     )

dev.off()
