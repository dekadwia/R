#Import Data
library(shiny)
library(dplyr)
library(plotly)
library(readxl)

#read data
ssit <- read_excel("11-SSIT.xlsx")

Department <- c("BB", "CS", "DH", "DU", "FC", "FD", "RD", "SG", "SL", "ST")
                
ui <- fluidPage(
    selectInput('department', 'Select Department', Department),
    # CODE BELOW: Add a plotly output named 'plot_trendy_names'
    plotly::plotlyOutput("Qty_Per_Department")
)
server <- function(input, output){
    # Function to plot trends in a name
    plot_Department <- function(){
        ssit %>% 
            filter(product == input$department) %>% 
            ggplot(aes(x = product, y = Qty)) +
            geom_col()
    }
    # CODE BELOW: Render a plotly output named 'plot_trendy_names'
    output$Qty-Per_Department <- plotly::renderPlotly({
        plot_Department()
    })
    
    
}
shinyApp(ui = ui, server = server)