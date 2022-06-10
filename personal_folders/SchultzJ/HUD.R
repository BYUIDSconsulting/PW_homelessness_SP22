library(tidyverse)
library(readxl)
library(httr)
library(plyr)
library(openxlsx)
library(plotly)
# data web link
# https://www.hudexchange.info/resource/3031/pit-and-hic-data-since-2007/
# 2007 - 2021 Point-in-Time Estimates by State 

hud_data <- function(y, url1= 'https://www.huduser.gov/portal/sites/default/files/xls/2007-2021-PIT-Counts-by-State.xlsx'){
  hud = read.xlsx(url1,sheet=y)
  names(hud) <- gsub(".", " ", names(hud), fixed = TRUE)
  hud$Year <- as.numeric(y)
  names(hud) = gsub(pattern = ",.*", replacement = "", x = names(hud))
  hud <- hud[-57,]
}


gather_hud_data <- function(){
  da2007 <- hud_data('2007')
  columns = colnames(da2007)
  da2008 <- hud_data('2008') %>% select(columns)
  da2009 <- hud_data('2009') %>% select(columns)
  da2010 <- hud_data('2010') %>% select(columns)
  da2011 <- hud_data('2011') %>% select(columns)
  da2012 <- hud_data('2012') %>% select(columns)
  da2013 <- hud_data('2013') %>% select(columns)
  da2014 <- hud_data('2014') %>% select(columns)
  da2015 <- hud_data('2015') %>% select(columns)
  da2016 <- hud_data('2016') %>% select(columns)
  da2017 <- hud_data('2017') %>% select(columns)
  da2018 <- hud_data('2018') %>% select(columns)
  da2019 <- hud_data('2019') %>% select(columns)
  da2020 <- hud_data('2020') %>% select(columns)
  
  
  result <- rbind(da2007, da2008, da2009, da2010, da2011, da2012, da2013,
                  da2014, da2015, da2016, da2017, da2018, da2019, da2020) %>% 
    rename(state = State)
}

results <- gather_hud_data()
