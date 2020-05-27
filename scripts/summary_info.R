#summary info

library(dplyr)
library(readxl)

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
