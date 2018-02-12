#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
shinyServer(function(input, output) {
    
    dataInput <- reactive({
        if (input$species == "all"){
            dataInput <- iris
        }else{
           dataInput <- subset(iris, Species == input$species)
        }
    })
    model1 <- reactive({lm(Petal.Width ~ Petal.Length, data = dataInput()) 
    })
    model1pred <- reactive({
        lengthInput <- input$sliderLength
        predict(model1(), newdata = data.frame(Petal.Length = lengthInput))
    })
    output$plot1 <- renderPlot({
        lengthInput <- input$sliderLength
        xmin <- min(dataInput()$Petal.Length) - .1
        ymin <- min(dataInput()$Petal.Width) - .1
        xmax <- max(dataInput()$Petal.Length) + .1
        ymax <- max(dataInput()$Petal.Width) + .1
        plot(dataInput()$Petal.Length, dataInput()$Petal.Width,
             main = input$species, col = "blue",
             xlab = "Petal Length (cm)", ylab = "Petal Width (cm)", bty = "n", pch = 16, 
             xlim = c(xmin, xmax), ylim = c(ymin,ymax))
        if(input$showModel1){
            abline(model1(), col = "darkred", lwd = 2)
        }
        legend(xmin + .1, ymax, c("Model Prediction"), pch = 16, 
               col = c("darkred"), bty = "n", cex = 1.2)
        points(lengthInput, model1pred(), col = "darkred", pch = 16, cex = 2)
    })
    output$pred1 <- renderText({
        model1pred()
    })
    output$warning <- renderText({
        lengthInput <- input$sliderLength
        tooLow <- min(dataInput()$Petal.Length)
        tooHigh <- max(dataInput()$Petal.Length)
        if((lengthInput < tooLow) | (lengthInput > tooHigh))
            "Warning: Petal length input outside the data range."
    })
})