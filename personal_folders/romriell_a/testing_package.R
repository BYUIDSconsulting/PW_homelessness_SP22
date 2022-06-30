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


bea_key2 <- Sys.getenv('bea_api_key')

## testing Adam's fxns
# testing total employment 
start <- Sys.time()
dat_testing <- tot_employ_bea(bea_key2)
duration <- Sys.time() - start
duration

View(dat_testing)


## testing Justins Fxns
# testing HUD
start <- Sys.time()
dat_testing_hud <- gather_hud_data()
duration <- Sys.time() - start
duration

View(dat_testing_hud)

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
