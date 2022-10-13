library(dplyr)
library(tidyverse)

# 1
data <- read_csv('turbo_az.csv')
new_turbo_data <- data %>% 
  rename(Barter = barter_mumkundurmu, Valyuta = sign)
 
# 2
max((new_turbo_data %>% filter(Marka %in% 'Lexus')) %>%
  select(Qiymet))

# 3
max_price <- max(new_turbo_data %>% select(Qiymet))
(new_turbo_data %>% filter(Qiymet %in% c(max_price))) %>% select(Marka, Model)

# 4
table((new_turbo_data %>% filter(Marka %in% 'BMW'))$Reng)

# 5
count(new_turbo_data %>% filter(Marka %in% 'Porsche', Reng %in% 'Qara', Yeni %in% 'Bəli'))

# 6
max((new_turbo_data %>% filter(Marka %in% 'Mercedes', Valyuta %in% 'AZN', Oturucu %in% 'Tam')) %>%
  select(Qiymet))

# 7
count(new_turbo_data %>% filter(Marka %in% 'Mercedes', Model %in% 'E 220', Yeni %in% 'Bəli'))

# 8
unique(new_turbo_data$Reng)

# 9
mean((new_turbo_data %>% filter(Marka %in% 'Opel', Reng %in% 'Qara'))$Qiymet)

# 10
count(new_turbo_data %>% filter(Marka %in% 'Nissan', Ban_novu %in% 'Offroader / SUV'))
