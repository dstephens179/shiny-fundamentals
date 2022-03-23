library(shiny)
library(tidyverse)


### this shows a pop-up when a name is entered.  Not so cool.


ui <- fluidPage(
  textInput('name', "Enter your name")
)

server <- function(input, output, session){
  # setting up an observer to showNotification
  observe({
    showNotification(
      paste("You entered the name", input$name)
    )
  })

}

shinyApp(ui = ui, server = server)