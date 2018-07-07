source(file = "EPA_Data_Analysis.R")

library(ggplot2)

# Answer 1: 
par("mfrow" = c(1,1))
png('plot3.png', width=1200, height=800)

tmp <- NEI %>% 
  select(Emissions, year, fips, type) %>% 
  filter(fips == "24510") %>%
  group_by(year, type) %>% 
  summarise(Total = sum(Emissions))

# plot(x= tmp$year, 
#      y= tmp$Total,
#      xlab = "Emisson Year",
#      ylab = "Emission [ Tons ]",
#      main = "Yearwise Emission of PM2.5 (Tons) in Baltimore City",
#      type = "l")


ggplot(tmp) +
  geom_point(aes(x= year, y = Total, colour = factor(type))) +
  geom_line(aes(x= year, y = Total, colour = factor(type))) +
  # geom_text( aes(x= year, y = Total),
  #            label = round(tmp$Total,1)
  # ) +
  xlab("Year wise") +
  ylab("Totle Emission / Type wise") +
  ggtitle("Type and Year wise Emission (Tons) in Baltimore City") +
  theme_minimal() +
  theme(
    text = element_text(size = 12),
    axis.text.x = element_text(angle = 90),
    plot.title = element_text(hjust = 0.5)
    )

dev.off()