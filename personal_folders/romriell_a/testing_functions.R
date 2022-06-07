# testing funcitons

# looking in the spot where the functions live.
source('homelessR/R/bea.r')

# getting the api key
bea_key <- Sys.getenv('bea_api_key')

# loading in the GET dependency
library(httr)
library(rjson)
library(dplyr)
library(tidyr)
library(stringr)
# getting how long it takes to run the function
start <- Sys.time()
dat_test <- tot_employ(bea_key)
duration <- Sys.time() - start
duration
# how long does it take to get all the data from tot_employ
# duration: 8.84 Mins
View(dat_test)
string_test <- dat_test$GeoName

str_view_all(string_test, '[[:upper:]$]{2}')


dat_test %>% 
  mutate(DataValue = str_replace_all(DataValue, ',', ''), 
         TimePeriod = as.numeric(TimePeriod), 
         DataValue = str_replace(DataValue, '\\(NA\\)', '0'),
         DataValue = as.numeric(DataValue),
         DataValue = replace_na(DataValue, 0),
         GeoName = str_replace(GeoName, '\\*', ''),
         state = str_extract(GeoName, '[[:upper:]$]{2}')) %>%
  # separate(col = GeoName
  #          , into = c('county', 'state')
  #          , sep = ','
  #          , extra = 'merge') %>%
  # View()
  select(-GeoFips, -GeoName) %>%
  group_by(state, TimePeriod) %>% 
  mutate(DataValue = sum(DataValue)) %>%
  distinct() %>% 
  View()

# next steps: 
# - make a function to aggregate to state/year
# - add a perameter that can select upto an available year. 
