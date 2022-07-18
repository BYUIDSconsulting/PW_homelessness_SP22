# library(devtools)
# install_github('BYUIDSconsulting/homelessR')
# library(homelessR)
# 
# # remove.packages("homelessR")

# remove.packages(c('rlang', 'sf'))
# install.packages(c('rlang','sf'))

update_homelessR_package <- function() {
  remove.packages("homelessR")
  library(devtools)
  install_github('BYUIDSconsulting/homelessR')
  library(homelessR)
}

update_homelessR_package()

dat_test <- hud_data
dat_test2 <- crime_data


# looking in the spot where the functions live.

# Hunter's fxns
source('homelessR/R/cen.R')


# Adam's fxns
setwd("~/School/Consulting/PW_homelessness_SP22/personal_folders/romriell_a")
source('../../homelessR/R/bea2.r')
bea_key2 <- Sys.getenv('BEA_API_KEY')
bea_key2
## testing Adam's fxns
# testing total employment
### WORKS ###
start <- Sys.time()
# dat_testing <- 
tot_employ_bea(bea_key2)
duration <- Sys.time() - start
duration

View(dat_testing)

### further tests on tot_employ_bea ###
#### solved: bea_api_key was missing. replaced api key. 
#### add a fxn that saves the api key in .Renviron file ####

dataset_name_t <- "Regional"
dataset_t <- "CAEMP25N"
line_code_t <- '10'

test_url <- make_get_url(dataset_name = dataset_name_t, dataset = dataset_t, line_code = line_code_t, api_key = bea_key2)
test_req <- call_to_list(test_url)
View(test_req)

# testing gdp
### WORKS ###
start <- Sys.time()
dat_testing <- gdp_cur_bea(bea_key2)
duration <- Sys.time() - start
duration

View(dat_testing)

## testing Justins Fxns
# Justin's fxns
setwd("~/School/Consulting/PW_homelessness_SP22")
source('homelessR/R/hud.r')
# testing HUD
### WORKS ###
start <- Sys.time()
dat_testing_hud <- gather_hud_data()
duration <- Sys.time() - start
duration

View(dat_testing_hud)

## testing Becca's fxns
# Becca's fxns
setwd("~/School/Consulting/PW_homelessness_SP22")
source('homelessR/R/crime_functions.R')

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



