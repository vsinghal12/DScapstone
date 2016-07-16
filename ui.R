#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Prediction Text App"),
  
  sidebarPanel(
          textInput("entry",
                    h5("Input the sentence"),
                    "Demo Input"),
          submitButton("SUBMIT"),
          br(),
          h5("Due to intensity of calculations this app times out on occasion. If it does not work for you, please visit github portal to see code in action")
  )
  

 
  
  # # Sidebar with a slider input for number of bins 
  # sidebarLayout(
  #   sidebarPanel(
  #      sliderInput("bins",
  #                  "Number of bins:",
  #                  min = 1,
  #                  max = 50,
  #                  value = 30)
  #   ),
  #   
  #   # Show a plot of the generated distribution
  #   mainPanel(
  #      plotOutput("distPlot")
  #   )
  # )
))
