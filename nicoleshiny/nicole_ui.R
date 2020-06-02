ui <- fluidPage(
  h1("Figure 3"), 
  h2("Unemployment Demographics"),
  plotOutput(
    outputId = "demographic_plotly"
  ),
  p("This chart reveals that among black, white, hispanic, 
    and asian people, black people had a higher unemployment 
    rate from 2010 - 2019. The green/yellow line shows the average 
    unemployment rate and this allows us to see that asian 
    and white people are below the average unemployment rate 
    while hispanic people are close to average and black people 
    are above average. This graph creates a visualization to see 
    how unemployment rates were widespread in 2010, but overtime, have 
    decreased and have become slightly more uniform. However, black 
    people still have the highest rate of unemployment and 
    disparities are still present."),
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
  ),
  plotlyOutput(
    outputId = "select_plotly"
  )
)