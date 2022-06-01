library(tidyverse)
library(readxl)
library(httr)
library(plyr)

year = c('2008', '2009','2010', '2011', '2012', '2013', '2014', '2015', '2016' ,'2017', '2018', '2019', '2020', '2021')
url1 = 'https://www.huduser.gov/portal/sites/default/files/xls/2007-2021-HIC-Counts-by-State.xlsx'

data_gather <- function(y){
  hud <- read_excel("data/2007-2021-PIT-Counts-by-State.xlsx", sheet = y)
  hud$year <- y
  names(hud) = gsub(pattern = ",.*", replacement = "", x = names(hud))
  hud <- hud[-57,]
}


GET(url1, write_disk(tf <- tempfile(fileext = ".xlsx")))
df <- read_excel(tf, 2L)
    
da2007 <- data_gather('2007')
da2008 <- data_gather('2008')
da2009 <- data_gather('2009')
da2010 <- data_gather('2010')
da2011 <- data_gather('2011')
da2012 <- data_gather('2012')
da2013 <- data_gather('2013')
da2014 <- data_gather('2014')
da2015 <- data_gather('2015')
da2016 <- data_gather('2016')
da2017 <- data_gather('2017')
da2018 <- data_gather('2018')
da2019 <- data_gather('2019')
da2020 <- data_gather('2020')
da2021 <- data_gather('2021')


result <- rbind.fill(da2007, da2008, da2009, da2010, da2011, da2012, da2013,
                     da2014, da2015, da2016, da2017, da2018, da2019, da2020, da2021)


write.csv(result,"Path to export the DataFrame\\File Name.csv", row.names = FALSE)