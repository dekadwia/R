library(shiny)

ui <- fluidPage(
    textInput("name", "Enter a Name :"),
    selectInput("animal","Dogs or Cats?", choices = c("Dogs", "Cats")),
    textOutput("question"),
    textOutput("answer")
)

server <- function(input, output, session){
    output$question <- renderText({
        paste("Do you prefer dogs or cats,", input$name, "?")
    })
    output$answer <- renderText({
        paste("I Prefer", input$animal)
    })
}

shinyApp(ui = ui, server = server)