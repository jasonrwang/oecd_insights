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
header_names <- c('Country_Name', 'Country_Code', 'Indicator_Name','Indicator_Code',1960:2017)

# data_frames <- list(age_dependency_old,age_dependency_young,age_dependency_ratio,GDP,health_expenditure_capita,health_expenditure,household_consumption)

length(data_frames)

for (i in 1:length(data_frames)) {
    data_frames[[i]][length(data_frames[[i]])] <- NULL
    colnames(data_frames[[i]]) <- header_names
}

DataFramesClean <- function (...) {
    DataFrames <- list(...)
    for (i in DataFrames) {
        i[length(i)] <- NULL
        colnames(i) <- header_names
        print(colnames(i))
        return(i)
    }
    # print(...)
    # for (i in ...)) {
    #     i[length(i)] <- NULL
    #     colnames(i) <- header_names
    #     # return(i)
    # }
}

DataFramesClean(age_dependency_old,age_dependency_ratio,age_dependency_young)
colnames(age_dependency_old)

DataFramesClean(age_dependency_old,age_dependency_young,age_dependency_ratio,GDP,health_expenditure_capita,health_expenditure)
colnames(age_dependency_old)

age[length(age_dependency_old)] <- NULL
colnames(age_dependency_old) <- header_names
