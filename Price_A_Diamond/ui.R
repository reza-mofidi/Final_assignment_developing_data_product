library(shiny)
library(tidyverse)
data(diamonds)
diamonds <- diamonds[1:8]
shinyUI(fluidPage(

    # Application title
    titlePanel("Price any Diamond Dot com "),

    sidebarLayout(
        sidebarPanel(
            sliderInput("slidercarat", "What is the weight of the diamond in carats?", 0.2, 5.01, value = 1.1),
            sliderInput("sliderDepth", "What is Depth of the diamond?", 43, 79, value = 61.8),
            sliderInput("sliderTable", "What is the Table value?", 43, 95, value = 57),
            selectInput("cut", "What is the cut?", levels(diamonds$cut)), 
            selectInput("color", "What is the color?", levels(diamonds$color)), 
            selectInput("clarity", "What is the clarity?", levels(diamonds$clarity)), 
        ),
        mainPanel(
            plotOutput("plot1"),
             h4("Predicted Price ($):"),
            h4(textOutput("pred1"))
        )
    )
)
)
