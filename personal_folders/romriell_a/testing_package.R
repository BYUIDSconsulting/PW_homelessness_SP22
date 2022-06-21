library(devtools)
install_github('BYUIDSconsulting/homelessR')
library(homelessR)

# remove.packages("homelessR")


bea_key2 <- Sys.getenv('bea_api_key')

start <- Sys.time()
dat_testing <- tot_employ_bea(bea_key2)
duration <- Sys.time() - start
duration