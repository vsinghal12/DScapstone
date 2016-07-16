#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

source('predictStBackoff.R')
profanity<-readLines('ProfanityWords.txt')
profanity<-profanity[c(-1)]
badwords<-profanity

load('ngram.RData')
unigramDF<-unigramDF
bigramDF<-bigramDF
trigramDF<-trigramDF

# Define server logic required to predict next sequence of words
shinyServer(function(input, output){
                        dataInput<-reactive({
                                predict0(input$entry)
                        })
                        
                        output$text<-renderText({
                                dataInput()
                        })
                        
                        output$sent<-renderText({
                                input$entry
                        })
})
        
                # output$oWordPredictions <- renderText({
                # input$submitButton
                #         
                # results <- isolate(paste(
                #         unlist(lapply(predict0(input = input$sentenceInputVar, 
                #                       function(x) paste0("[", x, "]"))))))})})
                # 
                                      
# output$distPlot <- renderPlot({
#     
#     # generate bins based on input$bins from ui.R
#     x    <- faithful[, 2] 
#     bins <- seq(min(x), max(x), length.out = input$bins + 1)
#     
#     # draw the histogram with the specified number of bins
#     hist(x, breaks = bins, col = 'darkgray', border = 'white')
#     
#   })
#   
# })
