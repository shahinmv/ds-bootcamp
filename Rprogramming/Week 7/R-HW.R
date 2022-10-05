# 1
39 -> x
22 -> y

(z <- x-y)

# 2
vec1<-c(2, 5, 8, 12, 16) 
vec2<-5:9

vec1-vec2

# 3
(number<-seq(from=2, length.out=100, by=3))

number[c(5,10,15,20)]
number[10:30]

#4
revenue <- c(14574.49, 7606.46, 12611.41, 13175.41, 8758.65, 8105.44, 11496.28,
             9766.09, 10305.32, 17379.96, 10713.97, 15433.50)
expense <- c(12051.82, 5695.07, 12319.20, 12089.72, 8658.57, 840.20, 3285.73, 5821.12,
             6976.93, 16618.61, 10054.37, 3803.96)
(profit<-revenue-expense)

(tax<-round(profit*0.3, 2))

profit_after_tax <- profit - tax
mean_profit<-mean(profit_after_tax)

for(i in 1:length(profit_after_tax)) {   
  if(profit_after_tax[i]>mean_profit){
    print(month.abb[i])
  }         
}

# 5
x <- c(4,6,5,7,10,9,4,15)
x < 7

# 6
(p <- c (seq(1,9)))
(q <- c (11:19))

(my_data <- data.frame(p, q))

# 7
fname <- "James"
lname <- "Bond"

paste(fname, lname)

# 8
student.df = data.frame( name = c("Sue", "Eva", "Henry", "Jan"),
                         sex = c("f", "f", "m", "m"),
                         years = c(21,31,29,19)); 
for (i in 1:nrow(student.df)){
  student.df$male.teen[i] <- ifelse(student.df$sex[i]=="m" & student.df$years[i] < 20, T, F)
}
student.df

# 9 
df <- data.frame(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10))

for (i in 1:nrow(df)){
  df$comparison[i] <- ifelse(sum(df$a[i], df$b[i]) > sum(df$c[i], df$d[i]), ">", "<")
}

   
     