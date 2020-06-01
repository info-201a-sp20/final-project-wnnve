library(shiny)
library(ggplot2)

year_content <- sidebarPanel(
  sliderInput(
    inputId = "year_var",
    label = "Year", min = 2009, max = 2020, value = c(2009, 2020)
  )
)

main_content <- mainPanel(
  plotOutput("plot"),
)

education_panel <- tabPanel(
  "Unemployment vs Education Chart",
  titlePanel("Unemployment vs Education"),
  sidebarLayout(
    year_content,
    main_content
  )
)

ui <- navbarPage(
  h1("Unemployment"),
  education_panel
)