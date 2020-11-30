library(shiny)
library(shinydashboard)
library(DT)

dashboardPage(
    dashboardHeader(title = "COVID-19 Dashboard"),
    dashboardSidebar(
        dateRangeInput("date",
                  label = "Select Date Range:",
                  start = "2020-04-01",
                  end = "2020-04-05",
                  min = "2020-02-29",
                  max = Sys.Date())
    ),
    dashboardBody(
        fluidRow(
            valueBoxOutput(width=6, "numCases"),
            valueBoxOutput(width=6, "numHospitalized")
        )
    )
)
