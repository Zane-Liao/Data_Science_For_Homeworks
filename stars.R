library(tidyverse)
library(dplyr)
library(dslabs)
data(stars)
options(digits = 3)   # report 3 significant digits
#w <- subset( stars, !grepl("^D", type) & (temp < 4000))
#c <- mean(w$temp)
#print(c)
ggplot(stars, aes(x = temp, y = magnitude)) +
  geom_point(alpha = 0.5) +
  facet_wrap(~type) +
  geom_label(aes(label = star), vjust = -0.5)
  scale_y_reverse() +
  scale_x_reverse(trans = "log10")

# white dwarfs numbers
w <- stars %>% filter(grepl("^D", type))


