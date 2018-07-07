source(file = "EPA_Data_Analysis.R")

library(ggplot2)

# Answer 1: 
par("mfrow" = c(1,1))
png('plot6.png', width=1200, height=800)


tmpMobile <- SCC %>% mutate(mobile = ifelse( grepl("MOBILE",toupper(EI.Sector)) , 1, 0 ))

tmpMobile$SCC <- as.character(tmpMobile$SCC)

tmp <- NEI %>% 
  inner_join(tmpMobile, by = "SCC") %>%
  select(Emissions, year, mobile, fips) %>% 
  filter(mobile == 1 & (fips == "24510" | fips == "06037")) %>%
  group_by(year, fips) %>% 
  summarise(Total = sum(Emissions))

ggplot(tmp) +
  geom_point(aes(x= year, y = Total, colour = factor(fips))) +
  geom_line(aes(x= year, y = Total, colour = factor(fips))) +
  xlab("Year wise") +
  ylab("Totle Emission / City wise") +
  ggtitle("Year wise Emission Comparission [Baltimore City(24510) & Los Angeles County(06037)]") +
  theme_minimal() +
  theme(
    text = element_text(size = 12),
    axis.text.x = element_text(angle = 90),
    plot.title = element_text(hjust = 0.5)
    )

dev.off()
