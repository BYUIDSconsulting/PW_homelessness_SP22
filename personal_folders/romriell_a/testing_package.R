library(devtools)
install_github('BYUIDSconsulting/homelessR')
library(homelessR)

# remove.packages("homelessR")


bea_key2 <- Sys.getenv('bea_api_key')

## testing Adam's fxns
# testing total employment 
start <- Sys.time()
dat_testing <- tot_employ_bea(bea_key2)
duration <- Sys.time() - start
duration



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
start <- Sys.time()
dat_testing_hud <- gather_hud_data()
duration <- Sys.time() - start
duration
