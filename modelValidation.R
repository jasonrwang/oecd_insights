### This script takes the model outputs from `age_dependency_fork.RDS` and plots them against the original data

# samp = readRDS('try_to_clean_up/fork.RDS') # This doesn't work for some reason

output = summary(samp)$statistics

# extract just the means
beta1 = output[1,1]
beta2 = output[2,1]
beta3 = output[3,1]
beta4 = output[4,1]
beta5 = output[5,1]
beta6 = output[6,1]
sigma1 = output[7,1] # SD for mu1
sigma2 = output[8,1] # SD for mu2
sigma3 = output[9,1] # SD for mu3

## The below code could be improved significantly by using some kinda of looping logic...
# for (i in 1:dim(total_NA)) {
#    selected
# }

png(filename="figures/Age_vs_HealthExpend.png")
plot(total_NA$age_dependency_old,total_NA$health_expenditure,col='red')
mu1 <- beta1 + beta2*total_NA$age_dependency_old
lines(total_NA$age_dependency_old,mu1,col='green')
dev.off()

png(filename="figures/Age_vs_GDP-cap.png")
plot(total_NA$age_dependency_old,total_NA$GDP,col='red')
mu2 <- beta3 + beta4*total_NA$age_dependency_old
lines(total_NA$age_dependency_old,mu2,col='green')
dev.off()

png(filename="figures/Age_vs_AgeY.png")
plot(total_NA$age_dependency_old,total_NA$age_dependency_young,col='red')
mu3 <- beta5 + beta6*total_NA$age_dependency_old
lines(total_NA$age_dependency_old,mu3,col='green')
dev.off()
