# testing stuff
# foo <- function() {
# n1<-readline(prompt="Enter skip 1: " )
# n2<-readline(prompt="Enter skip 2: " )
# n1<-as.integer(n1)
# n2<-as.integer(n2)
# c(n1,n2)
# }
# foo()

library(bea.R)

get_call_to_list <- function(call_url){
  results <- GET(call_url)
  return(fromJSON(as.character(results)))
}

base_get_data_url <- function(dataset_name = '', dataset = '', line_code = '', api_key='') {
  base_url <- paste0('https://apps.bea.gov/api/data?&UserID=', api_key, '&method=')
  method_type <- "getdata"
  name_of_dataset <- '&datasetname='
  year_code <- '&year=all'
  geofips_code <- '&geofips=county'
  result_form <- '&ResultFormat=JSON'
  table_name <- "&tablename="
  line_code_section <- "&linecode="
  
  base_get_data <- paste0(base_url
                          , method_type
                          , name_of_dataset
                          , dataset_name
                          , year_code
                          , geofips_code
                          , result_form
                          , table_name
                          , dataset
                          , line_code_section
                          , line_code)
  return(base_get_data)
}

total_employment_per_county_per_year <- function(api_key ='') {
  
  dataset_name <- "Regional"
  dataset <- "CAEMP25N"
  line_code <- '10'
  
  url <- base_get_data_url(dataset_name
                          , dataset
                          , line_code
                          , api_key)
  
  req <- get_call_to_list(url)
  print('API call made.')
  print("")
  mid <- Sys.time()-old
  print(mid)
  dat <- as.data.frame(dat_1st$BEAAPI$Results$Data[1])
  for (j in 2:length(dat_1st$BEAAPI$Results$Data)) {
    # Append the API result to the data frame
    r <- as.data.frame(dat_1st$BEAAPI$Results$Data[j])
    dat <- bind_rows(dat,r)
  }
  return(dat)
}



### using bea.R to pull in data ###
# getting the api key
# total employment dataset: CAEMP25N
# line_item: 10
bea_key <- Sys.getenv('bea_api_key')
getSpec <- list('UserID' = bea_key
                , 'Method' = 'GetData'
                , 'datasetname' = 'CAEMP25N'
                , 'TableID' = '10'
                , 'Year' = 'X')
getSpec_test <- list('UserID' = bea_key
                     , 'Method' = 'GetData'
                     , 'datasetname' = 'NIPA'
                     , 'Frequency' = 'A'
                     , 'TableID' = '68'
                     , 'Year' = 'X')

# making the api call
dat_test <- beaGet(beaSpec = getSpec_test, asTable = TRUE)
dat_viz_test <- beaViz(dat_test)

View(dat_test)
