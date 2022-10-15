library(tidyverse)
library(stringr)
library(ggplot2)

airlines <- read_csv('airlines.csv')
airports <- read_csv('airports.csv')
flights <- read_csv('flights.csv')

colnames(flights)[colnames(flights) == "flights_ID"] ="ID"

joined <- list(airlines, airports, flights) %>% reduce(left_join, by='ID')

unique(joined$AIR_TIME) %>% view()

joined[order(joined$DEPARTURE_TIME, -joined$DEPARTURE_DELAY), ] %>% view()

joined$combined <- str_c(joined$ARRIVAL_TIME, '<->', joined$ARRIVAL_DELAY)

hist(joined$FLIGHT_NUMBER)
barcolors <- rainbow(14)  
barplot(joined$FLIGHT_NUMBER, col = barcolors, names.arg=joined$AIRLINE.x)

plot(joined$SCHEDULED_DEPARTURE, joined$DEPARTURE_TIME, main="Scheduled department vs Departure time", xlab="Scheduled Departure", ylab="Departure time")

ggplot(joined, aes(x = ARRIVAL_DELAY, y = AIRLINE.x)) + geom_point() + geom_miss_point()
