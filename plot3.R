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

# Answer 3: 
par("mfrow" = c(1,1))
png('plot3.png', width=1200, height=800)

tmp <- NEI %>% 
  select(Emissions, year, fips, type) %>% 
  filter(fips == "24510") %>%
  group_by(year, type) %>% 
  summarise(Total = sum(Emissions))

ggplot(tmp) +
  geom_point(aes(x= year, y = Total, colour = factor(type))) +
  geom_line(aes(x= year, y = Total, colour = factor(type))) +
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
