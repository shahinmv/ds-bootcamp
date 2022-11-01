library(shiny)
library(shinythemes)
library(dplyr)
library(tidyverse)


# Define UI
ui <- fluidPage(theme = shinytheme("cerulean"),
                titlePanel("Exploratory Data Analysis"),
                
                navbarPage(
                  " ",
                  # theme = "cerulean",  # <--- To use a theme, uncomment this
                  tabPanel("Q1",
                           tableOutput("checker"),
                             
                  ), # Navbar 1, tabPanel
                  tabPanel("Q2", 
                           sidebarPanel(
                             selectInput("type", "Which type of variable?", c("is.numeric", "is.character")),
                             ),
                           mainPanel(
                             verbatimTextOutput("txtout"),
                           )
                  ),
                ) # navbarPage
) # fluidPage


# Define server function  
server <- function(input, output) {
  
  d <- reactive({ 
    d <- read_csv("Future-500.csv")
    print(glimpse(d)) # print from within
    return(d)
  })
  output$checker <- renderTable({
    glimpse(d())
  })
  
  output$txtout <- renderText({
    paste(ifelse(input$type=="is.numeric", skim(d(), where(is.numeric)), skim(d(), where(is.character))))
  })
} # server


# Create Shiny object
shinyApp(ui = ui, server = server)