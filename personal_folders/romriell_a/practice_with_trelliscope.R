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




