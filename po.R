library(gtools)
library(tidyverse)

runners <- c("Jamaica", "Jamaica", "Jamaica", "USA", "Ecuador", "Netherlands", "France", "South Africa")

B <- 10000

set.seed(1)

com_prob <- function() {
  w_j <- sample(runners, size = 3, replace = FALSE)
  return(all(w_j == "Jamaica"))
  }

c <- replicate(B, com_prob())
m <- mean(c)
print(m)


entree_choices <- function(x){
  x * nrow(combinations(6,2)) * 3
}

combos <- sapply(2:12, entree_choices)

data.frame(entrees = 2:12, combos = combos) %>%
  filter(combos > 365) %>%
  min(.$entrees)