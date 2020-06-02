

graph_function <- function(dataframe) {
  ggplot(data = dataframe) +
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
        size = 8, angle = 90, hjust = 1, vjust = 0.2))
}
