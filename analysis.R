library("dplyr")
library("tidyr")
library("leaflet")
library("lintr")
library("ggplot2")

unemployment_vs_poverty <- read.csv("./data/Unemployement_Poverty_2016_kaggle.csv",
                              stringsAsFactors = FALSE)
# Unemployment by area
unemployment_by_area <- unemployment_vs_poverty %>%
  group_by(Area_name) %>%
  summarise(
    unemployment_rate = sum(Unemployment_rate_2016, na.rm = TRUE),
    people_in_poverty = sum(POVALL_2016, na.rm = TRUE)) %>%
  arrange(desc(unemployment_rate))

# Unemployment by state
unemployment_by_state <- unemployment_vs_poverty %>%
  group_by(State) %>%
  summarise(
    unemployment_rate = sum(Unemployment_rate_2016, na.rm = TRUE),
    people_in_poverty = sum(POVALL_2016, na.rm = TRUE)) %>%
  arrange(desc(unemployment_rate))

#GGPLOT
plot <- ggplot(data = unemployment_by_area) +
  geom_point(mapping = aes(x = unemployment_rate, y = people_in_poverty)) +
  labs(
    title = "Unemployment vs Number of People in Poverty By Area",
    x = "Unemployment Rate", y = "People in Poverty")

