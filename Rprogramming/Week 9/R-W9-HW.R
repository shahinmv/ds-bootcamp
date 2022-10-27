library(tidyverse)

# Question 1
#------------------------------
employee_data <- read_csv("employee survey data.csv")
general_data <- read_csv("general data.csv")
manager_data <- read_csv("manager survey data.csv")

data <- merge(x=employee_data, y=general_data, by="EmployeeID", all.x=TRUE)
final_data <- merge(x=data, y=manager_data, by="EmployeeID", all.x=TRUE)

which(is.na(final_data))
#------------------------------

#Question 2
#------------------------------
final_data$EmployeeID <- as.factor(final_data$EmployeeID)
#------------------------------

#Question 3
#------------------------------
temp <- final_data
temp$EnvironmentSatisfaction[is.na(temp$EnvironmentSatisfaction)] <- mean(temp$EnvironmentSatisfaction, na.rm = TRUE)
temp$JobSatisfaction[is.na(temp$JobSatisfaction)] <- mean(temp$JobSatisfaction, na.rm = TRUE)
temp$WorkLifeBalance[is.na(temp$WorkLifeBalance)] <- mean(temp$WorkLifeBalance, na.rm = TRUE)
temp$MonthlyIncome[is.na(temp$MonthlyIncome)] <- mean(temp$MonthlyIncome, na.rm = TRUE)
temp$NumCompaniesWorked[is.na(temp$NumCompaniesWorked)] <- mean(temp$NumCompaniesWorked, na.rm = TRUE)
temp$PercentSalaryHike[is.na(temp$PercentSalaryHike)] <- mean(temp$PercentSalaryHike, na.rm = TRUE)
temp$TotalWorkingYears[is.na(temp$TotalWorkingYears)] <- mean(temp$TotalWorkingYears, na.rm = TRUE)
temp$YearsAtCompany[is.na(temp$YearsAtCompany)] <- mean(temp$YearsAtCompany, na.rm = TRUE)
temp$YearsSinceLastPromotion[is.na(temp$YearsSinceLastPromotion)] <- mean(temp$YearsSinceLastPromotion, na.rm = TRUE)
temp$YearsWithCurrMager[is.na(temp$YearsWithCurrMager)] <- mean(temp$YearsWithCurrMager, na.rm = TRUE)

which(is.na(temp))
#------------------------------

#Question 4
#------------------------------
hr_data <- read_csv("HR.csv")
#------------------------------

#Question 5
#------------------------------
rapply(hr_data,function(x)length(unique(x)))

hr_data$number_project <- as.factor(hr_data$number_project)
hr_data$Work_accident <- as.factor(hr_data$Work_accident)
hr_data$left <- as.factor(hr_data$left)
hr_data$promotion_last_5years <- as.factor(hr_data$promotion_last_5years)
hr_data$salary <- as.factor(hr_data$salary)
#------------------------------

#Question 6
#------------------------------
temp1 <- hr_data
colnames(temp1)[apply(temp1, 2, anyNA)]
temp1$satisfaction_level[is.na(temp1$satisfaction_level)] <- mean(temp1$satisfaction_level, na.rm = TRUE)
temp1$last_evaluation[is.na(temp1$last_evaluation)] <- mean(temp1$last_evaluation, na.rm = TRUE)
temp1$average_montly_hours[is.na(temp1$average_montly_hours)] <- mean(temp1$average_montly_hours, na.rm = TRUE)

which(is.na(temp1))
#------------------------------

#Question 7
#------------------------------
for (i in 1:nrow(temp1)){
  temp1$Experience[i] <- ifelse(temp1$time_spend_company[i] >= 10, "Experienced", "Not experienced")
}
#------------------------------

#Question 8
#------------------------------
temp1$left <- as.numeric(temp1$left)
test <- temp1 %>% group_by(Department)  %>% summarise(left = sum(left))
#------------------------------

#Question 9
#------------------------------

#------------------------------

#Question 10
#------------------------------
temp1$number_project <- as.numeric(temp1$number_project)
for (i in 1:nrow(temp1)){
  temp1$Valuable[i] <- ifelse(temp1$time_spend_company[i] > 3 & temp1$last_evaluation[i] > 0.72 & temp1$number_project[i] > 4, T, F)
}
