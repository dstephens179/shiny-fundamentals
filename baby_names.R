library(shiny)
library(tidyverse)

ui <- fluidPage(
  titlePanel("Baby Name Explorer"),
  sidebarLayout(
    sidebarPanel(
      textInput('name', 'Enter name', 'David')
    ),
    mainPanel(
      plotOutput('trend')
    )
  )
)
  
server <- function(input, output, session){
  output$trend <- renderPlot({
    data_name <- subset(
      babynames, name == input$name
    )
    ggplot(data_name) +
      geom_line(
        aes(x = year, y = prop, color = sex)
      )
  })
}
  
shinyApp(ui = ui, server = server)