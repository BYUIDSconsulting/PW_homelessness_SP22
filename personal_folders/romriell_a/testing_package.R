library(devtools)
install_github('BYUIDSconsulting/homelessR')
library(homelessR)


bea_key2 <- Sys.getenv('bea_api_key')
dat_testing <- tot_employ_bea(bea_key2)
