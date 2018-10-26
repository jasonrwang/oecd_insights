#import all the different dataframes
age_dependency_old <- read.csv("data/API_SP.POP.DPND.OL_DS2_en_csv_v2_10184911.csv",sep=',',header=TRUE,skip=4)
age_dependency_young <- read.csv("data/API_SP.POP.DPND.YG_DS2_en_csv_v2_10199819.csv",sep=',',header=TRUE,skip=4)
age_dependency_ratio <- read.csv("data/API_SP.POP.DPND_DS2_en_csv_v2_10188478.csv",sep=',',header=TRUE,skip=4)
GDP <- read.csv("data/API_NY.GDP.MKTP.CD_DS2_en_csv_v2_10203569.csv",sep=',',header=TRUE,skip=4)
health_expenditure_capita <- read.csv("data/API_SH.XPD.EHEX.PC.CD_DS2_en_csv_v2_10203894.csv",sep=',',header=TRUE,skip=4)
health_expenditure <- read.csv("data/API_SH.XPD.CHEX.GD.ZS_DS2_en_csv_v2_10183765.csv",sep=',',header=TRUE,skip=4)
household_consumption <- read.csv("data/API_NE.CON.PRVT.CD_DS2_en_csv_v2_10184156.csv",sep=',',header=TRUE,skip=4)

#create a list of all the names of the dataframes and the generic header names we want
list_of_data_frames <- c('age_dependency_old','age_dependency_young','age_dependency_ratio','GDP','health_expenditure_capita','health_expenditure','household_consumption')
header_names <- c('Country_Name', 'Country_Code', 'Indicator_Name','Indicator_Code',1960:2017)

CDF <- function(D) {
    D[length(D)] <- NULL #delete the last column, it is empty
    colnames(D) <- header_names #change the headernames to be the same
    return(D)
}

#walk through the list and change it according to the function
for (i in 1:length(list_of_data_frames)) {
    assign(list_of_data_frames[i], CDF(get(list_of_data_frames[i])))
}

# View(age_dependency_old)
