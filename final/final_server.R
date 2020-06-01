library(shiny)
library(tidyverse)
library(scales)
library(gridExtra)
library(ggplot2)
library(dplyr)
library(stringr)

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
}
