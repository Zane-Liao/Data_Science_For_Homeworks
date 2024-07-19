library(tidyverse)
library(dslabs)
data(death_prob)
head(death_prob)

a <- -150000
b <- 1150
n <- 1000
p <- death_prob %>% filter(sex == "Female" & age == "50" ) %>%
  pull(prob)

print(p)
p_0 <- 1 - p
mu <- (p * a) + (p_0 * b)
mu
sigma <- abs(b - a) * sqrt(p*(1 - p))
sigma

mu*n
sigma*sqrt(n)
pnorm(0, mu*n, sigma*sqrt(n))

p_m <- death_prob %>% filter(sex == "Male"& age == "50") %>%
  pull(prob)
print(p_m)

a <- 150000
n <- 1000
S <- 700000

# solution 1
# p <- p_m
# mu_sum <- 700000
# n <- 1000
# a <- -150000
# b <- (mu_sum/n-a*p)/(1-p)
mu_male <-  (700000 / n)
b <- ((p_m * a) + mu_male) / (1 - p_m)

# solution 1
# sigma_sum <- sqrt(n)*abs(b-(-a))*sqrt(p_m*(1-p_m))
# sigma_sum
sigma <- abs(b - (-a)) * sqrt(p_m*(1 - p_m))
sigma*sqrt(n)

pnorm(0, mu_male*n, sigma*sqrt(n))


# ---------------------------------------------------

a <- -150000
b <- 1150
n <- 1000
p <- 0.015
p_0 <- 1 - p

mu <- (p * a) + (p_0 * b)
mu*n
sigma <- abs(b - a) * sqrt(p*(1 - p))
sigma*sqrt(n)

pnorm(0, mu*n, sigma*sqrt(n))
pnorm(-1000000, mu*n, sigma*sqrt(n))

p <- seq(.01, .03, .001)
exp_val <- sapply(p, function(x){
  mu <- n * a*x + b*(1-x)
  sigma <- sqrt(n) * abs(b-a) * sqrt(x*(1-x))
  pnorm(0, mu, sigma)
})

min(p[which(exp_val > 0.9)])

p_lose_million <- sapply(p, function(p){
  exp_val <- n*(a*p + b*(1-p))
  se <- sqrt(n) * abs(b-a) * sqrt(p*(1-p))
  pnorm(-1*10^6, exp_val, se)
})

data.frame(p, p_lose_million) %>%
  filter(p_lose_million > 0.9) %>%
  pull(p) %>%
  min()

p_loss <- .015
a <- -150000
b <- 1150
n <- 1000
set.seed(25, sample.kind = "Rounding")
defaults <- sample(c(a, b), n, replace=TRUE, prob=c(p_loss, 1-p_loss))
defaults
profit <- sum(defaults) / (1*10^6)
profit

# solution 1
# B <- 10000
# 
# profits <- replicate(B, {
#   outcomes <- sample(c(loss, profit), n, prob = c(p, 1-p), replace = TRUE)
#   sum(outcomes)/10^6
# })
# 
# mean(profits < -1)
set.seed(27, sample.kind = "Rounding")
B <- 10000
losses <- replicate(B, {
  defaults <- sample(c(a, b), n, replace=TRUE, prob=c(p_loss, 1-p_loss))
  sum(defaults)
})
mean(losses < -1000000)
mean(losses)

# -------------------------------------------------------

p <- 0.015
n <- 1000
l <- -150000
p_loss <- 0.05

z <- qnorm(.05)
x <- -l*( n*p - z*sqrt(n*p*(1-p)))/ ( n*(1-p) + z*sqrt(n*p*(1-p)))
x

mu <- (l*p + x*(1-p))
mu*n

B <- 10000
set.seed(28, sample.kind = "Rounding")
q <- replicate(B, {
  default <- sample(c(l, x), n, replace=TRUE, prob=c(p, 1-p))
  sum(default)
})
mean(q < 0)

set.seed(29, sample.kind = "Rounding")
profit <- replicate(B, {
  new_p <- p + sample(seq(-0.01, 0.01, length = 100), 1)
  draws <- sample(c(x, l), n, 
                  prob=c(1-new_p, new_p), replace = TRUE) 
  sum(draws)
})
mean(profit)
mean(profit < -1000000)
