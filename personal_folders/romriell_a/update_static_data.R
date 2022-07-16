# testing out the homelessR package


#Hud Data
### WORKS ###
# hud_data <- homelessR::gather_hud_data()
# usethis::use_data(hud_data, overwrite = TRUE)

dat <- hud_data
# View(hud_data)

# Crime Data
### WORKS ###
crime_data <- homelessR::get_url()
usethis::use_data(crime_data, overwrite = TRUE)

dat2 <- crime_data
# View(dat2)

# bea data
### WORKS ###
key <- '4DB319CF-30C9-4D2D-A8AB-B0D50DC66897'
start <- Sys.time()
total_employment_data <- homelessR::tot_employ_bea(api_key = key)
usethis::use_data(total_employment_data, overwrite = TRUE)
duration <- Sys.time()-start
duration

dat3 <- total_employment_data
View(dat3)

gdp_data <- homelessR::gdp_cur_bea(api_key = key)
usethis::use_data(gdp_data, overwrite = TRUE)
duration <- Sys.time()-start
duration

dat4 <- gdp_data
View(dat4)

# Census data
census_data <- homelessR::get_census_data()
usethis::use_data(census_data, overwrite = TRUE)

dat5 <- census_data
View(dat5)

spending_data <- read.csv('../data/fsr_input.tsv', sep = '\t')
usethis::use_data(spending_data, overwrite = TRUE)


unemploy_rate_data <- homelessR::unemployment()
usethis::use_data(unemploy_rate_data, overwrite = TRUE)
