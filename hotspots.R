##Load necessary libraries

library(rhdx)
library(sf)
library(tidyverse)
library(unhcrthemes)
library(racled)



## Load the coordinates of Kenyan Boundaries from hdx

ken_admn2 <- pull_dataset("cod-ab-ken") %>% 
  get_resource(2) %>% 
  read_resource(layer = "ken_admbndl_admALL_iebc_itos_20191031")

## Plot the coordinates using ggpplot 

ggplot(ken_admn2) + geom_sf() + theme_unhcr(void = FALSE)

## Find the areas of the country that experienced chaos in 2023.
  # This is associated with the chaos and demonstrations related with the political 
  # inclinations to election results and the risen cost of living

ken <- read_acled("kenya")  
ken_sf <- ken %>% filter(year == 2023) %>%
  set_as_sf(coords = c("longitude", "lattitude"), crs = 4326)
glimpse(ken_sf)

##Visualize these areas in the map by fatalities

ggplot(ken_admn2) + 
  geom_sf() + 
  geom_sf(data = ken_sf, aes(size = fatalities))
  theme_unhcr(void = FALSE)
