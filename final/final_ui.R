library(shiny)
library(ggplot2)
library(shinythemes)

year_content <- sidebarPanel(
  sliderInput(
    inputId = "year_var",
    label = "Year", min = 2009, max = 2020, value = c(2009, 2020)
  )
)

main_content <- mainPanel(
  plotlyOutput("plot"),
)

education_panel <- tabPanel(
  strong("Unemployment vs Education Chart"),
  titlePanel("Unemployment vs Education"),
  sidebarLayout(
    year_content,
    main_content
  ),
  h2(strong("Findings")),
  p("I included this stacked bar chart because it compares
    the unemployment rates of each education level by year. 
    This is easier to see the differences. The chart reveals 
    the average unemployment rate for each education level by year. 
    One thing I observed from this was that the discrepancy between 
    a primary school education level and a professional school 
    education level got smaller as the years passed. In addition,
    the chart descended as the years passed, which means that 
    unemployment levels decreased.")
)

overview_panel <- tabPanel(
  strong("Overview"),
  titlePanel("Overview"),
  p("Unemployment has been at an all time high because of the coronavirus, 
  however, we want to analyze what other factors could affect unemployment. We specifically
    analyzed poverty, education, and demographics. Now with our findings, we decided to exclude
    the year 2020 because we did not have the sufficient amount of information to analyze our data.
    The numbers would have been skewed and incorrect, thus impacting the rest of our data analysis."),
  h2("Questions:"),
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
    img(src = "https://media.heartlandtv.com/images/Unemployment+image+4.jpg",
        width = "900",
        height = "400"),
    p("Unemployment has always been prevelent.... ")
  )
)



#Nicole's code 

year_selected <- sidebarPanel(
  h2("Choose what year to view:"),
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
  plotlyOutput(
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
  h2(strong("Findings")),
  p("These charts reveal that among black, white, hispanic, 
    and asian people, black people had a higher unemployment 
    rate from 2010 - 2019. The green/yellow line shows the average 
    unemployment rate and this allows us to see that asian 
    and white people are below the average unemployment rate 
    while hispanic people are close to average and black people 
    are above average. This graph creates a visualization to see 
    how unemployment rates were widespread in 2010, but overtime, have 
    decreased and have become slightly more uniform. However, black 
    people still have the highest rate of unemployment and 
    disparities are still present.")
)

#Winnie's Page
page_one <- mainPanel(
  plotlyOutput(
    outputId = "interactive_graph"
  )
)

page_one_sliderbar <- sidebarPanel(
  sliderInput("slider2", label = h3("Adjust Unemployment Rate"), min = 0, 
              max = 150, value = c(0, 150)),
  p("You can adjust the range of the unemployment rate by sliding the slider")
)

unemployment_panel <- tabPanel(
  strong("Unemployment vs Poverty"),
  titlePanel("How Unemployment Effects Poverty By States"),
  sidebarLayout(
    page_one,
    page_one_sliderbar
  ),
  h2("Findings"),
  p("This graph shows the unemployment rate and the people in poverty by state. 
    When you hover over the dots, it'll show the state, the number of people in poverty,
    and the unemployment rate for that state. This chart reveals that unemployment and the 
    people in poverty are mostly correlated. As you can see, one of the furthest dot, Georgia,
    has a high unemployment rate but the number of people in poverty isn't as high as other
    states that have a higher unemployment rate. Besides a few outliers, the unemployment
    rate usually corresponds to the number of people in poverty. ")
  )

#Quinn's Page

title_content_quinn <- titlePanel("Summary Page")

intro_row <- fluidRow(column(width = 12,
                             p("Intro")))

ed_row <- fluidRow(column(width = 6,
                          h2("Effect of Education on Unemployment"),
                          tags$li("Education level and unemployment rate are
                          negatively related: the higher a group's level of
                          education, the lower their unemployment rate."),
                          tags$li("In any given year, the unemployment rate
                                  for the group with a professional degree
                                  is more than two to three times lower than
                                  for the group with just primary education."),
                          tags$li("Between 2010 and 2019, unemployment rates
                                  have fallen significantly for all levels of
                                  education.")),
                   column(width = 6,
                          dataTableOutput("quinn_education")))

race_row <- fluidRow(column(width = 6,
                            h2("Effect of Race on Unemployment"),
                            tags$li("There exists a significant level of
                                    inequality for unemployment rate in the
                                    U.S. between different races."),
                            tags$li("For example, the plot to the right
                                    shows that between 2010 and 2019, the
                                    unemployment rate for black Americans
                                    has been consistently, significantly
                                    greater than for white Americans"),
                            tags$li("While the differences in unemployment
                                    between races has decreased over the past
                                    ten years, the inequality is still nowhere
                                    near gone.")),
                     column(width = 6,
                            plotOutput("quinn_race")))

poverty_row <- fluidRow(column(width = 6,
                               h2("Effect of Systemic Unemployment on Poverty"),
                               tags$li("The maps of the U.S. to the right show
                                    the spectrum of poverty rates (top) and
                                    unemployment rate (bottom) between
                                    states for the year 2018."),
                               tags$li("As you can see, the two maps mirror
                                    each other very closely demonstrating
                                    a positive relationship between
                                    unemployment and poverty."),
                               tags$li("It also seems that states in the south
                                     tend to have a higher than average
                                    unemployment rate and poverty rate.")),
                        column(width = 6,
                               plotlyOutput("quinn_poverty_map"),
                               plotlyOutput("quinn_unemployment_map")))

summary_panel <- tabPanel(
  strong("Summary"),
  fluidPage(
    title_content_quinn,
    intro_row,
    ed_row,
    race_row,
    poverty_row
  )
)

ui <- navbarPage(
  theme = shinytheme("flatly"),
  title = strong("Unemployment"),
  includeCSS("css_final.css"),
  overview_panel,
  education_panel,
  demographic_panel,
  unemployment_panel,
  summary_panel
)
