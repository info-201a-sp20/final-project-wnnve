#Quinn Server

#Libraries
library(shiny)
library(dplyr)
library(ggplot2)
library(readxl)
library(plotly)

#Data files
unemployment_df <- read.csv("../data/unemployment_data_us_kaggle.csv")

unemployment_df_usda <- read_xls("../data/Unemployment_usda.xls", range = "Unemployment Med HH Income!A8:CJ3283")
colnames(unemployment_df) <- gsub(' ', '_', colnames(unemployment_df))
colnames(unemployment_df) <- gsub(',', '', colnames(unemployment_df))

poverty_df_usda <- read_xls("../data/PovertyEstimates_usda.xls", range = "Poverty Data 2018!A5:AB3198")
colnames(poverty_df) <- gsub(' ', '_', colnames(poverty_df))
colnames(poverty_df) <- gsub(',', '', colnames(poverty_df))

poverty_unemployment_state <- poverty_df_usda %>% 
  left_join(unemployment_df_usda, by = "FIPStxt") %>% 
  filter(as.numeric(FIPStxt) %% 1000 == 0,
         Stabr.x != "US",
         Stabr.x != "PR",
         Stabr.x != "DC")

education_df_quinn <- unemployment_df %>% 
  filter(Month == "Jan",
         Year != "2020") %>% 
  select(Year, Primary_School, High_School, Associates_Degree, Professional_Degree)

#Server Function
server <- function(input, output){
  
  #Race Plot
  output$quinn_race <- renderPlot({
    #data manipulation
    race_df <- unemployment_df %>% 
      select(Year, Month, White, Black) %>% 
      filter(Month == "Jan",
             Year != "2020")
    
    #Line/Scatter Plot
    g <- ggplot(data = race_df)
    g + geom_line(mapping = aes(x = Year,
                                y = Black,
                                color = "Black")) +
      geom_line(mapping = aes(x = Year,
                              y = White,
                              color = "White")) +
      scale_x_continuous(breaks = c(seq(2010, 2019, 2))) +
      theme_classic() +
      labs(title = "Unemployment vs. Year",
           y = "Unemployment Rate",
           color = "Race")
  })
  
  #Education Table
  output$quinn_education <- renderDataTable(
    education_df_quinn,
    options = list(searching = FALSE,
                   scrollX = TRUE)
  )
  
  #Poverty Plot
  output$quinn_poverty_map <- renderPlotly({
    plot_ly (
      type = "choropleth" ,
      locations = poverty_unemployment_state$Stabr.x ,
      locationmode = "USA-states" ,
      colorscale = "Viridis" ,
      z = poverty_unemployment_state$PCTPOVALL_2018) %>%
      colorbar(title = "Poverty Rate") %>% 
      layout ( geo = list ( scope = "usa" ))
  })
  
  output$quinn_unemployment_map <- renderPlotly({
    plot_ly (
      type = "choropleth" ,
      locations = poverty_unemployment_state$Stabr.x ,
      locationmode = "USA-states" ,
      colorscale = "Hot" ,
      z = poverty_unemployment_state$Unemployment_rate_2018) %>%
      colorbar(title = "Unemployment Rate") %>% 
      layout ( geo = list ( scope = "usa" ))
  })
}