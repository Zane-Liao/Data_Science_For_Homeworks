library(tidyverse)
library(dslabs)
library(dplyr)
set.seed(16, sample.kind = "Rounding")
act_scores <- rnorm(10000, 20.9, 5.7)
print(act_scores)
mean(act_scores)
sd(act_scores)
v <- sum(act_scores <= 10) / sum(act_scores > 0)
print(v)
x <- 1:36
f_x <- dnorm(x, 20.9, 5.7)
data.frame(x, f_x) %>%
  ggplot(aes(x, f_x)) +
  geom_line()

z_scores <- (act_scores - mean(act_scores)) / sd(act_scores)

z <- sum(z_scores > 2) / sum(act_scores > 0)
z_x <- 20.9 + 2*5.7
print(z_x)

c <- qnorm(0.975, 20.9, 5.7)
print(c)

scores <- function(x) {
  pnorm(x, mean(act_scores), sd(act_scores))
}

sul <- sapply(x, scores)
print(sul)

cdf <- sapply(1:36, function(x){
  mean(act_scores <= x)
})
min(which(cdf >= 0.95))
n <- qnorm(0.95, 20.9, 5.7)
print(n)


p <- seq(0.01, 0.99, 0.01)
sample_quantiles <- quantile(act_scores, p)
print(sample_quantiles)
names(sample_quantiles[max(which(sample_quantiles < 26))])
theoretical_quantiles <- qnorm(p, 20.9, 5.7)

ggplot(data.frame(q = theoretical_quantiles, s = sample_quantiles), aes(x = q, y = s)) +
  geom_point() +
  geom_abline(slope = 1, intercept = 0, color = "red")


p <- seq(0.01, 0.99, 0.01)
sample_quantiles <- quantile(act_scores, p)
theoretical_quantiles <- qnorm(p, 20.9, 5.7)
qplot(theoretical_quantiles, sample_quantiles) + geom_abline()