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
  strong("Unemployment vs Education Chart"),
  titlePanel("Unemployment vs Education"),
  sidebarLayout(
    year_content,
    main_content
  )
)

overview_panel <- tabPanel(
  strong("Overview"),
  titlePanel("Overview"),
  p("unemployment has been at an all time high because of the coronavirus, 
  however, we want to analyze what other factors could affect unemployment. We specifically
    analyzed poverty, education, and demographics. Now with our findings, we decided to exclude
    the year 2020 because we did not have the sufficient amount of information to analyze our data.
    The numbers would have been skewed and incorrect, thus impacting the rest of our data analysis."),
  p("Some questions we are seeking to answer are... We will be using ____ and ___ datasets to answer
    these questions. The first dataset we looked at was unemployment vs poverty. 
    This dataset answers questions of how unemployment is spread throughout the U.S. 
    and we can also compare that to how poverty is spread throughout the U.S. 
    This will allow us to examine the relationship between unemployment and poverty 
    and see what states and counties have the highest prevalence."),
  sidebarLayout(
    img(src = "images/unemployment.jpg"),
    p("Unemployment has always been prevelent.... ")
  )
)

ui <- navbarPage(
  strong("Unemployment"),
    overview_panel,
    education_panel
)