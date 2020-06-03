#Quinn app

#Libraries
library(shiny)

#Sources
source("quinn_ui.R")
source("quinn_server.R")

#Shiny App
shinyApp(ui = ui, server = server)