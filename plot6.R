library(dplyr)

# First need to download the zip file and extract all the files.
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
fileLocal <- "NEI_Data.zip"

# download file if its not present locally
if(!file.exists(fileLocal)){
  download.file(fileURL, fileLocal)
}


SCCExist <- file.exists("Source_Classification_Code.rds")
summarySSCExist <- file.exists("summarySCC_PM25.rds")

#Unzip the zip file in current folder.
if(!SCCExist || !summarySSCExist){
  unzip(zipfile =  fileLocal, exdir = ".", overwrite = TRUE)  
}


#NEI <- readRDS(file = "summarySCC_PM25.rds")
if(!"NEI" %in% objects()) NEI <- readRDS(file = "summarySCC_PM25.rds")
#SCC <- readRDS(file = "Source_Classification_Code.rds")
if(!"SCC" %in% objects()) SCC <- readRDS(file = "Source_Classification_Code.rds")


library(ggplot2)

# Answer 6: 
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
