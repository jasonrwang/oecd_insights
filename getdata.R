### getdata.R
## 
## This file imports and cleans the data for all the variables and indicators we aim to examine.
## It then considates all of the data in one dataframe with rows sep

library(reshape)

# Import data, which is all from the World Bank Indicators database
age_dependency_old <- read.csv("data/API_SP.POP.DPND.OL_DS2_en_csv_v2_10184911.csv",sep=',',header=TRUE,skip=4)
age_dependency_young <- read.csv("data/API_SP.POP.DPND.YG_DS2_en_csv_v2_10199819.csv",sep=',',header=TRUE,skip=4)
age_dependency_ratio <- read.csv("data/API_SP.POP.DPND_DS2_en_csv_v2_10188478.csv",sep=',',header=TRUE,skip=4)
GDP <- read.csv("data/API_NY.GDP.MKTP.CD_DS2_en_csv_v2_10203569.csv",sep=',',header=TRUE,skip=4)
health_expenditure_capita <- read.csv("data/API_SH.XPD.EHEX.PC.CD_DS2_en_csv_v2_10203894.csv",sep=',',header=TRUE,skip=4)
health_expenditure <- read.csv("data/API_SH.XPD.CHEX.GD.ZS_DS2_en_csv_v2_10183765.csv",sep=',',header=TRUE,skip=4)
household_consumption <- read.csv("data/API_NE.CON.PRVT.CD_DS2_en_csv_v2_10184156.csv",sep=',',header=TRUE,skip=4)
GINI <- read.csv("data/API_SI.POV.GINI_DS2_en_csv_v2_10181010.csv",sep=',',header=TRUE,skip=4)
life_expectency_birth <- read.csv("data/API_SP.DYN.LE00.IN_DS2_en_csv_v2_10181296.csv",sep=',',header=TRUE,skip=4)
total_popuation <- read.csv("data/API_SP.POP.TOTL_DS2_en_csv_v2_10203548.csv",sep=',',header=TRUE,skip=4)

# Since all the data is from the same source and comes in the same format, we can clean it easily together.
# Create a list of all the names of the dataframes and the generic header names
str_of_dataframes <- c('age_dependency_old','age_dependency_young','age_dependency_ratio','GDP','health_expenditure_capita','health_expenditure','household_consumption','GINI','life_expectency_birth','total_popuation')
header_names <- c('Country_Name', 'Country_Code', 'Indicator_Name','Indicator_Code',1960:2017) # Note, these year columns will be turned into strings

## Also read in a metadata file we can use to remove aggregated countries (regions)
country_code <- read.csv("data/Metadata_Country.csv",sep=",",header=TRUE,skip=0)
# country_code = country_code[,c('Country.Code','TableName')] # Drop the irrelevant columns
# names(country_code) = c('Code','Country Name')
colnames(country_code)[1] <-"CountryCode" #change the name of the first row
country_code <- country_code[!(country_code$Region == ""), ] #keep only countries and skip aggregated inputs

## Functions to clean the data
CleanDataFrame <- function(D) {
    # This simply ensures consistency
    D[length(D)] <- NULL # Delete the last column, it is empty
    colnames(D) <- header_names # Change the headernames to be the same
    return(D)
}

OnlyCountries <- function(D) {
    # Remove entries from regions of aggregated countries
    D <- subset(D,D$Country_Code %in% country_code$CountryCode)
    return(D)
}

# Actually clean the data: Walk through the list of indicators and clean it
for (i in 1:length(str_of_dataframes)) {
    assign(str_of_dataframes[i], CleanDataFrame(get(str_of_dataframes[i])))
    assign(str_of_dataframes[i], OnlyCountries(get(str_of_dataframes[i])))
}

# Combine all indicators into one DataFrame
AllInds = data.frame()

for (indicator in str_of_dataframes) {
    # print(names(get(indicator)))
    AllInds = rbind(AllInds, get(indicator))
}

# Reshape the combined DataFrame

AllInds_melted = melt(AllInds, id = c('Country_Name','Country_Code','Indicator_Name','Indicator_Code'), variable_name='Year')
AllInds_cast = cast(AllInds_melted, Country_Name + Year ~ Indicator_Code)