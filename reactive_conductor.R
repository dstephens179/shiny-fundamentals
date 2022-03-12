library(shiny)
library(tidyverse)

ui <- fluidPage(
  titlePanel("Greeting"),
  sidebarLayout(
    sidebarPanel(
      textInput('name', 'Enter name'),
      textOutput('greeting')
    ),
    mainPanel(
      plotOutput('plot_trendy_names')
    )
  )
)

server <- function(input, output, session){
  # here is where you set up a reactive expression so the babynames dataframe is not repeated.
  rval_babynames <- reactive({
    babynames %>%
      filter(name == input$name)
  })
  output$plot_trendy_names <- plotly::renderPlotly({
    rval_babynames() %>%
      ggplot(val_bnames, aes(x = year, y = n)) +
      geom_col()
  })
  output$table_trendy_names <- DT::renderDT({
    rval_babynames()
  })
}