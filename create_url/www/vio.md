library(trelliscopejs)
library(tidyverse)
library(dplyr)
library(readr)
crime <- read.csv('/Users/Becca/Documents/Data Consulting/county_data.csv', sep = ',', header = TRUE)

cri <- crime %>%
  group_by(state, year) %>%
  summarize(sum(violent_crime), sum(murder_and_nonnegligent_manslaughter), sum(rape), sum(robbery), sum(aggravated_assault), sum(property_crime), sum(burglary), sum(larceny_theft), sum(motor_vehicle_theft), sum(arson))  

Violent_Crime_over_the_Years_by_State <- ggplot(data = cri, aes(x = year, y = `sum(violent_crime)`, color = state)) +
  geom_line() +
  geom_point() +
  theme(legend.position = 'none') +
  ylab('Sum of Violent Crime') +
  ggtitle('Violent Crime over the Years') +
  facet_trelliscope(~state, nrow = 2, ncol = 2, name = 'Violent Crime over the Years by State', path = '/Users/Becca/Documents/Data Consulting/homelessR/create_url/www')
  
Violent_Crime_over_the_Years_by_State
