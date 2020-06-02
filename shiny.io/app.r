library(shiny)

source("my_ui.R")
source("my_server.R")
library("plotly")

shinyApp(ui = ui, server = server)

