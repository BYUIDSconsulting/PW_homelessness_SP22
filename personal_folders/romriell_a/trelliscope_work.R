# loading in packages
library(homelessR)
library(tidyverse)
library(plotly)
library(trelliscopejs)
library(zoo)

# rolling average fxn
fnrollmean <- function (x) {
  if (length(x) < 7) {
    rep(NA,length(x)) 
  } else {
    rollmean(x,7,align="center",na.pad=TRUE)
  }
}

### Analyzing number of homeless and GDP
# calling the data sources
dat_gdp <- gdp_data
dat_hub <- hud_data

dat_test <- total_employment_data
View(dat_test)

dat_gdp$gdp_per_state_per_year

## calcualting year over year change
# gdp
dat_gdp1 <- dat_gdp %>%
  group_by(state) %>% 
  nest() %>% 
  mutate(gdp_change = )

# mutate(gdp_lag = lag(gdp_per_state_per_year), 
#          gdp_lag2 = lag(gdp_per_state_per_year, 2))

# lag(dat_gdp$gdp_per_state_per_year)

View(dat_gdp1)

# joining data
dat <- dat_hub %>% 
  left_join(y = dat_gdp)
View(dat)


# looking at spendingd data
dat_spend <- spending_data
View(dat_spend)
