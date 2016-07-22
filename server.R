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
        

