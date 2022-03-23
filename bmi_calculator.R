server <- function(input, output, session) {
  # CODE BELOW: Add a reactive expression rval_bmi to calculate BMI
  rval_bmi <- reactive({
    input$weight/(input$height^2)
  })
  
  
  output$bmi <- renderText({
    # MODIFY CODE BELOW: Replace right-hand-side with reactive expression
    bmi <- rval_bmi()
    paste("Your BMI is", round(bmi, 1))
  })
  output$bmi_range <- renderText({
    # MODIFY CODE BELOW: Replace right-hand-side with reactive expression
    bmi <- rval_bmi()
    bmi_status <- cut(bmi, 
                      breaks = c(0, 18.5, 24.9, 29.9, 40),
                      labels = c('underweight', 'healthy', 'overweight', 'obese')
    )
    paste("You are", bmi_status)
  })
}
ui <- fluidPage(
  titlePanel('BMI Calculator'),
  sidebarLayout(
    sidebarPanel(
      numericInput('height', 'Enter your height in meters', 1.5, 1, 2),
      numericInput('weight', 'Enter your weight in Kilograms', 60, 45, 120)
    ),
    mainPanel(
      textOutput("bmi"),
      textOutput("bmi_range")
    )
  )
)
shinyApp(ui = ui, server = server)