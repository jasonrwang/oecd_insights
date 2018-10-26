age_dependency_old <- read.csv("data/API_SP.POP.DPND.OL_DS2_en_csv_v2_10184911.csv",sep=',',header=TRUE,skip=4)
age_dependency_young <- read.csv("data/API_SP.POP.DPND.YG_DS2_en_csv_v2_10199819.csv",sep=',',header=TRUE,skip=4)
age_dependency_ratio <- read.csv("data/API_SP.POP.DPND_DS2_en_csv_v2_10188478.csv",sep=',',header=TRUE,skip=4)
GDP <- read.csv("data/API_NY.GDP.MKTP.CD_DS2_en_csv_v2_10203569.csv",sep=',',header=TRUE,skip=4)
health_expenditure_capita <- read.csv("data/API_SH.XPD.EHEX.PC.CD_DS2_en_csv_v2_10203894.csv",sep=',',header=TRUE,skip=4)
health_expenditure <- read.csv("data/API_SH.XPD.CHEX.GD.ZS_DS2_en_csv_v2_10183765.csv",sep=',',header=TRUE,skip=4)
household_consumption <- read.csv("data/API_NE.CON.PRVT.CD_DS2_en_csv_v2_10184156.csv",sep=',',header=TRUE,skip=4)

list_of_data_frames <- list(age_dependency_old,age_dependency_young,age_dependency_ratio,GDP,health_expenditure_capita,health_expenditure,household_consumption)
# list_of_data_frames <- c('age_dependency_old','age_dependency_young','age_dependency_ratio','GDP','health_expenditure_capita','health_expenditure','household_consumption')
header_names <- c('Country_Name', 'Country_Code', 'Indicator_Name','Indicator_Code',1960:2017)

CDF <- function(D) {
    D[length(D)] <- NULL
    colnames(D) <- header_names
    return(D)
}

list_of_data_frames <- lapply(list_of_data_frames, CDF)

list2env(list_of_data_frames,envir=.GlobalEnv)

for (D in list_of_data_frames) {

    D[length(D)] <- NULL
    colnames(D) <- header_names
}


for (i in 1:length(list_of_data_frames)) {
    # head(list_of_data_frames[[i]])
    # View(i)
    print(head(list_of_data_frames[[i]]))
}

View(list_of_data_frames)

CleanDataFrames2 <- function(DF) {
    DF[length(DF)] <- NULL
    colnames(DF) <- header_names
}


View(list_of_data_frames[[1]])
View(age_dependency_old)
# list_of_data_frames[[1]][length(list_of_data_frames[[1]])] <- NULL
# colnames(list_of_data_frames[[1]]) <- header_names

for (i in 1:length(list_of_data_frames)) {
    list_of_data_frames[[i]][length(list_of_data_frames[[i]])] <- NULL
    colnames(list_of_data_frames[[i]]) <- header_names
}


CleanDataFrames <- function(data_frames) {
    # for (i in 1:length(data_frames)) {
    #     View(data_frames[[i]])
    # }
    # View(data_frames[[1]])
    for (i in 1:length(data_frames)) {
        data_frames[[i]][length(data_frames[[i]])] <- NULL
        colnames(data_frames[[i]]) <- header_names
        # return(i)
    }
    # View(data_frames)
    return(data_frames)
}

list_of_data_frames <- CleanDataFrames(list_of_data_frames)
