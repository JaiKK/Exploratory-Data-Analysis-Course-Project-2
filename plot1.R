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