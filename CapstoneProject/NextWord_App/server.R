library(shiny)
library(stringi)
library(markdown)
library(DT)
library(tm)

# Load in the N-gram datasets
load("gram1.RData")
load("gram2.RData")
load("gram3.RData")
load("gram4.RData")

# Load in NextWord Algorithm
source("NextWord.R")

# Process profanity
#profanity <- readLines("profanity.txt")
#profanity <- stripWhitespace(profanity)
#profanity <- sub("\\s+$", "", profanity)

# Preset sentences
sent1 <- "Today is going to be a great"
sent2 <- "I'll dust them off and be on my"
sent3 <- "I'd give anything to see arctic monkeys this"
sent4 <- "Can you follow me please? It would mean the"
sent5 <- "The guy bought a pound of bacon and a case of"
sent6 <- "Every inch of you is perfect from the bottom to the"
sent7 <- "Hey sunshine, can you follow me and make me the"
sent8 <- "Love that film and haven't seen it in quite some"

# Define a server for the Shiny app
shinyServer(function(input, output, session) {
    
    output$result <- renderUI({
        if(input$phrase != ""){
            NextWord(input$phrase)
        }
    })
    
    output$table <- renderDataTable({
        if(input$phrase != ""){
            NextWords(input$phrase)
        }else{
            NextWords("")
        }
    })
    
    observeEvent(input$preset1, {
        updateTextInput(session, "phrase", value = sent1)
    })
    
    observeEvent(input$preset2, {
        updateTextInput(session, "phrase", value = sent2)
    })
    
    observeEvent(input$preset3, {
        updateTextInput(session, "phrase", value = sent3)
    })
    
    observeEvent(input$preset4, {
        updateTextInput(session, "phrase", value = sent4)
    })
    
    observeEvent(input$preset5, {
        updateTextInput(session, "phrase", value = sent5)
    })
    
    observeEvent(input$preset6, {
        updateTextInput(session, "phrase", value = sent6)
    })
    
    observeEvent(input$preset7, {
        updateTextInput(session, "phrase", value = sent7)
    })
    
    observeEvent(input$preset8, {
        updateTextInput(session, "phrase", value = sent8)
    })
})