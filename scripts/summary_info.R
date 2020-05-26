#summary info

library(dplyr)

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
           FIPS.Code,
           Percent.of.adults.with.less.than.a.high.school.diploma..2014.18,
           Percent.of.adults.with.a.bachelor.s.degree.or.higher..2014.18,
           PCTPOVALL_2018,
           Unemployment_rate_2018) %>% 
    filter(FIPS.Code %% 1000 != 0) %>% 
    summarise(mean_county_no_diploma_rate =
                mean(Percent.of.adults.with.less.than.a.high.school.diploma..2014.18,
                     na.rm = T),
              mean_county_bach_rate =
                mean(Percent.of.adults.with.a.bachelor.s.degree.or.higher..2014.18,
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

#new_county_summary <- get_summary_info(education_poverty_unemployment_df)
