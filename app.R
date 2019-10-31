## Tracey Mangin
## October 30, 2019

library(tidyverse)
library(shiny)
library(shinythemes)

spooky <- read_csv("spooky_data.csv")

ui <- fluidPage(
  titlePanel("My awesome Halloween app"),
  sidebarLayout(
    sidebarPanel("widget life:",
                 selectInput(
                   inputId = "state_select",
                   label = "Choose a state:",
                   choices = unique(spooky$state)
                 ),
                 radioButtons(inputId = "region_select",
                              label = "Choose a region",
                              choices = unique(spooky$region_us_census))),
    mainPanel("outputs:",
              tableOutput(outputId = "candy_table"))
  )
)

server <- function(input, output) {

  state_candy <- reactive({
    spooky %>%
      filter(state == input$state_select)
  })

  output$candy_table <- renderTable({
    state_candy()

  })

}

shinyApp(ui = ui, server = server)
