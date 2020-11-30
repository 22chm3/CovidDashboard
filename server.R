library(shiny)
library(shinydashboard)
library(DT)
library(readr)

# Test comment for commit

shinyServer(function(input, output, session) {
    
    df <- reactiveFileReader(
        intervalMillis = 36000000, # Update every 10 hours
        session = session,
        filePath = "https://covidtracking.com/data/download/all-states-history.csv",
        readFunc = read_csv
    )
    
    output$numCases <- renderValueBox({
        covid <- df()
        covidRangeData <- covid %>% select(date, hospitalizedIncrease, positiveIncrease) %>% 
            filter(date >= input$date[1], date <= input$date[2])
        numCases <- sum(covidRangeData$positiveIncrease)
        valueBox(
            value=numCases,
            subtitle = "Number of New Cases",
            color = "red"
        )
    })
    
    output$numHospitalized <- renderValueBox({
        covid <- df()
        covidRangeData <- covid %>% select(date, hospitalizedIncrease, positiveIncrease) %>% 
            filter(date >= input$date[1], date <= input$date[2])
        numHospitalized <- sum(covidRangeData$hospitalizedIncrease)
        valueBox(
            value=numHospitalized,
            subtitle = "Number Hospitalized",
            color = "orange"
        )
    })
    
})
