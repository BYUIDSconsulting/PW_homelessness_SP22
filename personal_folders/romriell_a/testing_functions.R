# testing funcitons

# looking in the spot where the functions live.
# Adam's fxns
source('homelessR/R/bea.r')
# Hunter's fxns
source('homelessR/R/cen.R')
# Becca's fxns
source('homelessR/R/crime_functions.R')
# Justin's fxns
source('homelessR/R/hud.r')

# getting the api key
bea_key <- Sys.getenv('bea_api_key')

# loading in the GET dependency
library(httr)
library(rjson)
library(dplyr)
library(tidyr)
library(stringr)

# og_dat <- tot_employ(bea_key)
View(og_dat)
# getting how long it takes to run the function
# total employment
start <- Sys.time()
dat_test <- tot_employ(bea_key)
duration <- Sys.time() - start
duration

View(dat_test)

# gdp real $
start <- Sys.time()
gdp_dat <- gdp_cur_bea(bea_key)
duration <- Sys.time() - start
duration

# checking the data
View(gdp_dat)
# how long does it take to get all the data from tot_employ
# duration: 4 mins 33 secs
View(dat_test)
string_test <- dat_test$GeoName


## testing Justins Fxns
# testing HUD
start <- Sys.time()
dat_testing_hud <- gather_hud_data()
duration <- Sys.time() - start
duration

View(dat_testing_hud)

char_to_num <- ifelse(is.na(as.numeric(dat_testing_hud$`Overall Homeless`)), 0, dat_testing_hud$`Overall Homeless`) 
View(char_to_num)
## there seems to be a list object in one of the columns
## the following loop will help me to find where the list object is hiding
check_cols <- 3:28
col_names <- colnames(dat_testing_hud[check_cols])
# making a loop that will convert all string columns into numeric columns
char_num_test <- dat_testing_hud


convert_char_to_num_cols <- function(data, column_name) {
  for (i in check_cols) {
  data[,i] <- as.numeric(data[,i])}
  return(data)
}

char_num_fxn_test <- convert_char_to_num_cols(char_num_test, check_cols)


View(char_num_fxn_test)

for(i in col_names) {
  char_num_test[,i] <- ifelse(is.na(as.numeric(dat_testing_hud[,i])), 0, dat_testing_hud[,i]) 
}

View(char_num_test)

# start of loop
for (i in check_cols) {
  try(
    list_dat_test <- as.numeric(dat_testing_hud[i])
  )
}
View(list_dat_test)


### It looks like there is a list object in every column. This seems to be preventing
### the switch from string data types to numeric data types ###

## finding the commas in each column
commas_dat <- dat_testing_hud %>% 
  filter(str_detect(string = dat_testing_hud$`Sheltered TH Homeless`,pattern = ','))

commas_dat <- dat_testing_hud %>% 
  select_if(is.character)

View(commas_dat)

### looping through each column and replacing all ' ' with '0'
### for each column in the data frame. 
for (i in check_cols) {
  try(
    swap_0_dat <- dat_testing_hud %>% 
      mutate(str_replace_all(dat_testing_hud[i],'', '0'))
  )
}
View(swap_0_dat)

## testing Becca's fxns
# testing
start <- Sys.time()
dat_testing_hud <- gather_hud_data()
duration <- Sys.time() - start
duration

## testing Hunter's fxns
# testing  
hunt_api_key <- "b5f34962b7764c50ed301496b757b7c802d2e876"
start <- Sys.time()
homelessR::establish_census_api(hunt_api_key)
dat_testing_hud <- get_census_data()
duration <- Sys.time() - start
duration










str_view_all(string_test, '[[:upper:]$]{2}')


df1 %>% 
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
  select(-GeoFips, -GeoName, -NoteRef) %>%
  group_by(state, TimePeriod) %>% 
  mutate(DataValue = sum(DataValue)) %>%
  distinct() %>% 
  View()



# next steps: 
# - make a function to aggregate to state/year
# - add a perameter that can select upto an available year.