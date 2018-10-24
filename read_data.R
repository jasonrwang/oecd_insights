data_frames <- c(age_dependency_old,age_dependency_young,age_dependency_ratio,GDP,health_expenditure_capita,health_expenditure,household_consumption)
header_names <- c('Country_Name', 'Country_Code', 'Indicator_Name','Indicator_Code',1960:2017)

age_dependency_old <- read.csv("data/Age_dependency_old(working_age_population).csv",sep=',',header=TRUE,)
# https://data.worldbank.org/indicator/SP.POP.DPND
age_dependency_young <- read.csv("data/Age_dependency_young(working_age_population).csv",sep=',',header=TRUE)
# https://data.worldbank.org/indicator/SP.POP.DPND.YG
age_dependency_ratio <- read.csv("data/Age_dependency_ratio(working_age_population).csv",sep=',',header=TRUE)
# https://data.worldbank.org/indicator/SP.POP.DPND.OL
GDP <- read.csv("data/GDP(US).csv",sep=',',header=TRUE)
# https://data.worldbank.org/indicator/NY.GDP.MKTP.CD
health_expenditure_capita <- read.csv("data/Health_expenditure_capita(US).csv",sep=',',header=TRUE)
# https://data.worldbank.org/indicator/SH.XPD.EHEX.PC.CD
health_expenditure <- read.csv("data/Health_expenditure(GDP).csv",sep=',',header=TRUE)
# https://data.worldbank.org/indicator/SH.XPD.CHEX.GD.ZS
household_consumption <- read.csv("data/Household_consumption(US).csv",sep=',',header=TRUE)
# https://data.worldbank.org/indicator/NE.CON.PRVT.CD
country_names <- read.csv("data/Metadata_Country.csv",sep=',',header=TRUE)

# doesn't work from list for some reason
age[length(age_dependency_old)] <- NULL
colnames(age_dependency_old) <- header_names

age_dependency_young[length(age_dependency_young)] <- NULL
colnames(age_dependency_young) <- header_names

age_dependency_ratio[length(age_dependency_ratio)] <- NULL
colnames(age_dependency_ratio) <- header_names

GDP[length(GDP)] <- NULL
colnames(GDP) <- header_names

health_expenditure_capita[length(health_expenditure_capita)] <- NULL
colnames(health_expenditure_capita) <- header_names

health_expenditure[length(health_expenditure)] <- NULL
colnames(health_expenditure) <- header_names

age_dependency_old[length(age_dependency_old)] <- NULL
colnames(age_dependency_old) <- header_names

household_consumption[length(household_consumption)] <- NULL
colnames(household_consumption) <- header_names
