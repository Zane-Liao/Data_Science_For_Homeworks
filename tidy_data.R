library(tidyverse)
library(dplyr)
library(dslabs)
d <- read_csv("times.csv")
tidy_data <- d %>%
  pivot_longer('2015':'2017', names_to = "year", values_to = "time")
tidy_data

d <- read_csv("times.csv", col_types="dcccc")
tidy_data <- d %>%
  pivot_longer(-age_group, names_to = "key", values_to = "value") %>% 
  separate(col  = key, into  = (c("year", "variable_name")), sep = "_") %>% 
  pivot_wider(names_from = variable_name, values_from = value)
d


data(co2)
head(co2)

co2_wide <- data.frame(matrix(co2, ncol = 12, byrow = TRUE)) %>% 
  setNames(1:12) %>%
  mutate(year = as.character(1959:1997))
co2_wide

co2_tidy %>% ggplot(aes(as.numeric(month), co2, color = year)) + geom_line()

library(dslabs)
data(admissions)
dat <- admissions %>% select(-applicants)
head(dat)

tmp <- admissions %>%
  pivot_longer(cols = c(admitted, applicants), names_to = "key", values_to = "value")
tmp
