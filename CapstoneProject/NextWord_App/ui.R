library(shiny)
source("server.R")

# Define the overall UI
shinyUI(
    navbarPage("NextWord Application",
               
        tabPanel("NextWord", icon = icon("database"),
            sidebarPanel(width = 5,
                textInput("phrase", "Enter a phrase or select a preset:", ""),
                br(),
                actionButton("preset1", width = "100%", label = sent1),
                actionButton("preset2", width = "100%", label = sent2),
                actionButton("preset3", width = "100%", label = sent3),
                actionButton("preset4", width = "100%", label = sent4),
                actionButton("preset5", width = "100%", label = sent5),
                actionButton("preset6", width = "100%", label = sent6),
                actionButton("preset7", width = "100%", label = sent7),
                actionButton("preset8", width = "100%", label = sent8),
                br(),
                br(),
                fluidRow(
                    column(6, align = "center",
                        h1("NextWord: ")),
                    column(6, align = "center",
                        h1(htmlOutput("result")))
                )
            ),
            mainPanel(h3("Top Results:"), width = 7,
                dataTableOutput("table")
            )
            
        ),
        tabPanel("About", icon = icon("info-circle"),
                 includeMarkdown("About.md")
        ),
        tabPanel("Algorithm", icon = icon("code"),
                 includeMarkdown("NextWordAlgorithm.md")
        )
    )
)