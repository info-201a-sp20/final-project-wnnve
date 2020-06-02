df <- read.csv("../data/unemployment_data_us_kaggle.csv", stringsAsFactors = FALSE)
df <- mutate(df, avg_unemployment = (White + Black + Asian + Hispanic) / 4)

plot_filter <- df %>%
  filter(Year != "2020") %>%
  group_by(Month) 

server <- function(input, output){
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
 
    
}