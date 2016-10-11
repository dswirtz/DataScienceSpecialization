library(shiny)
library(DT)
library(dplyr)
library(ggvis)
require(markdown)

# Load in the MLB dataset
data <- read.csv("MLB Team History (1973-2014).csv", check.names = FALSE)
teams <- sort(unique(as.character(data$Franchise)))
axis_vars <- as.character(colnames(data)[colnames(data) != "Team"
                                         & colnames(data) != "Franchise"])

# Define the overall UI
shinyUI(
    navbarPage("MLB Team History from 1973 to 2014",
               
        tabPanel("MLB Data", icon = icon("database"),
            sidebarPanel(
                tabsetPanel(
                    tabPanel("Teams",
                             icon = icon("users"),
                             sliderInput("range",
                                         "Select Years:",
                                         min = 1973,
                                         max = 2014,
                                         value = c(1973, 2014)),
                             uiOutput("teams"),
                             actionButton("clearselection",
                                          "Clear",
                                          icon = icon("square-o")),
                             actionButton("selectall",
                                          "Select All",
                                          icon = icon("check-square-o"))
                    ),
                    tabPanel("Legend",
                             icon = icon("list-alt", lib = "glyphicon"),
                             includeMarkdown("Legend.md")
                    )
                )    
            ),
            mainPanel(
                tabsetPanel(
                    tabPanel("Data Table",
                             icon = icon("table"),
                             dataTableOutput("table")
                    ),
                    tabPanel("Charts",
                             icon = icon("line-chart"),
                             fluidRow(
                                 column(3,
                                        selectInput("xvar", "X-axis variable",
                                                    axis_vars,
                                                    selected = "Year")),
                                 column(3,
                                        selectInput("yvar", "Y-axis variable",
                                                    axis_vars,
                                                    selected = "G"))
                             ),
                             ggvisOutput("plot")
                    )
                )
            )
        ),
        tabPanel("About", icon = icon("info-circle"),
                 includeMarkdown("About.md")
        )
    )
)