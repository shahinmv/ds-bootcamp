library(shiny)
library(shinythemes)
library(dplyr)
library(tidyverse)


ui <- fluidPage(theme = shinytheme("cerulean"),
                titlePanel("Exploratory Data Analysis"),
                navbarPage(
                  " ",
                  tabPanel("Q4",
                           tableOutput("checker"),
                             
                  ),
                  tabPanel("Q5", 
                           sidebarPanel(
                             selectInput("type", "Which type of variable?", c("is.numeric", "is.character")),
                             ),
                           mainPanel(
                             verbatimTextOutput("txtout"),
                           )
                  ),
                  tabPanel("Q6",
                           plotOutput("na_plot1"),
                  ),
                  tabPanel("Q7",
                           plotOutput("na_plot2"),
                  ),
                  tabPanel("Q8",
                           plotOutput("na_plot3"),
                           plotOutput("na_plot4"),
                  ),
                  tabPanel("Q9",
                           plotOutput("na_plot5"),
                           plotOutput("na_plot6"),
                  ),
                ) 
) 


server <- function(input, output) {
  
  d <- reactive({ 
    d <- read_csv("Future-500.csv")
    return(d)
  })
  output$checker <- renderTable({
    glimpse(d())
  })
  
  output$txtout <- renderText({
    d <- read_csv("Future-500.csv")
    paste(ifelse(input$type=="is.numeric", skim(d, where(is.numeric)), skim(d, where(is.character))))
  })
  
  output$na_plot1 <- renderPlot({
    d <- read_csv("Future-500.csv")
    show_plot(inspect_na(d))
  })
  output$na_plot2 <- renderPlot({
    d <- read_csv("Future-500.csv")
    show_plot(inspect_cor(d))
  })
  output$na_plot3 <- renderPlot({
    d <- read_csv("Future-500.csv")
    indprofit <-  d %>% group_by(Industry) %>% summarise(profit = sum(Profit)) %>% view()
    indprofit$profit[is.na(indprofit$profit)] <- 0
    barplot(indprofit$profit, names.arg = indprofit$Industry)
  })
  output$na_plot4 <- renderPlot({
    d <- read_csv("Future-500.csv")
    indprofit <-  d %>% group_by(Inception) %>% summarise(profit = sum(Profit)) %>% view()
    indprofit$profit[is.na(indprofit$profit)] <- 0
    barplot(indprofit$profit, names.arg = indprofit$Inception)
  })
  output$na_plot5 <- renderPlot({
    d <- read_csv("Future-500.csv")
    indprofit <-  d %>% group_by(Industry) %>% summarise(profit = sum(Profit)) %>% view()
    indprofit$profit[is.na(indprofit$profit)] <- 0
    indprofit <- indprofit[order(-indprofit$profit),]
    barplot(indprofit$profit, names.arg = indprofit$Industry)
  })
  output$na_plot6 <- renderPlot({
    d <- read_csv("Future-500.csv")
    indprofit <-  d %>% group_by(Inception) %>% summarise(profit = sum(Profit)) %>% view()
    indprofit$profit[is.na(indprofit$profit)] <- 0
    indprofit <- indprofit[order(-indprofit$profit),]
    barplot(indprofit$profit, names.arg = indprofit$Inception)
  })
}


shinyApp(ui = ui, server = server)