library(tidyverse)
require(gridExtra)
library(ggplot2)
data <- read_csv('Superstore_data.csv')
data <- data %>% rename_all(~str_replace_all(., "\\s+", "_"))

ggplot(data, aes(Sales, Profit)) + geom_point() + geom_smooth()

unique(data$Segment) %>% view()

cons_d <- sum((data %>% filter(Segment %in%  'Consumer')) %>% select(Discount))
corp_d <- sum((data %>% filter(Segment %in%  'Corporate')) %>% select(Discount))
home_d <- sum((data %>% filter(Segment %in%  'Home Office')) %>% select(Discount))

x <- c(cons_d, corp_d, home_d)
labels <- c('Consumer', 'Corporate', 'Home Office')
piepercent<- round(100*x/sum(x), 1)

pie(x, piepercent, col = rainbow(length(x)))
legend("topright", labels, cex = 0.8,
       fill = rainbow(length(x)))

plot1 <- ggplot(data, aes(Region, Sales)) + geom_bar(stat="identity") + facet_grid(~ Segment) 
plot2 <- ggplot(data, aes(Region, Profit)) + geom_bar(stat="identity") + facet_grid(~ Segment)
grid.arrange(plot1, plot2, ncol=2)

hist(data$Sales, breaks=c(0, seq(200, 25000, 200)), xlim=c(0, 2000))

boxplot(Sales ~ Profit, data = data)
ggplot(data, aes(Region, Sales)) + geom_bar(stat="identity")

second_c <- count((data %>% filter(Ship_Mode %in%  'Second Class')) %>% select(Discount))
first_c <- count((data %>% filter(Ship_Mode %in%  'First Class')) %>% select(Discount))
same_d <- count((data %>% filter(Ship_Mode %in%  'Same Day')) %>% select(Discount))
standart_c <- count((data %>% filter(Ship_Mode %in%  'Standard Class')) %>% select(Discount))

labels <- c('Second Class', 'First Class', 'Same Day', 'Standard Class')
nums <- as.numeric(c(second_c, first_c, same_d, standart_c))
 
barplot(nums)

ggplot(data, aes(Sales, Profit)) + geom_violin(trim=FALSE) + labs(title="Shipping by product category")
