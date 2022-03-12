ui <- fluidPage(
  titlePanel("Most Popular Names"),
  sidebarLayout(
    sidebarPanel(
      selectInput('sex', 'Select Sex', c("M", "F")),
      sliderInput('year', 'Select Year', min = 1880, max = 2017, value = 1900)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel('Plot',plotOutput('plot')),
        tabPanel('Table',tableOutput('table'))
      )
    )
  )
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    top_10_names <- babynames %>% 
      filter(sex == input$sex) %>% 
      filter(year == input$year) %>% 
      top_n(10, prop)
    ggplot(top_10_names, aes(x = name, y = prop)) +
      geom_col(fill = "#263e63")
  })
  
  output$table <- renderTable({
    # the get_top_names() is a function built to filter year and sex.
    get_top_names(input$year, input$sex)
  })
}
shinyApp(ui = ui, server = server)