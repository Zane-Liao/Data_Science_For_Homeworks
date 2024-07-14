library(tidyverse)
library(dplyr)
nrow(esoph)
all_cases <- esoph$ncases
sum(all_cases)
all_controls <- esoph$ncontrols
sum(all_controls)
all_alcgp <- esoph$alcgp
high_gegp <- filter(esoph, all_alcgp == "0-39g/day")
high_gegp
h_cases <- sum(high_gegp$ncases)
h_ncontrols <- sum(high_gegp$ncontrols)
p_high <- h_cases / (h_cases + h_ncontrols)
print(p_high)

esoph %>%
  filter(alcgp == "0-39g/day") %>%
  summarise(ncases = sum(ncases), ncontrols = sum(ncontrols)) %>%
  mutate(p_cases = ncases / (ncases + ncontrols)) %>%
  pull(p_cases)

n_t <- esoph %>% filter(tobgp != "0-9g/day") %>%
  summarise(n_cases = sum(ncases), n_controls = sum(ncontrols)) %>%
  mutate(t_cases = n_cases + n_controls) %>%
  pull(t_cases)
n_c <- sum(esoph$ncases + esoph$ncontrols)
print(n_c)
su <- n_t / n_c
print(su)

p_h <- esoph %>%
  filter(alcgp == "120+" | tobgp == "30+") %>%
  summarise(n_cases = sum(ncases)) %>%
  pull(n_cases)

c_h <- p_h / sum(esoph$ncases)
print(c_h)

g_h <- esoph %>%
  filter(alcgp == "120+" | tobgp == "30+") %>%
  summarise(n_ncontrols = sum(ncontrols)) %>%
  pull(n_ncontrols)

g_h <- g_h / sum(esoph$ncontrols)
print(g_h)
print(c_h / g_h)