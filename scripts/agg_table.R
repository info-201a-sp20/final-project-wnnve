#Agregate Table

library(dplyr)

# education_df <- read.csv("../data/education_usda.csv", stringsAsFactors = F)
# colnames(education_df)[1] <- gsub('^...', '', colnames(education_df)[1])
# 
# poverty_df <- read.csv("../data/PovertyEstimates_usda.csv", stringsAsFactors = F)
# colnames(poverty_df)[1] <- gsub('^...', '', colnames(poverty_df)[1])
# 
# unemployment_df <- read.csv("../data/Unemployment_usda.csv", stringsAsFactors = F)
# colnames(unemployment_df)[1] <- gsub('^...', '', colnames(unemployment_df)[1])
# 
# education_poverty_unemployment_df <- education_df %>% 
#   left_join(poverty_df, by = c("FIPS.Code" = "FIPStxt")) %>% 
#   left_join(unemployment_df, by = c("FIPS.Code" = "FIPStxt"))

# unemployment_kag_df <- read.csv("../data/unemployment_data_us_kaggle.csv",
#                                 stringsAsFactors = F)

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
  colnames(agg_table) <- gsub('_', ' ', colnames(agg_table))
  return(agg_table)
}

#aggregate_table <- get_agg_table(unemployment_kag_df)
