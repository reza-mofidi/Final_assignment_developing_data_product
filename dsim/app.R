library(shiny)

ui <- fluidPage(

    titlePanel("Diamonds are Forever!"),
    
    sidebarLayout(
        sidebarPanel(
            sliderInput("slidercarat", "What is the weight of the diamond in carats?", 0.55, 4.5, value = 1.1),
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


# Define server logic required to draw a histogram
server <- function(input, output) {
        
        model1<- lm(price~0+carat+cut, data = diamonds)
        model2<- lm(price~0+carat, data = diamonds)
        model1pred <- reactive({
            caratInput<- input$slidercarat
            depthInput<- input$sliderDepth
            tableInput<- input$sliderTable
            cutInput<- input$cut
            colorInput<- input$color
            clarityInput<- input$clarity
            
            predict(model1, newdata=data.frame(carat=caratInput, cut=cutInput, color=colorInput, clarity=clarityInput
            ))
            
        })
        
        output$plot1 <- renderPlot({
            caratInput <- input$slidercarat
            
            plot1<- plot(diamonds$carat, diamonds$price, col=diamonds$cut, xlab = "Size in Carat", 
                         ylab = "Price ($)", bty = "n", pch = 16,
                         xlim = c(0.2, 5.01), ylim = c(300, 30000))
            abline(model2, col="blue", cex=1.2)
            points(caratInput, model1pred(), col = "red", pch = 16, cex = 2)
        })
        output$plot2 <- renderPlot({    
            plot2 <- plot_ly(diamonds, x=diamonds$carat, y=diamonds$depth,
                             z=diamonds$price, color = diamonds$cut, type = "scatter3d")
        })
        output$pred1 <- renderText({
            model1pred()
        })
}

# Run the application 
shinyApp(ui = ui, server = server)
