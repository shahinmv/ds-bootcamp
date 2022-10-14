library(tidyverse)

airlines <- read_csv('airlines.csv')
airports <- read_csv('airports.csv')
flights <- read_csv('flights.csv')

colnames(flights)[colnames(flights) == "flights_ID"] ="ID"

joined <- list(airlines, airports, flights) %>% reduce(left_join, by='ID')

unique(joined$AIR_TIME) %>% view()

joined[order(joined$DEPARTURE_TIME, -joined$DEPARTURE_DELAY), ] %>% view()
