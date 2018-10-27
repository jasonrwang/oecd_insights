country_code <- read.csv("data/Metadata_Country.csv",sep=",",header=TRUE,skip=0)
colnames(country_code)[1] <-"CountryCode" #change the name of the first row

country_code <- country_code[!(country_code$Region == ""), ]
country_code <- list(country_code$CountryCode)
