library(shiny)
library(ggplot2)

ui <- fluidPage(
    titlePanel("Baby Name Explorer"),
    # CODE BELOW: Add a sidebarLayout, sidebarPanel, and mainPanel
        sidebarPanel(
            textInput('name', 'Enter Name', 'David')
        ),
        mainPanel(
            plotOutput('trend')
        ))

server <- function(input, output, session) {
    output$trend <- renderPlot({
        ggplot()
    })
}
shinyApp(ui = ui, server = server)
