library(shiny)
library(ggvis)
library(DT)

# Load in the MLB dataset
data <- read.csv("MLB Team History (1973-2014).csv", check.names = FALSE)
teams <- sort(unique(as.character(data$Franchise)))
axis_vars <- as.character(colnames(data)[colnames(data) != "Team"
                                         & colnames(data) != "Franchise"])

# Define a server for the Shiny app
shinyServer(function(input, output, session) {
    
    #Intialize reactive values
    values <- reactiveValues()
    values$teams <- teams
    
    #Create checkboxes
    output$teams <- renderUI({
        checkboxGroupInput("teams",
                           "Teams:",
                           teams,
                           selected = values$teams)
    })
    
    #Add observer to select all/clear buttons
    observe({
        if(input$selectall == 0) return()
        values$teams <- teams
    })
    
    observe({
        if(input$clearselection == 0) return()
        values$teams <- c()
    })
    
    #Filter data based on selections
    dataInput <- reactive({
        data <- data[data$Year >= input$range[1] & data$Year <= input$range[2] &
                         data$Franchise %in% input$teams,]
    })
    
    #Render data table
    output$table <- renderDataTable({
        dataInput()
    })
        
    # A reactive expression with the ggvis plot
    vis <- reactive({
        # Lables for axes
        xvar_name <- names(axis_vars)[axis_vars == input$xvar]
        yvar_name <- names(axis_vars)[axis_vars == input$yvar]
        
        xvar <- prop("x", as.symbol(input$xvar))
        yvar <- prop("y", as.symbol(input$yvar))
        
        dataInput %>%
            ggvis(x = xvar, y = yvar) %>%
            layer_points(size := 50, fillOpacity := 0.2) %>%
            add_axis("x", title = xvar_name) %>%
            add_axis("y", title = yvar_name) %>%
            set_options(width = 500, height = 500)
    })
    
    vis %>% bind_shiny("plot")
})