age_dependency_old <- read.csv("data/API_SP.POP.DPND_DS2_en_csv_v2_10188478.csv",sep=',',header=TRUE,skip=4)
age_dependency_young <- read.csv("data/API_SP.POP.DPND_DS2_en_csv_v2_10188478.csv",sep=',',header=TRUE,skip=4)
age_dependency_ratio <- read.csv("data/API_SP.POP.DPND_DS2_en_csv_v2_10188478.csv",sep=',',header=TRUE,skip=4)
GDP <- read.csv("data/API_SP.POP.DPND_DS2_en_csv_v2_10188478.csv",sep=',',header=TRUE,skip=4)
health_expenditure_capita <- read.csv("data/API_SP.POP.DPND_DS2_en_csv_v2_10188478.csv",sep=',',header=TRUE,skip=4)
health_expenditure <- read.csv("data/API_SP.POP.DPND_DS2_en_csv_v2_10188478.csv",sep=',',header=TRUE,skip=4)
household_consumption <- read.csv("data/API_SP.POP.DPND_DS2_en_csv_v2_10188478.csv",sep=',',header=TRUE,skip=4)

list_of_data_frames <- list(age_dependency_old,age_dependency_young,age_dependency_ratio,GDP,health_expenditure_capita,health_expenditure,household_consumption)
header_names <- c('Country_Name', 'Country_Code', 'Indicator_Name','Indicator_Code',1960:2017)

View(list_of_data_frames[[1]])

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
    View(data_frames)
    # return(x)
}

CleanDataFrames(list_of_data_frames)
