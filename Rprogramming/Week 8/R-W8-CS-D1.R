library(tidyverse)
library("dplyr")

data <- read_csv("bina_az.csv")

newdata <- data %>% select(c('...1'))
data <- data %>% select(-c('...1'))

data <- data %>% select(ID, everything())

data %>% select(contains("Adres")) %>% view()

data$newcol <- data$sahe / as.numeric(data$otaq)

max((data %>% filter(nov %in%  'Köhnə tikili')) %>% select(qiymet))

unique(data$Adres_1) %>% view((data %>% filter(nov %in%  'Köhnə tikili')) %>% select(qiymet)))

table((data %>% filter(qiymet > 500000)) %>% select(otaq))

lapply((data %>% filter(kupca %in% 'var', sahe > 200)) %>% select(qiymet), mean, na.rm = TRUE)

range((data %>% filter(as.numeric(otaq) == 4)) %>% select(qiymet), na.rm = TRUE)
    
count((data %>% filter(nov %in% 'Yeni tikili', sahe > 100)) %>% select(elani_yerlesdiren))
