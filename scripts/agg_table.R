#Agregate Table

library(dplyr)

get_agg_table <- function(dataset) {
  agg_table <- dataset %>%
    select(Year,
           Primary_School,
           High_School,
           Associates_Degree,
           Professional_Degree) %>%
    filter(Year != 2020) %>%
    group_by(Year) %>%
    summarise(No_Diploma = mean(Primary_School,
                                                 na.rm = T),
              Only_High_School = mean(High_School,
                                                   na.rm = T),
              Some_College = mean(Associates_Degree,
                                                   na.rm = T),
              Bachelors_Degree = mean(Professional_Degree,
                                                       na.rm = T))
  colnames(agg_table) <- gsub("_", " ", colnames(agg_table))
  return(agg_table)
}
