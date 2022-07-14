# library(devtools)
# install_github('BYUIDSconsulting/homelessR')
# library(homelessR)
# 
# # remove.packages("homelessR")

update_homelessR_package <- function() {
  remove.packages("homelessR")
  library(devtools)
  install_github('BYUIDSconsulting/homelessR')
  library(homelessR)
}

update_homelessR_package()

# looking in the spot where the functions live.
# Adam's fxns
source('homelessR/R/bea2.r')
# Hunter's fxns
source('homelessR/R/cen.R')
# Becca's fxns
source('homelessR/R/crime_functions.R')
# Justin's fxns
source('homelessR/R/hud.r')

bea_key2 <- Sys.getenv('bea_api_key')

## testing Adam's fxns
# testing total employment 
start <- Sys.time()
dat_testing <- tot_employ_bea(bea_key2)
duration <- Sys.time() - start
duration

View(dat_testing)

# testing gdp
start <- Sys.time()
dat_testing <- gdp_cur_bea(bea_key2)
duration <- Sys.time() - start
duration

View(dat_testing)

## testing Justins Fxns
# testing HUD
### WORKS ###
start <- Sys.time()
dat_testing_hud <- gather_hud_data()
duration <- Sys.time() - start
duration

View(dat_testing_hud)

## testing Becca's fxns
# testing
### WORKS ###
start <- Sys.time()
dat_testing_crime <- get_url()
duration <- Sys.time() - start
duration

View(dat_testing_crime)

## testing Hunter's fxns
# testing  
### WORKS ###
hunt_api_key <- "b5f34962b7764c50ed301496b757b7c802d2e876"
start <- Sys.time()
# establish_census_api(hunt_api_key)
dat_testing_hud <- get_census_data()
duration <- Sys.time() - start
duration

View(dat_testing_hud)


source('homelessR/R/unemployment.r')
# testing the unemployment fxn
### WORKS ###
start <- Sys.time()
unemply_dat_test <- unemployment()
duration <- Sys.time()-start
duration

View(unemply_dat_test)



