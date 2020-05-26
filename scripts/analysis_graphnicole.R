#Load packages
library("ggplot2")
library("dplyr")
library("tidyr")
library("stringr")


#load data set

df <- read.csv("../data/unemployment_data_us_kaggle.csv", stringsAsFactors = FALSE)
View(df)

#add average unemployment column
df <- mutate(df, avg_unemployment = (White + Black + Asian + Hispanic) / 4)

#filter data
plot_filter2 <- df %>%
  filter(Year != "2020") %>%
  group_by(Month) %>%
  arrange(Year) %>%
  select(Year, Month, White, Black, Asian, Hispanic, avg_unemployment)

plot_filter2$month_num <- 1:12
View(plot_filter2)

# To be included in the Markdown!!

graph_function <- function(dataframe) {
  
  ggplot(data = dataframe) +
    geom_line(mapping = aes(x = month_num, y = avg_unemployment, color = "AVERAGE RATE", group = 1)) +
    geom_line(mapping = aes(x = month_num, y = White, color = "WHITE", group = 1)) +
    geom_line(mapping = aes(x = month_num, y = Asian, color = "ASIAN", group = 1)) +
    geom_line(mapping = aes(x = month_num, y = Black, color = "BLACK", group = 1)) +
    geom_line(mapping = aes(x = month_num, y = Hispanic, color = "HISPANIC", group = 1)) +
    facet_wrap(~Year) +
    theme_classic() +
    labs(x = "Month", y = "Unemployment Rate", colour = "Race") +
    ggtitle("Unemployment Rate Among Race Between 2010 - 2019") +
    scale_x_continuous(breaks = seq(0, 12, 1)) 
}

test <- graph_function(plot_filter2)

z <- ggplot(data = plot_filter2) +
  geom_line(mapping = aes(x = month_num, y = avg_unemployment, color = "AVERAGE RATE", group = 1)) +
  geom_line(mapping = aes(x = month_num, y = White, color = "WHITE", group = 1)) +
  geom_line(mapping = aes(x = month_num, y = Asian, color = "ASIAN", group = 1)) +
  geom_line(mapping = aes(x = month_num, y = Black, color = "BLACK", group = 1)) +
  geom_line(mapping = aes(x = month_num, y = Hispanic, color = "HISPANIC", group = 1)) +
  facet_wrap(~Year) +
  theme_classic() +
  labs(x = "Month", y = "Unemployment Rate", colour = "Race") +
  ggtitle("Unemployment Rate Among Race Between 2010 - 2019") +
  scale_x_continuous(breaks = seq(0, 12, 1))

