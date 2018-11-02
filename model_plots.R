library(rjags)
samp=readRDS("age_dependency_fork.RDS")

summary(samp)
traceplot(samp)

# sometimes the gelman plot won't fit on a screen
# we havve to reduce the margins
par(mar=c(.4,.4,.4,.4))
gelman.plot(samp)
gelman.diag(samp)
densplot(samp)
acfplot(samp)

# get the effective sample size
effectiveSize(samp)
