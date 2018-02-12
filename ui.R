#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


library(shiny)
shinyUI(fluidPage(
    titlePanel("PetalApp: Predict iris petal width from petal length"),
    selectInput("species", "Choose species:",
                 choices = c("All" = "all",
                             "Setosa" = "setosa", 
                             "Versicolor" = "versicolor",
                             "Virginica" = "virginica")),
    sidebarLayout(
        sidebarPanel(
                sliderInput("sliderLength", "What is the petal length?", 1, 7, 
                            step = 0.25, value = 1),
                checkboxInput("showModel1", "Check box to show model", value = TRUE),
                submitButton("Submit"),
                h3(""),
                includeHTML("PetalApp_documentation.html")
                
        ),
        mainPanel(
            plotOutput("plot1"),
            h3("Predicted petal width in centimeters:"),
            textOutput("pred1"),
            h3(""),
            em(textOutput("warning"))
        )
    )
))
            
            