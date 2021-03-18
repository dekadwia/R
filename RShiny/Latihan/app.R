library(shiny)
library(ggplot2)
library(babynames)

ui <- fluidPage(
    selectInput("sex", "select sex", choices = c("F","M"))
)
