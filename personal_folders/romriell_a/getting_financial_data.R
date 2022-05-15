# loading getting bea R package
# install.packages('bea.R')
# library(bea.R)
# library(readr)
library(dplyr)
# library(pander)
library(httr)
library(jsonlite)
library(rjson)
library(RCurl)
library(reshape2)
library(lubridate)

bea_key <- Sys.getenv('bea_api_key')
# trying to just make just a straight api call

# base url for bea
base_url <- paste0('https://apps.bea.gov/api/data?&UserID=', bea_key, '&method=')
name_of_dataset <- '&datasetname='
result_form <- '&ResultFormat=JSON'

get_call_to_list <- function(call_url){
  results <- GET(call_url)
  return(fromJSON(as.character(results)))
}

# method definition
method <- 'GetDatasetList'

# url for api call
bea_url_call <- paste0(base_url,method,'&ResultFormat=JSON')
bea_url_call
# should be in a json format

# getting the name of the dataset
list_of_data <- GET(bea_url_call)
# View(list_of_data)
results_list_of_data <- fromJSON(as.character(list_of_data))
View(results_list_of_data)
dataset_name <- results_list_of_data$BEAAPI$Results$Dataset[[10]][1]

# getting the parameters for the Regional dataset
param_method <- 'getparameterlist'
bea_param_call <- paste0(base_url
                         , param_method
                         , name_of_dataset
                         , dataset_name
                         , result_form)
list_of_params <- GET(bea_param_call)
results_params <- fromJSON(as.character(list_of_params))
View(results_params$BEAAPI$Results$Parameter)

# getting all the available datasets
param_values <- 'Getparametervalues'
bea_param_values_call <- paste0(base_url
                                ,param_values
                                ,name_of_dataset
                                ,dataset_name
                                ,'&parametername=tablename'
                                ,result_form)
list_of_value_params <- GET(bea_param_values_call)
results_pv_call <- fromJSON(as.character(list_of_value_params))

View(results_pv_call)

desired_data <- c(1,3,7,8,11,13,15)

list_of_datasets <- list()


for (i in desired_data) {
  list_of_datasets <- append(list_of_datasets,results_pv_call$BEAAPI$Results$ParamValue[[i]]$Key)
}

list_of_datasets

first_dataset <- list_of_datasets[1]

# finding out the line codes that I need
method_filtered_params <- 'getparametervaluesfiltered'

filtered_params_call <- paste0(base_url
                               , method_filtered_params
                               , '&datasetname='
                               , dataset_name
                               , '&targetparameter=linecode'
                               , '&tablename='
                               , first_dataset
                               , result_form)

filtered_params_res <- get_call_to_list(filtered_params_call)
# View(filtered_params_res)
line_code_res <- filtered_params_res$BEAAPI$Results$ParamValue
line_code_res
# the line code is needed to pull out the dataset that I want
line_code <- line_code_res[1][[1]][1]

# for (i in line_code_res) {
#   as.data.frame(filtered_params_res$BEAAPI$Results$ParamValue[[i]])
# }
# 
# get_line_codes <- function(lst_of_datasets) {
#   for (i in lst_of_datasets) {
#   filt_param_res <- get_call_to_list(filtered_params_call <- paste0(base_url
#                                                                     , method_filtered_params
#                                                                     , '&datasetname='
#                                                                     , dataset_name
#                                                                     , '&targetparameter=linecode'
#                                                                     , '&tablename='
#                                                                     , lst_of_datasets[i]
#                                                                     , result_form))
#   return(filt_param_res$BEAAPI$Results$ParamValue)
#   }
# }
# 
# get_line_codes(list_of_datasets)



 # The following are to be used later for Year and GEOfips
year_code <- '&year=all'
geofips_code <- '&geofips=county'

# making my getdata call

# get_dat_call <- function(tableName='', lineCode='') {
#   year_code <- '&year=all'
#   geofips_code <- '&geofips=state'
#   base_get_data <- paste0(base_url
#                           , 'getdata'
#                           , name_of_dataset
#                           , dataset_name
#                           , year_code
#                           , geofips_code
#                           , result_form
#                           , '&tablename='
#                           , first_dataset #tableName
#                           , '&linecode='
#                           , line_code #lineCode
#                           ) 
#   dat <- get_call_to_list(base_get_data)
#   
#   for (j in 1:length(dat$BEAAPI$Results$Data)) {
#     # Append the API result to the data frame
#     r <- as.data.frame(dat$BEAAPI$Results$Data[j])
#     df <- bind_rows(dat,r)
#   }
#   return(df)
# }

base_get_data <- paste0(base_url
                        , 'getdata'
                        , name_of_dataset
                        , dataset_name
                        , year_code
                        , geofips_code
                        , result_form
                        , '&tablename='
                        , first_dataset #tableName
                        , '&linecode='
                        , line_code #lineCode
)

# test_dat <- get_dat_call(first_dataset, lineCode = line_code)
# View(test_dat)
# first_dataset_req <- paste0(base_get_data
#                             , '&tablename='
#                             , first_dataset
#                             , year_code
#                             , geofips_code
#                             , result_form
#                             , '&linecode='
#                             , line_code)


dat_1st <- get_call_to_list(base_get_data)
View(dat_1st)


df1 <- as.data.frame(dat_1st$BEAAPI$Results$Data[1])
# Loop through the MSA’s to request the MSA GDP
  # Since there are multiple years in the response we need to loop through them
for (j in 2:length(dat_1st$BEAAPI$Results$Data)) {
  # Append the API result to the data frame
  start_time <- Sys.time()
  r <- as.data.frame(dat_1st$BEAAPI$Results$Data[j])
  df1 <- bind_rows(df1,r)
}
end_time <- Sys.time()
start_time <- hms(start_time)
end_time <- hms(end_time)

View(df1)
write.csv(df1, '../../data/collected_data/number_of_jobs_by_county_by_year.csv')





# trying to get the regular api call working
# I have not had much luck yet but building 
# the url shouldn't be too terrible. 
# scrapping the r package route

dats <- beaSets(bea_key)
View(dats)

dat_options <- as_tibble(data.frame((dats[['Dataset']][['DatasetName']]),(dats[['Dataset']][['DatasetDescription']])))

View(dat_options)

# This prints the list of parameters needed for the Regional table
beaParams(bea_key, 'Regional') %>% 
  pander()
# REQUIRED: for GeoFips: COUNTY
# REQUIRED: for LineCode: ?
# REQUIRED: for TableName: ?
# for Year: ALL


as_tibble(data.table(params_reg))
# beaGet requires a list of options to pull data
userSpecList <- list('UserID' = Sys.getenv('bea_api_key') ,
                     'Method' = 'GetData',
                     'datasetname' = dat_options[10,1]) # this is accessing the regional data section of the api
dat <- beaGet(userSpecList)
View(dat)

# using this tutorial
# https://jwrchoi.com/post/how-to-use-bureau-of-economic-analysis-bea-api-in-r/

results <- beaSearch('gross domestic product', beaKey = bea_key)
View(results)
apicalls <- results$apiCall[1]
View(apicalls$value)


# making calls from the bea.R tutorial
first_call <- list('UserID' = bea_key, 
                   "Method" = "GetData", # Method
                   "datasetname" = "Regional", # Specify dataset
                   "TableName" = "CAEMP25N", # Specify table within the dataset
                   "LineCode" = 10, # Specify the line code
                   "GeoFips" = "COUNTY", # Specify the geographical level
                   "Year" = 2018 # Specify the year
                   )
second_call <- list('UserID' = bea_key, 
                    "Method" = "GetData", # Method
                    "datasetname" = "Regional", # Specify dataset
                    "TableName" = "CAEMP25N", # Specify table within the dataset
                    "LineCode" = 40, # Specify the line code
                    "GeoFips" = "COUNTY", # Specify the geographical level
                    "Year" = 2018 # Specify the year
                    )


call_results <- beaGet(second_call)
View(call_results)
