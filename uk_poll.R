# suggested libraries and options
library(tidyverse)
options(digits = 3)

# load brexit_polls object
library(dslabs)
data(brexit_polls)

p <- 0.481    # official proportion voting "Remain"
d <- 2*p-1    # official spread

N <- 1500


library(tidyverse)
library(dslabs)
data(brexit_polls)

brexit_polls <- brexit_polls %>%
  mutate(x_hat = (spread + 1) / 2)

mean_spread <- mean(brexit_polls$spread)
print(mean_spread)

sd_spread <- sd(brexit_polls$spread)
print(sd_spread)

mean_x_hat <- mean(brexit_polls$x_hat)
print(mean_x_hat)

sd_x_hat <- sd(brexit_polls$x_hat)
print(sd_x_hat)

