# loading in packages
library(homelessR)
library(tidyverse)
library(plotly)
library(trelliscopejs)


### Analyzing number of homeless and GDP
# calling the data sources
dat_gdp <- gdp_data
dat_hub <- hud_data

## calcualting year over year change
# gdp
dat_gdp1 <- dat_gdp %>% 
  group_by(Year, state) %>% 
  transform(
    gdp_change = 100*((dat_gdp$gdp_per_state_per_year-dat_gdp$gdp_per_state_per_year[-1])/dat_gdp$gdp_per_state_per_year[-1])
  )
  
  

View(dat_gdp1)

# joining data
dat <- dat_hub %>% 
  left_join(y = dat_gdp)
View(dat)
