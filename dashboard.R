library(shiny)
library(shinythemes)
library(shinydashboardPlus)
library(tidyverse)
library(DT)
library(plotly)
options(scipen=999)



ui <- fluidPage(
  titlePanel('Grupo Miriam'),
  theme = shinytheme("superhero"),
  sidebarLayout(
    sidebarPanel(
      selectInput('tienda', 'Select tienda', unique(sales_monthly$tienda))
#      selectInput('owner', 'Select owner', c(NULL, unique(sales_monthly$owner)))
    ),
    mainPanel(
      tabsetPanel(
        tabPanel('Table',dataTableOutput('table')),
        tabPanel('Plot',plotlyOutput('plot'))
      )
    )
  )
)

server <- function(input, output, session) {
  # here is where you set up a reactive expression so the dataframe filters are not repeated.
 rval_data <- reactive({
   sales_monthly %>%
     filter(tienda == input$tienda)
   
 })
  output$table <- DT::renderDataTable({
    rval_data()
  })
  output$plot <- renderPlotly({
    rval_data() %>%
    ggplot(sales_monthly, mapping = aes(x = year, y = total_sales)) +
      geom_col()
  })
}

shinyApp(ui = ui, server = server)