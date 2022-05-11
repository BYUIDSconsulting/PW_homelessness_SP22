# practicing making a trelliscope? 
# still not entirely sure what a trelliscope is

# reading in libraries
library(tidyverse)
library(trelliscopejs)
library(gapminder)

# loading in gapminder data
dat <- gapminder

point_plot <- function(dat) {
  ggplot(dat) +
    geom_point(aes(x = year, y = lifeExp)) +
    ylim(0,84) +
    theme_bw()
}
# working with the facet_trelliscope
qplot(year, lifeExp, data = dat) +
  xlim(1948,2011) + 
  ylim(10,95) +
  theme_bw() +
  facet_trelliscope(~ country + continent, nrow = 2, ncol = 7, width =300)

# working with just the trelliscope function
# View(dat)

gapminder %>% 
  ggplot(aes(x = year, y = lifeExp)) +
  geom_point() +
  geom_line()
# making a plot function
yr_by_lifExp<- function(x) {
  return(gapminder %>% 
           ggplot(aes(x = year, y = lifeExp)) +
           geom_point() +
           geom_line()
  )
}

# grouping the dataset by continent
by_continent <- dat %>% 
  group_by(continent, country) %>% 
  nest() %>% 
  # making a cognostic for the trelliscope
  mutate(mean_gdp_Per_year = map_dbl(data, function(x) (mean(x$gdpPercap*x$pop))),
         mean_pop = map_dbl(data, function(x) (mean(x$pop))),
         panel = map_plot(data, yr_by_lifExp))
View(by_continent)

by_continent2 <- as_cognostics(
  x = by_continent
  , cond_cols = c('mean_gdp_Per_year', 'mean_pop', 'panel')
)

trelliscope(by_continent, 
            name = 'Basic Gapminder Trelliscope')
