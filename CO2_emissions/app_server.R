library(dplyr)
co2_emissions <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

#   What is the average value of my variable across all the counties (in the current year)?
co2_average <- co2_emissions %>% filter(year == 2021) %>% 
  summarise(co2 = mean(co2, na.rm = TRUE)) %>% pull(co2)
print(co2_average)


#   Where is my variable the highest / lowest?
co2_highest <- co2_emissions %>% filter(co2 == max(co2, na.rm = TRUE)) %>%
  pull(country) 
print(co2_highest)

#   How much has my variable change over the last N years?
co2_difference_function <- function(n) {
  co2_difference <- co2_emissions %>% group_by(year) %>% summarise(co2 = mean(co2, na.rm = TRUE)) %>% 
    filter(year >= (2021 - (n - 1)))
  return(co2_difference)
}

print(co2_difference_function(3))
