library("dplyr")
library("tidyr")
library("leaflet")
library("lintr")
library("ggplot2")

visualization <- function(dataset, region) {
  #GGPLOT
  plot <- ggplot(data = dataset) +
    geom_point(mapping = aes(x = unemployment_rate, y = people_in_poverty)) +
    labs(
      title = paste("Unemployment vs Number of People in Poverty By", region),
      x = "Unemployment", y = "People in Poverty")
  return(plot)
}