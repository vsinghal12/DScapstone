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
        # Application title
          titlePanel("Prediction Text App"),

          sidebarPanel(
                  textInput("entry",
                            h5("Input the sentence"),
                            "The weather is "),
                  submitButton("SUBMIT"),
                  br(),
                  h5("Press submit to see predictions based on input")
          ),
        
         
        
        mainPanel(
                tabsetPanel(type = "tabs", 
                            tabPanel("Output", 
                                     span(h4(textOutput('text')),style = "color:blue")
                                     
                           
                            )
                            
                ))
))
