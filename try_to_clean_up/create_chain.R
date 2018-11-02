library(rjags)

age_dep_o <- data$age_dependency_old
gdp <- data$GDP
hou_com <- data$household_consumption
n <- nrow(data)

# log-odds trick
# converts proportion to ratio scale
# urb <- log(urb/(1-urb))

# standardize variables
# bbnd <- (bbnd-mean(bbnd))/sd(bbnd)
# pop <- (pop-mean(pop))/sd(pop)
# gdp <- (gdp-mean(gdp))/sd(gdp)

# JAGS Little Language
model_string <- "model{

# Likelihood
for(i in 1:n){
mu2[i] <- beta2 + beta3*hou_com[i]
mu1[i] <- beta1 + mu2[i]*gdp[i]
GDP[i]   ~ dnorm(mu1[i],inv.var0)
age_dep_o[i] ~ dnorm(mu1[i],inv.var0)
}

# Prior for beta
beta1 ~ dnorm(0,inv.var1)
beta2 ~ dnorm(0,inv.var2)
beta3 ~ dnorm(0,inv.var3)

# Prior for the inverse variance
var0   ~ dunif(0.01,0.99)
var1   ~ dunif(0.01,0.99)
var2   ~ dunif(0.01,0.99)
var3   ~ dunif(0.01,0.99)
inv.var0 <- 1/var0
inv.var1 <- 1/var1
inv.var2 <- 1/var2
inv.var3 <- 1/var3
sigma0     <- sqrt(var0)
sigma1     <- sqrt(var1)
sigma2     <- sqrt(var2)
sigma3     <- sqrt(var3)
}"


model <- jags.model(textConnection(model_string), data = list(age_dep_o=age_dep_o,gdp=gdp,hou_com=hou_com,n=n))

update(model, 10000, progress.bar="none"); # Burn-in for 10000 samples

samp <- coda.samples(model,
                     variable.names=c("beta1","beta2","beta3", "sigma0", "sigma1", "sigma2", "sigma3"),
                     n.iter=20000, progress.bar="text")

summary(samp)

saveRDS(samp, "chain.RDS")
