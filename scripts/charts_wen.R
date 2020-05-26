library(tidyverse)
library(scales)
library(gridExtra)
library(ggplot2)
library(dplyr)
library(stringr)

stacked_bar_chart <- function(dataset) {
  #GGPLOT
  plot <- ggplot(data = dataset, mapping = aes(x = Year, y = avg_unemployment_rate)) +
    geom_bar(mapping = aes(fill = education_level), stat = "identity") +
    labs(title = "Average Unemployment Rate through time by Education Level",
         x = "Year",
         y = "Unemployment Rate",
         fill = "Education Level") +
    scale_x_continuous(breaks = seq(2010, 2019, 1)) +
    scale_y_continuous(labels = function(y) paste0(y, "%"))
  return(plot)
}
