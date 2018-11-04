## Main file to call other scripts from! This will keep our code modular :)

source('scripts/getdata.R')
indicatorData = getdata()

# Run `Normalize_scatterplot.R` to get total_NA
# Run `reshape_data.R`
# Run `age_dependency_fork2.R` to run the JAGS fork model and make `age_dependency_fork.RDS`
# Then, run `modelValidation.R` to see how well the model fits back against the original data