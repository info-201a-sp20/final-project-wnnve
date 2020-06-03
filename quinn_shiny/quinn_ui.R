#Quinn UI

#Libraries
library(shiny)
library(dplyr)
library(xtable)
library(plotly)
library(ggplot2)

title_content_quinn <- titlePanel("Summary Page")

intro_row <- fluidRow(column(width = 12,
                             p("Intro")))

ed_row <- fluidRow(column(width = 6,
                          h3("Effect of Education on Unemployment"),
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
                            h3("Effect of Race on Unemployment"),
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
                            h3("Effect Unemployment on Poverty"),
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

ui <- fluidPage(
  title_content_quinn,
  intro_row,
  ed_row,
  race_row,
  poverty_row
)