library(shiny)
library(tidyverse)
library(scales)
library(gridExtra)
library(ggplot2)
library(dplyr)
library(stringr)
library(plotly)
library(readxl)

unemployment_df <- read.csv("data/unemployment_data_us_kaggle.csv",
                            stringsAsFactors = FALSE)

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
df <- read.csv("data/unemployment_data_us_kaggle.csv",
               stringsAsFactors = FALSE)
df <- mutate(df, avg_unemployment = (White + Black + Asian + Hispanic) / 4)

plot_filter <- df %>%
  filter(Year != "2020") %>%
  group_by(Month)

#Quinn's data
unemployment_df_usda <- read_xls("data/Unemployment_usda.xls",
                                 range = "Unemployment Med HH Income!A8:CJ3283")
colnames(unemployment_df_usda) <- gsub(" ", "_", colnames(unemployment_df_usda))
colnames(unemployment_df_usda) <- gsub(",", "", colnames(unemployment_df_usda))

poverty_df_usda <- read_xls("data/PovertyEstimates_usda.xls",
                            range = "Poverty Data 2018!A5:AB3198")
colnames(poverty_df_usda) <- gsub(" ", "_", colnames(poverty_df_usda))
colnames(poverty_df_usda) <- gsub(",", "", colnames(poverty_df_usda))

poverty_unemployment_state <- poverty_df_usda %>%
  left_join(unemployment_df_usda, by = "FIPStxt") %>%
  filter(as.numeric(FIPStxt) %% 1000 == 0,
         Stabr.x != "US",
         Stabr.x != "PR",
         Stabr.x != "DC")

education_df_quinn <- unemployment_df %>%
  filter(Month == "Jan",
         Year != "2020") %>%
  select(Year, Primary_School, High_School,
         Associates_Degree, Professional_Degree)

#SERVER
server <- function(input, output) {

  output$plot <- renderPlotly({

    # ggplot bar
    title <- paste0("Average Unemployment Rate by Education Level Dataset")

    plot <- ggplot(data = new_df,
                   mapping = aes(x = Year, y = avg_unemployment_rate,
                                 text = paste("Year: ", Year))) +
      geom_col(mapping = aes(fill = education_level), stat = "identity") +
      theme_classic() +
      labs(title = title,
           x = "Year",
           y = "Unemployment Rate",
           fill = "Education Level") +
      scale_x_continuous(breaks = seq(2010, 2019, 1),
                         limits = range(input$year_var)) +
      scale_y_continuous(labels = function(y) paste0(y, "%"))
    return(plot)
  })

#Nicole's Page
#Graph #1
  output$demographic_plotly <- renderPlot({
    plot <-   ggplot(data = plot_filter) +
      geom_line(mapping = aes(x = reorder(Month, -avg_unemployment),
                              y = avg_unemployment,
                              color = "AVERAGE RATE", group = 1)) +
      geom_line(mapping = aes(x = Month, y = White,
                              color = "WHITE", group = 1)) +
      geom_line(mapping = aes(x = Month, y = Asian,
                              color = "ASIAN", group = 1)) +
      geom_line(mapping = aes(x = Month, y = Black,
                              color = "BLACK", group = 1)) +
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

#Graph #2
  output$select_plotly <- renderPlotly({
    plot_filter2 <- plot_filter %>%
      filter(Year == input$selectyear) %>%
      group_by(Month)
    plot_filter2$month_num <- 1:12
    plot_filter2 %>%
      arrange(month_num)

    plot3 <-
      plot_ly(data = plot_filter2) %>%
      add_trace(
        x = ~month_num,
        customdata = ~avg_unemployment,
        y = ~avg_unemployment,
        name = "Average",
        type = "scatter",
        mode = "lines+markers",
        hovertemplate = "Month: %{x}
      <br>Average: %{customdata:.1f}"
      ) %>%
      add_trace(
        x = ~month_num,
        customdata = ~White,
        y = ~White,
        name = "White",
        type = "scatter",
        mode = "lines+markers",
        hovertemplate = "Month: %{x}
      <br>White: %{customdata:.1f}"
      ) %>%
      add_trace(
        x = ~month_num,
        customdata = ~Asian,
        y = ~Asian,
        name = "Asian",
        type = "scatter",
        mode = "lines+markers",
        hovertemplate = "Month: %{x}
      <br>Asian: %{customdata:.1f}"
      ) %>%
      add_trace(
        x = ~month_num,
        customdata = ~Black,
        y = ~Black,
        name = "Black",
        type = "scatter",
        mode = "lines+markers",
        hovertemplate = "Month: %{x}
      <br>Black: %{customdata:.1f}"
      ) %>%
      add_trace(
        x = ~month_num,
        customdata = ~Hispanic,
        y = ~Hispanic,
        name = "Hispanic",
        type = "scatter",
        mode = "lines+markers",
        hovertemplate = "Month: %{x}
      <br>Hispanic: %{customdata:.1f}"
      ) %>%
      layout(
        title = "Unemployment Rate Among Race",
        yaxis = list(tickformat = "",
                     title = "Unemployment Rate (%)"),
        xaxis = list(tickformat = "",
                     title = "Month")
      )

    return(plot3)
  })

#Winnie's page

  #A visualization function
  output$interactive_graph <- renderPlotly({
    visualization <- function(dataset, region) {
      #GGPLOT
      plot <- ggplot(data = dataset) +
        geom_point(mapping = aes(x = unemployment_rate, y = people_in_poverty,
                                 text = paste("State: ", State))) +
        theme_classic() +
        labs(
          title = paste("Unemployment vs Number of People in Poverty By",
                        region),
          x = "Unemployment Rate", y = "People in Poverty (in Millions)")
      return(plot)
    }

    #Reads in CSV file
    unemployment_vs_poverty <-
      read.csv("data/Unemployement_Poverty_2016_kaggle.csv",
               stringsAsFactors = FALSE)

    #Filters the dataframe into a small dataframe by state
    unemployment_by_state <- unemployment_vs_poverty %>%
      group_by(State) %>%
      summarise(
        unemployment_rate = sum(Unemployment_rate_2016, na.rm = TRUE) / 10,
        people_in_poverty = sum(POVALL_2016, na.rm = TRUE) / 1000) %>%
      filter(unemployment_rate > input$slider2[1] &
             unemployment_rate < input$slider2[2]) %>%
      arrange(desc(unemployment_rate))

    visualization(unemployment_by_state, "State")
  })
  #The slider used to adjust the unemployment rate
  output$range <- renderPrint({
                    input$slider2
                  })

#Quinn's Page

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
                                color = "Black"),
                  size = 1) +
      geom_line(mapping = aes(x = Year,
                              y = White,
                              color = "White"),
                size = 1) +
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
    plot_ly(
      type = "choropleth",
      locations = poverty_unemployment_state$Stabr.x,
      locationmode = "USA-states",
      colorscale = "Viridis",
      z = poverty_unemployment_state$PCTPOVALL_2018) %>%
      colorbar(title = "Poverty Rate") %>%
      layout(geo = list(scope = "usa"))
  })

  output$quinn_unemployment_map <- renderPlotly({
    plot_ly(
      type = "choropleth",
      locations = poverty_unemployment_state$Stabr.x,
      locationmode = "USA-states",
      colorscale = "Hot",
      z = poverty_unemployment_state$Unemployment_rate_2018) %>%
      colorbar(title = "Unemployment Rate") %>%
      layout(geo = list(scope = "usa"))
  })
}