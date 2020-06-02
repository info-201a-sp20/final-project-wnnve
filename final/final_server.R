library(shiny)
library(tidyverse)
library(scales)
library(gridExtra)
library(ggplot2)
library(dplyr)
library(stringr)
library(plotly)

unemployment_df <- read.csv("../data/unemployment_data_us_kaggle.csv", stringsAsFactors = FALSE)

df_1 <- unemployment_df %>%
  group_by(Year) %>%
  summarize(avg_unemployment_rate = mean(Primary_School, na.rm = T)) %>%
  mutate(education_level = "Primary School")

df_2 <- unemployment_df %>%
  group_by(Year) %>%
  summarize(avg_unemployment_rate = mean(High_School, na.rm = T)) %>%
  mutate(education_level = "High School")

df_3 <- unemployment_df %>%
  group_by(Year) %>%
  summarize(avg_unemployment_rate = mean(Associates_Degree, na.rm = T)) %>%
  mutate(education_level = "Associates Degree")

df_4 <- unemployment_df %>%
  group_by(Year) %>%
  summarize(avg_unemployment_rate = mean(Professional_Degree, na.rm = T)) %>%
  mutate(education_level = "Professional Degree")

summary <- rbind(df_1, df_2, df_3, df_4)

new_df <- summary %>%
  filter(Year != "2020")

#Nicole's data
df <- read.csv("../data/unemployment_data_us_kaggle.csv", stringsAsFactors = FALSE)
df <- mutate(df, avg_unemployment = (White + Black + Asian + Hispanic) / 4)

plot_filter <- df %>%
  filter(Year != "2020") %>%
  group_by(Month) 

#SERVER 
server <- function(input, output) {

  output$plot <- renderPlot({
    
    # ggplot bar
    title <- paste0("Average Unemployment Rate by Education Level Dataset")
    
    plot <- ggplot(data = new_df,
                   mapping = aes(x = Year, y = avg_unemployment_rate)) +
      geom_col(mapping = aes(fill = education_level), stat = "identity") +
      labs(title = title,
           x = "Year",
           y = "Unemployment Rate",
           fill = "Education Level") +
      scale_x_continuous(breaks = seq(2010, 2019, 1), limits = range(input$year_var)) +
      scale_y_continuous(labels = function(y) paste0(y, "%"))
    return(plot)
  })
 
  #Nicole's Graph 
  output$demographic_plotly <- renderPlot({
    plot <-   ggplot(data = plot_filter) +
      geom_line(mapping = aes(x = reorder(Month, -avg_unemployment),
                              y = avg_unemployment, color = "AVERAGE RATE", group = 1)) +
      geom_line(mapping = aes(x = Month, y = White, color = "WHITE", group = 1)) +
      geom_line(mapping = aes(x = Month, y = Asian, color = "ASIAN", group = 1)) +
      geom_line(mapping = aes(x = Month, y = Black, color = "BLACK", group = 1)) +
      geom_line(mapping = aes(x = Month,
                              y = Hispanic, color = "HISPANIC", group = 1)) +
      facet_wrap(~Year) +
      theme_classic() +
      labs(x = "Month", y = "Unemployment Rate", colour = "Race") +
      ggtitle("Unemployment Rate Among Race Between 2010 - 2019") +
      theme(
        axis.text.x = element_text(
          size = 8, angle = 90, hjust = 1, vjust = 0.2)
      )
    return(plot)
  }) 
  
  output$select_plotly <- renderPlot({
    plot_filter2 <- plot_filter %>%
      filter(Year == input$selectyear) 
    
    plot2 <-   ggplot(data = plot_filter2) +
      geom_line(mapping = aes(x = Month,
                              y = avg_unemployment, color = "AVERAGE RATE", group = 1)) +
      geom_line(mapping = aes(x = Month, y = White, color = "WHITE", group = 1)) +
      geom_line(mapping = aes(x = Month, y = Asian, color = "ASIAN", group = 1)) +
      geom_line(mapping = aes(x = Month, y = Black, color = "BLACK", group = 1)) +
      geom_line(mapping = aes(x = Month,
                              y = Hispanic, color = "HISPANIC", group = 1)) +
      theme_classic() +
      labs(x = "Month", y = "Unemployment Rate", colour = "Race") +
      ggtitle("Unemployment Rate Among Race") +
      theme(
        axis.text.x = element_text(
          size = 8, angle = 90, hjust = 1, vjust = 0.2)
      )
    return(plot2)
  }) 
  
  #Winnie's page
  output$interactive_graph <- renderPlotly({
    visualization <- function(dataset, region) {
      #GGPLOT
      plot <- ggplot(data = dataset) +
        geom_point(mapping = aes(x = unemployment_rate, y = people_in_poverty, 
                                 text = paste("State: ", State))) +
        labs(
          title = paste("Unemployment vs Number of People in Poverty By", region),
          x = "Unemployment Rate", y = "People in Poverty (in Millions)")
      return(plot)
    }
    
    unemployment_vs_poverty <- 
      read.csv("../data/Unemployement_Poverty_2016_kaggle.csv",
               stringsAsFactors = FALSE)
    
    unemployment_by_state <- unemployment_vs_poverty %>%
      group_by(State) %>%
      summarise(
        unemployment_rate = sum(Unemployment_rate_2016, na.rm = TRUE) / 10,
        people_in_poverty = sum(POVALL_2016, na.rm = TRUE) / 1000) %>%
      filter(unemployment_rate > input$slider2[1] & unemployment_rate < input$slider2[2]) %>%
      arrange(desc(unemployment_rate))
    
    visualization(unemployment_by_state, "State")
  })
  
  output$range <- renderPrint({input$slider2})
}


