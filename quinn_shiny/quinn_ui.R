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
                          p("column 1")),
                   column(width = 6,
                          dataTableOutput("quinn_education")))

race_row <- fluidRow(column(width = 6,
                            h3("Effect of Race on Unemployment"),
                            p("column 3")),
                     column(width = 6,
                            plotOutput("quinn_race")))

poverty_row <- fluidRow(column(width = 6,
                            h3("Effect of Systemic Unemployment on Poverty"),
                            p("column 5")),
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