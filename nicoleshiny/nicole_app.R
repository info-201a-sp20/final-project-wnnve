library("shiny")
library("ggplot2")

#load the ui and server
source("nicole_ui.R")
source("nicole_server.R")


shinyApp(ui = ui, server = server)