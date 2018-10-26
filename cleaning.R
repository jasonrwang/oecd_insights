# Import the list of the countries we care about
country_code = read.table("data/Metadata_Country.csv",sep=",",header=TRUE,skip=0)
country_code = country_code[,c('Country.Code','TableName')] # Drop the irrelevant columns
names(country_code) = c('Code','Country Name')
names(country_code)
