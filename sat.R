p <- 1/5 # one correct choice of 5 options
a <- 1
b <- -0.25
mu <- a*p + b*(1-p)
n <- 44
n*mu
sigma <- sqrt(n) * abs(b-a) * sqrt(p*(1-p))
1-pnorm(8, mu, sigma)

set.seed(21, sample.kind = "Rounding")
# solution 1
# scores <- numeric(n)
# 
# B <- 10000
# r_sat <- function(){
#   X <- sample(c(-0.25, 1), n, replace = TRUE, prob = c(1 - p, p))
#   scores <- sum(X)
# }
# 
# m <- replicate(B, r_sat())
# mean(m >= 8)

# solution 2

B <- 10000
r_sat <- replicate(B, {
  X <- sample(c(-0.25, 1), n, replace = TRUE, prob = c(1 - p, p))
  sum(X)
})
mean(r_sat >= 8)

# The SAT was recently changed to reduce the number of multiple choice options 
# from 5 to 4 and also to eliminate the penalty for guessing.
p <- 1/4 # one correct choice of 4 options
a <- 1
b <- 0
mu <- a*p + b*(1-p)
print(mu)
n <- 44
n*mu

p <- seq(0.25, 0.95, 0.05)
set.seed(21, sample.kind = "Rounding")
B <- 10000
n <- 44
p <- 0.25
tests <- replicate(B, {
  X <- sample(c(1, 0), n, replace = TRUE, prob = c(p, 1-p))
  sum(X)
})
mean(tests >= 30)

# solution 
# What is the lowest p such that the probability of 
# scoring over 35 exceeds 80%?
p <- seq(0.25, 0.95, 0.05)
exp_val <- sapply(p, function(x){
  mu <- n * a*x + b*(1-x)
  sigma <- sqrt(n) * abs(b-a) * sqrt(x*(1-x))
  1-pnorm(35, mu, sigma)
})

min(p[which(exp_val > 0.8)])
