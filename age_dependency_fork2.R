library(rjags)

# Normalized datasets
age_dep_o <- total_NA$age_dependency_old
health_exp <- total_NA$health_expenditure
GDP_cap <- total_NA$GDP_per_capita
age_dep_y <- total_NA$age_dependency_young
n <- nrow(total_NA)

# JAGS Little Language
model_string <- "model{

# Likelihood
for(i in 1:n){
mu1[i] <- beta1 + beta2*age_dep_o[i] 
mu2[i] <- beta3 + beta4*age_dep_o[i] 
mu3[i] <- beta5 + beta6*age_dep_o[i]
health_exp[i]   ~ dnorm(mu1[i],inv.var1)
GDP_cap[i]   ~ dnorm(mu2[i],inv.var2)
age_dep_y[i]   ~ dnorm(mu3[i],inv.var3)
}

# Prior for beta
beta1 ~ dnorm(0,0.01)
beta2 ~ dnorm(0,0.01)
beta3 ~ dnorm(0,0.01)
beta4 ~ dnorm(0,0.01)
beta5 ~ dnorm(0,0.01)
beta6 ~ dnorm(0,0.01)

# Prior for the inverse variance
var1   ~ dunif(0.01, 0.99)
var2   ~ dunif(0.01, 0.99)
var3   ~ dunif(0.01, 0.99)
var4   ~ dunif(0.01, 0.99)
var5   ~ dunif(0.01, 0.99)
var6   ~ dunif(0.01, 0.99)
inv.var1   <- 1/var1
inv.var2   <- 1/var2
inv.var3   <- 1/var3
inv.var4   <- 1/var4
inv.var5   <- 1/var5
inv.var6   <- 1/var6
sigma1     <- sqrt(var1)
sigma2     <- sqrt(var2)
sigma3     <- sqrt(var3)
sigma4     <- sqrt(var4)
sigma5     <- sqrt(var5)
sigma6     <- sqrt(var6)
}"

model <- jags.model(textConnection(model_string), data = list(age_dep_o=age_dep_o, health_exp=health_exp, GDP_cap=GDP_cap, age_dep_y=age_dep_y, n=n), n.chains = 4)

update(model, 10000, progress.bar="none"); # Burn-in for 10000 samples

samp <- coda.samples(model, 
                     variable.names=c("beta1","beta2","beta3", "beta4","beta5","beta6", "sigma1", "sigma2", "sigma3", "sigma4", "sigma5", "sigma6"), 
                     n.iter=20000, progress.bar="text")

summary(samp)

saveRDS(samp, "age_dependency_fork.RDS")
