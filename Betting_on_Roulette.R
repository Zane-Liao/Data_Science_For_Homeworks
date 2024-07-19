n <- 38
a <- 6
b <- -1
s <- abs(-1) / a
pockets <- c(00, 0, 1, 2, 3)
p_n <- 5
p_1 <- p_n / n
p_0 <- 1-p_1
mu_ev <- (p_1 * a) + (p_0 * b)
# solution 1
# sigma <- abs(b-a) * sqrt(p*(1-p))
sigma <- sqrt(p_1 * (a - mu_ev)^2 + p_0 * (b - mu_ev)^2)
mu_ev
m_s <- sigma/sqrt(500)
mu <- mu_ev*500
sd <- sigma*sqrt(500)
# solution 1
# pnorm(0, n*mu, sqrt(n)*sigma)
pnorm(0, mu, sd)
