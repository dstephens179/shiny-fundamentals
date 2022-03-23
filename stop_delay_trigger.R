library(shiny)

### isolate; allows an expression to read a reactive value without triggering re-execution when its value changes.
server(input, output, session) {
  output$greeting <- renderText({
    paste(
      isolate(input$greeting_type, input$name, sep = ", ")
    )
  })
}



### eventReactive; updated only when user clicks button.
server(input, output, session) {
  rv_greeting <- eventReactive(input$show_greeting, {
    paste('Hello', input$name)
  })
  output$greeting <- renderText({
    rv_greeting()
  })
}


### observeEvent; triggering actions to display something after click. Used only for side-effects.
server <- function(input, output, session){
  observeEvent(input$show_greeting, {
    showModal(modalDialog(paste("Hello", input$name)))
  })
}


ui <- fluidPage(
  fluidRow(
    
  )
)