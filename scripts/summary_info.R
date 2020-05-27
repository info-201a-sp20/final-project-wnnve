#summary info

library(dplyr)
library(readxl)

# education_df <- read_xls("../data/education_usda.xls", range = "Education 1970 to 2018!A5:AU3288")
# colnames(education_df) <- gsub(' ', '_', colnames(education_df))
# colnames(education_df) <- gsub(',', '', colnames(education_df))
# colnames(education_df) <- gsub("'", '', colnames(education_df))
# colnames(education_df) <- gsub('-', '_', colnames(education_df))
# 
# poverty_df <- read_xls("../data/PovertyEstimates_usda.xls", range = "Poverty Data 2018!A5:AB3198")
# colnames(poverty_df) <- gsub(' ', '_', colnames(poverty_df))
# colnames(poverty_df) <- gsub(',', '', colnames(poverty_df))
# 
# unemployment_df <- read_xls("../data/Unemployment_usda.xls", range = "Unemployment Med HH Income!A8:CJ3283")
# colnames(unemployment_df) <- gsub(' ', '_', colnames(unemployment_df))
# colnames(unemployment_df) <- gsub(',', '', colnames(unemployment_df))
# 
# education_pov_unemployment_df <- education_df %>%
#   left_join(poverty_df, by = c("FIPS_Code" = "FIPStxt")) %>%
#   left_join(unemployment_df, by = c("FIPS_Code" = "FIPStxt"))

#education_df <- read.csv("../data/education_usda.csv", stringsAsFactors = F)
#colnames(education_df)[1] <- gsub('^...', '', colnames(education_df)[1])

#poverty_df <- read.csv("../data/PovertyEstimates_usda.csv")
#colnames(poverty_df)[1] <- gsub('^...', '', colnames(poverty_df)[1])

#unemployment_df <- read.csv("../data/Unemployment_usda.csv")
#colnames(unemployment_df)[1] <- gsub('^...', '', colnames(unemployment_df)[1])

#education_poverty_unemployment_df <- education_df %>% 
 # left_join(poverty_df, by = c("FIPS.Code" = "FIPStxt")) %>% 
  #left_join(unemployment_df, by = c("FIPS.Code" = "FIPStxt"))

  
#Takes in the specific dataframe education_poverty_unemployment_df
#And returns a list of county level summary information from 2018
get_summary_info <- function(dataset) {
  summary_list <- dataset %>% 
    select(State,
           FIPS_Code,
           Percent_of_adults_with_less_than_a_high_school_diploma_2014_18,
           Percent_of_adults_with_a_bachelors_degree_or_higher_2014_18,
           PCTPOVALL_2018,
           Unemployment_rate_2018) %>% 
    filter(as.numeric(FIPS_Code) %% 1000 != 0) %>% 
    summarise(mean_county_no_diploma_rate =
                mean(Percent_of_adults_with_less_than_a_high_school_diploma_2014_18,
                     na.rm = T),
              mean_county_bach_rate =
                mean(Percent_of_adults_with_a_bachelors_degree_or_higher_2014_18,
                     na.rm = T),
              mean_county_unemployment =
                mean(Unemployment_rate_2018,
                     na.rm = T),
              mean_pov_rate =
                mean(PCTPOVALL_2018,
                     na.rm = T),
              min_pov_rate =
                min(PCTPOVALL_2018,
                    na.rm = T),
              max_pov_rate =
                max(PCTPOVALL_2018,
                    na.rm = T)) %>% 
    as.list()
  
  return(summary_list)
}

#new_county_summary <- get_summary_info(education_pov_unemployment_df)
