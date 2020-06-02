source("winnie_charts.R")

page_one <- mainPanel(
  h2("How unemployment affect poverty based on the different states"),
  plotlyOutput(
    outputId = "interactive_graph"
  )
)

page_one_sliderbar <- sidebarPanel(
  sliderInput("slider2", label = h3("Adjust Unemployment Rate"), min = 0, 
              max = 1000, value = c(0, 1000))
)

page_one_main <- sidebarLayout(
  page_one,
  page_one_sliderbar
)
  ui <- navbarPage(
    "INFO 201 Info Project",
    tabPanel("Unemployment vs Poverty", page_one_main)
  )