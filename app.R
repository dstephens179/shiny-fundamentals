
messageData <- data.frame(
  from = c("Admininstrator", "New User", "Support"),
  message = c(
    "This is dynamic.",
    "Messages are in a dataframe...",
    "expecting two columns: 'from' and 'message.'"
  ),
  stringsAsFactors = FALSE
)




header <- dashboardHeader(
  title = tags$a(tags$img(src="www/logotipo.png", height = '30', width = '30')),
    dropdownMenu(type = "messages",
                 messageItem(
                   from = "Sales Dept",
                   message = "Sales are steady this month."
                 ),
                 messageItem(
                   from = "New User",
                   message = "How do I register?",
                   icon = icon("question"),
                   time = "13:45"
                 ),
                 messageItem(
                   from = "Support",
                   message = "The new server is ready.",
                   icon = icon("life-ring"),
                   time = "2014-12-01"
                 )
    ),
    dropdownMenuOutput("messageMenu"),
    dropdownMenu(type = "notifications", badgeStatus = "info",
                 notificationItem(
                   text = "5 new users today",
                   icon("users")
                 ),
                 notificationItem(
                   text = "12 items delivered",
                   icon("truck"),
                   status = "success"
                 ),
                 notificationItem(
                   text = "Server load at 86%",
                   icon = icon("exclamation-triangle"),
                   status = "warning"
                 )
    ),
    dropdownMenu(type = "tasks", badgeStatus = "success",
                 taskItem(value = 90, color = "green",
                          "Documentation"
                 ),
                 taskItem(value = 17, color = "aqua",
                          "Project X"
                 ),
                 taskItem(value = 75, color = "yellow",
                          "Server deployment"
                 ),
                 taskItem(value = 80, color = "red",
                          "Overall project"
                 )
    )
)




sidebar <- dashboardSidebar(
  sidebarMenu(
    sidebarSearchForm(textId = "searchText",
                      buttonId = "searchButton",
                      label = "Search..."),
    menuItem("Sobre Vista",
             tabName = "vista",
             icon = icon("dashboard")),
    menuItem("Producto", 
             tabName = "producto",
             icon = icon("th"),
             badgeLabel = "new",
             badgeColor = "green"),
    dateRangeInput("daterange", "Date Range:",
                   start = "2022-01-01",
                   end   = today(),
                   min = "2015-07-01",
                   max = today(),
                   format = "M-d-yy",
                   separator = "-")
    
  )
)




body <- dashboardBody(
  shinyDashboardThemes(theme = "grey_light"),
  tags$div(tags$style(HTML( ".dropdown-menu{z-index:10000 !important;}"))),
  tabItems(
    # Content for "Sobre Vista" tab from sidebar
    tabItem(tabName = "vista",
            fluidRow(
              valueBox(10*2, "New Orders", icon = icon("credit-card")),
              valueBoxOutput("progressBox"),
              valueBoxOutput("approvalBox")
            ),
            
            fluidRow(
              box(
                plotOutput("plot1", height = 250)),
              
              box(
                title = "Controls",
                sliderInput("slider", "Number of observations:", 1, 100, 50)
              )
            )
    ),
    
    # Content for "Producto" tab from sidebar
    tabItem(tabName = "producto",
            h2("Producto tab content")
    )
  )
)





server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
  
  output$messageMenu <- renderMenu({
    # Code to generate each of the messageItems here, in a list. messageData
    # is a data frame with two columns, 'from' and 'message'.
    # Also add on slider value to the message content, so that messages update.
    msgs <- apply(messageData, 1, function(row) {
      messageItem(
        from = row[["from"]],
        message = paste(row[["message"]], input$slider)
      )
    })
    
    output$progressBox <- renderValueBox({
      valueBox(
        "25%", "Progress", icon = icon("list"),
        color = "purple"
      )
    })
    
    output$approvalBox <- renderValueBox({
      valueBox(
        "80%", "Approval", icon = icon("thumbs-up", lib = "glyphicon"),
        color = "yellow"
      )
    })
    
    dropdownMenu(type = "tasks", badgeStatus = "danger", .list = msgs)
  })
}



ui <- dashboardPage(header, sidebar, body, dashboardControlbar())
shinyApp(ui, server)


