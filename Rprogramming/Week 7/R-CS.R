set.seed(123)
data <- data.frame(random = rnorm(50))

# 1
for(i in 1:nrow(data)){
  data$a[i] <- ifelse(data$random[i]> data$random[i-1], 1, 0)
}

# 2
for(i in 1:nrow(data)){
  data$b[i] <- ifelse(data$random[i]> sum(data$random), 1, 0)
}

# 3 
for(i in 1:nrow(data)){
  data$c[i] <- ifelse(data$random[i]> sum(data$random[i],data$random[i-1], sum(data$random)), 1, 0)
}

# 4
for(i in 1:nrow(data)){
  data$d[i] <- ifelse(abs(data$random[i])> abs(data$random[i-1]), 1, 0)
}

# 5

for(i in 1:nrow(data)){
  data$e[i] <- ifelse(abs(data$random[i])> sum(data$random), 1, 0)
}

# 6
for(i in 1:nrow(data)){
  data$f[i] <- ifelse(abs(sum(data$random[i-1], data$random[i]))> sum(data$random), 1, 0)
}

# 7
for(i in 1:nrow(data)){
  data$n[i] <- sum(data$a[i], data$b[i], data$c[i], data$d[i], data$d[i], data$e[i])
}

