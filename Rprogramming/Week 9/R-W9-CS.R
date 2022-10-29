library(tidyverse)
library(readxl)
library("stringr")

raw <- read_xlsx("MO14-Round-1-Dealing-With-Data-Workbook.xlsx", na = "", sheet = 2,
                 col_names = F)
names(raw) <- 'col'

copy <- raw

for (i in 1:nrow(raw)){
  copy$night_day[i] <- ifelse(str_detect(raw$col[i], "PM"), "PM", "AM")
}

copy$col <- gsub('AM|PM|kwh|_', ' ', copy$col)
copy$col<- trimws(copy$col)

copy <- copy %>% mutate(weekday = case_when(grepl('Monday|Mon', col)~'Monday',
                                    grepl('Tuesday|Tue', col)~'Tuesday',
                                    grepl('Wednesday|Wed', col)~'Wednesday',
                                    grepl('Thursday|Thu', col)~'Thursday',
                                    grepl('Friday|Fri', col)~'Friday',
                                    grepl('Saturday|Sat', col)~'Saturday',
                                    grepl('Sunday|Sun', col)~'Sunday',))

copy$col <- gsub('rd|nd|st|th|Monday|Mon|Tuesday|Tue|Wednesday|Wed|Thursday|Thu|Friday|Fri|Saturday|Sat|Sunday|Sun', '', copy$col)
copy$col <- gsub('  ', ' ', copy$col)

copy <- separate(copy, col, c('Hour', 'Date', 'Usage'), sep=' ')

copy$Hour <- as.integer(copy$Hour)
copy$Date <- copy$Date %>% as.Date('%d-%b-%Y')
copy$Usage <- as.numeric(copy$Usage)
