library(shiny)
library(shinythemes)
library(dplyr)
library(tidyverse)

injuries <- read_csv("injuries.csv")
population <- read_csv("population.csv")
products <- read_csv("products.csv")

ui <- fluidPage(fluidRow(
  column(8, selectInput('prod', 'Please choose the product:', products$title))),
  fluidRow(
    column(4, tableOutput('diag')),
    column(4, tableOutput('body_part')),
    column(4, tableOutput('location'))),
  fluidRow(
    column(12, plotOutput('age_sex'))
  )
) 


server <- function(input, output, session) {
  data <- reactive(injuries %>% left_join(products) %>% filter(title==input$prod))
  output$diag <- renderTable(data() %>% count(diag, sort = T) )
  output$body_part <- renderTable(data() %>% count(body_part, sort = T) )
  output$location <- renderTable(data() %>% count(location, sort = T) )
  output$age_sex <- renderPlot(data() %>% count(age, sex) %>% 
                                 merge(population, by = c("age", "sex"), all.x = T) %>% 
                                 mutate(rate = n / population * 10000) %>% 
                                 ggplot(aes(age, rate, colour = sex)) + 
                                 geom_line() + 
                                 labs(y = "Injuries per 10,000 people"))
}

shinyApp(ui, server)
