# testing funcitons

# looking in the spot where the functions live.
source('homelessR/R/bea.r')

# getting the api key
bea_key <- Sys.getenv('bea_api_key')

# loading in the GET dependency
library(httr)
library(rjson)
library(dplyr)
# getting how long it takes to run the function
start <- Sys.time()
dat_test <- tot_employ(bea_key)
duration <- Sys.time() - start
duration
# how long does it take to get all the data from tot_employ
# duration: 