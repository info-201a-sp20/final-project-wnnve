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
}