library(reshape)

#import all the different dataframes
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
GDP_per_capita <- read.csv("data/API_NY.GDP.PCAP.CD_DS2_en_csv_v2_10181232.csv",sep=',',header=TRUE,skip=4)

#create a list of all the names of the dataframes and the generic header names we want
str_of_dataframes <- c('age_dependency_old','age_dependency_young','GDP','household_consumption','GDP_per_capita','age_dependency_ratio','health_expenditure_capita','health_expenditure','GINI','life_expectency_birth','total_popuation')
header_names <- c('Country_Name', 'Country_Code', 'Indicator_Name','Indicator_Code',1960:2017)

country_code <- read.csv("data/Metadata_Country.csv",sep=",",header=TRUE,skip=0)
colnames(country_code)[1] <-"CountryCode" #change the name of the first row
country_code <- country_code[!(country_code$Region == ""), ] #keep only countries and skip aggregated inputs

CleanDataFrame <- function(D) {
    D[length(D)] <- NULL #delete the last column, it is empty
    colnames(D) <- header_names #change the headernames to be the same
    return(D)
}

OnlyCountries <- function(D) {
    D <- subset(D,D$Country_Code %in% country_code$CountryCode)
    return(D)
}

#walk through the list and change it according to the function
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

