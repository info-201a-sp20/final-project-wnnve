library(shiny)

source("winnie_ui.R")
source("winnie_server.R")
source("winnie_charts.R")
library("plotly")

shinyApp(ui = ui, server = server)