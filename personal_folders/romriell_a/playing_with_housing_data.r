# loading in libraries
library(tidyverse)
library(fredr)
# reading in the data
# getwd()
dat <- read_csv('data/collected_data/housing_data.csv')
View(dat)

# try looking at this website and it's api
# https://fredaccount.stlouisfed.org/login/secure/

# looking at the data that FRED has available
fred_key <- Sys.getenv('fred_api_key')

# adding my api key
fredr_set_key(fred_key)

fredr()