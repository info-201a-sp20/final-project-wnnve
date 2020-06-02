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
    and see what states and counties have the highest prevalence.
    The second dataset we looked at answers how education correlates with unemployment. 
    It contains the unemployment rate based on the education qualification of adults that went
    to primary school, high school, Associates, and Professional degree. It also has the unemployment
    rate based on the race of adults."),
  sidebarLayout(
    img(src = "images/unemployment.jpg"),
    p("Unemployment has always been prevelent.... ")
  )
)



#Nicole's code 

year_selected <- sidebarPanel(
  h2("Choose what year to view"),
  selectInput(
    inputId = "selectyear",
    label = h3("Year"),
    choices = list("2010" = 2010,
                   "2011" = 2011,
                   "2012" = 2012, 
                   "2013" = 2013,
                   "2014" = 2014,
                   "2015" = 2015,
                   "2016" = 2016, 
                   "2017" = 2017, 
                   "2018" = 2018, 
                   "2019" = 2019)
  )
)

year_graph <- mainPanel(
  plotOutput(
    outputId = "select_plotly"
  )
)

main_graph <- mainPanel(
  plotOutput(
    outputId = "demographic_plotly"
  )
)

demographic_panel <- tabPanel(
  strong("Demographics"),
  titlePanel("Unemployment Among Race"),
  sidebarLayout(
    year_selected,
    year_graph
  ),
  main_graph,
  h2("Findings"),
  p("This chart reveals that among black, white, hispanic, 
    and asian people, black people had a higher unemployment 
    rate from 2010 - 2019. The green line shows the average 
    unemployment rate and this allows us to see that asian 
    and white people are below the average unemployment rate 
    while hispanic people are close to average and black people 
    are above average. This graph creates a visualization to see 
    how unemployment rates were widespread in 2010 but have become 
    closer to the same rate in 2019 although black people still 
    have the highest rate of unemployment.")
)

ui <- navbarPage(
  strong("Unemployment"),
  overview_panel,
  education_panel,
  demographic_panel
)
