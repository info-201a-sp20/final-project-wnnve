#summary info

library(dplyr)

education_df <- read.csv("../data/education_usda.csv", stringsAsFactors = F)
colnames(education_df)[1] <- gsub('^...', '', colnames(education_df)[1])

county_summary_2018 <- education_df %>% 
  select(State,
         FIPS.Code,
         Percent.of.adults.with.less.than.a.high.school.diploma..2014.18,
         Percent.of.adults.with.a.high.school.diploma.only..2014.18,
         Percent.of.adults.completing.some.college.or.associate.s.degree..2014.18,
         Percent.of.adults.with.a.bachelor.s.degree.or.higher..2014.18) %>% 
  filter(FIPS.Code %% 1000 != 0) %>% 
  summarise(mean_county_grad_rate = 100 -
            mean(Percent.of.adults.with.less.than.a.high.school.diploma..2014.18,
                 na.rm = T))
  

get_summary_info <- function(dataset) {
  
}