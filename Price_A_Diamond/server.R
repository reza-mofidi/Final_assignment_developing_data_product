library(shiny)
library(tidyverse)

set.seed(123456)

shinyServer(function(input, output) {
    
    model1<- lm(price~0+carat+cut+color+clarity+depth+table, data = diamonds)
     model1pred <- reactive({
        caratInput<- input$slidercarat
        depthInput<- input$sliderDepth
        tableInput<- input$sliderTable
        cutInput<- input$cut
        colorInput<- input$color
        clarityInput<- input$clarity
        
        predict(model1, newdata=data.frame(carat=caratInput, cut=cutInput, color=colorInput, clarity=clarityInput, 
                                           depth=depthInput, table=tableInput))

        })
  
    output$plot1 <- renderPlot({
        caratInput <- input$slidercarat
        
       plot1<- plot(diamonds$carat, diamonds$price, xlab = "Size in Carat", 
             ylab = "Price ($)", bty = "n", pch = 16,
             xlim = c(0.2, 5.01), ylim = c(300, 30000))

        points(caratInput, model1pred(), col = "red", pch = 16, cex = 2)
    })
    output$pred1 <- renderText({
            model1pred()
    })
})
