library(devtools)
install_github('BYUIDSconsulting/homelessR')
library(homelessR)
library(tidyverse)
library(plotly)
library(trelliscopejs)


hud <- homelessR::gather_hud_data()
cen <- homelessR::get_census_data(start_year = 2007, end_year = 2019)
emp <- homelessR::unemployment()

my_data <- merge(hud, cen, by = c("state", "Year"))
my_data <- merge(my_data, emp,  by= c("state", "Year"))

data <- filter(my_data, state == 'California')

homeless_unemp <- function(d){
  fig <- plot_ly(d, x = ~`Estimate!!Total`,
                 y = ~`Overall Homeless`, 
                 text = ~paste('Year', Year)) %>% 
    layout(xaxis = list(title = list(text ='Population')),
           yaxis = list(title = list(text = 'Homelessness')))
}
my_data <-  my_data %>% mutate(percent_homeless = 
                                 (my_data$`Overall Homeless`/
                                    my_data$`Estimate!!Total`)*100)

states <- my_data %>% 
  group_by(state) %>% 
  nest()

states <- mutate(states, panel = map_plot(data, homeless_unemp)) %>% 
  ungroup()


states %>%
  trelliscope(name='Population vs Overall Homelessness', nrow = 2, ncol = 3,
             path = '../../trelliscope/population_homeless')
