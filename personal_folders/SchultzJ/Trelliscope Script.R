library(devtools)
install_github('BYUIDSconsulting/homelessR')
library(homelessR)
library(tidyverse)
library(plotly)
library(trelliscopejs)

######################################################################
# Gather the Data
hud <- homelessR::gather_hud_data()
cen <- homelessR::get_census_data(start_year = 2007, end_year = 2019)
emp <- homelessR::unemployment()

######################################################################

######################################################################
# Clean the data
my_data <- merge(hud, cen, by = c("state", "Year"))
my_data <- merge(my_data, emp,  by= c("state", "Year"))

my_data <-  my_data %>% mutate(percent_homeless = 
                                 (my_data$`Overall Homeless`/
                                    my_data$`Estimate!!Total`)*100)

######################################################################

######################################################################
# Percent_homeless
percent_homeless <- function(d){
  fig <- plot_ly(d, x = ~Year,
                 y = ~percent_homeless, 
                 text = ~paste('Year', Year), 
                 mode = 'lines') %>% 
    layout(xaxis = list(title = list(text ='Year')),
           yaxis = list(title = list(text = 'Percent Homeless')))
}

states <- my_data %>% 
  group_by(state) %>% 
  nest() %>% 
  mutate(panel = map_plot(data, percent_homeless)) %>% 
  ungroup()

states %>%
  trelliscope(name='Percent Homeless over the years', nrow = 2, ncol = 3,
              path = '../../trelliscope/percent_homeless')

######################################################################

######################################################################
# Population_homeless
population_homeless <- function(d){
  fig <- plot_ly(d, x = ~`Estimate!!Total`,
                 y = ~`Overall Homeless`, 
                 text = ~paste('Year', Year)) %>% 
    layout(xaxis = list(title = list(text ='Population')),
           yaxis = list(title = list(text = 'Homelessness')))
}

states <- my_data %>% 
  group_by(state) %>% 
  nest() %>% 
  mutate(panel = map_plot(data, population_homeless)) %>% 
  ungroup()

states %>%
  trelliscope(name='Population homelessness', nrow = 2, ncol = 3,
              path = '../../trelliscope/population_homeless')

######################################################################

######################################################################
# Unemployment homelessness
homeless_unemp <- function(d){
  fig <- plot_ly(d, y = ~`Overall Homeless`,
                 x = ~`Unemployment`, 
                 text = ~paste('Year', Year)) %>% 
    layout(yaxis = list(title = list(text ='Homelessness')),
           xaxis = list(title = list(text = 'Unemployment')))
}


states <- my_data %>% 
  group_by(state) %>% 
  nest() %>% 
  mutate(panel = map_plot(data, homeless_unemp)) %>% 
  ungroup()


states %>%
  trelliscope(name='Unemployment and homelessness', nrow = 2, ncol = 3,
             path = '../../trelliscope/unemployment_homeless')
######################################################################

######################################################################
# Unemployment homelessness
homeless_unemp_percent <- function(d){
  fig <- plot_ly(d, y = ~percent_homeless,
                 x = ~`Unemployment`, 
                 text = ~paste('Year', Year)) %>% 
    layout(yaxis = list(title = list(text ='Percent Homeless')),
           xaxis = list(title = list(text = 'Unemployment')))
}


states <- my_data %>% 
  group_by(state) %>% 
  nest() %>% 
  mutate(panel = map_plot(data, homeless_unemp_percent)) %>% 
  ungroup()


states %>%
  trelliscope(name='Unemployment and homelessness', nrow = 2, ncol = 3,
              path = '../../trelliscope/unemployment_homeless_percent')
