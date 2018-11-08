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

### Plot with ggplot instead
library(ggplot2)

mu1 <- beta1 + beta2*total_NA$age_dependency_old
mu2 <- beta3 + beta4*total_NA$age_dependency_old
mu3 <- beta5 + beta6*total_NA$age_dependency_old
plotDf = data.frame(total_NA,mu1,mu2,mu3)

ggplot(plotDf, aes(x=age_dependency_old,y=health_expenditure)) + geom_point() +
    geom_line(data = plotDf, aes(x=age_dependency_old,y=mu1, colour="#000099"), show.legend = FALSE) +
    geom_errorbar(aes(ymin=mu1-sigma1, ymax=mu1+sigma1), width=.1)
ggsave('figures/Age_vs_HealthExpend.svg')

ggplot(plotDf, aes(x=age_dependency_old,y=GDP)) + geom_point() +
    geom_line(data = plotDf, aes(x=age_dependency_old,y=mu2, colour="#000099"), show.legend = FALSE) +
    geom_errorbar(aes(ymin=mu2-sigma2, ymax=mu2+sigma2), width=.1)
ggsave('figures/Age_vs_GDP-cap.svg')

ggplot(plotDf, aes(x=age_dependency_old,y=age_dependency_young)) + geom_point() +
    geom_line(data = plotDf, aes(x=age_dependency_old,y=mu3, colour="#000099"), show.legend = FALSE) +
    geom_errorbar(aes(ymin=mu3-sigma3, ymax=mu3+sigma3), width=.1)
ggsave('figures/Age_vs_AgeY.svg')

## Plot using built-in plot
png(filename="figures/Age_vs_HealthExpend.png")
plot(total_NA$age_dependency_old,total_NA$health_expenditure,col='red')
mu1 <- beta1 + beta2*total_NA$age_dependency_old
lines(total_NA$age_dependency_old,mu1,col='green')
# R doesn't have a built-in function to do standard deviations!
arrows(total_NA$age_dependency_old, mu1-sigma1, total_NA$age_dependency_old, mu1+sigma1, length=0.05, angle=90, code=3)
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
