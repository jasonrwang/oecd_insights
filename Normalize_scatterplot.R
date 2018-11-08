
library(gclus)

# Import data, which are all from the World Bank's Indicators database.
age_dependency_old <- read.csv("data/API_SP.POP.DPND.OL_DS2_en_csv_v2_10184911.csv",sep=',',header=TRUE,skip=4)
age_dependency_young <- read.csv("data/API_SP.POP.DPND.YG_DS2_en_csv_v2_10199819.csv",sep=',',header=TRUE,skip=4)
age_dependency_ratio <- read.csv("data/API_SP.POP.DPND_DS2_en_csv_v2_10188478.csv",sep=',',header=TRUE,skip=4)
GDP <- read.csv("data/API_NY.GDP.MKTP.CD_DS2_en_csv_v2_10203569.csv",sep=',',header=TRUE,skip=4)
health_expenditure_capita <- read.csv("data/API_SH.XPD.EHEX.PC.CD_DS2_en_csv_v2_10203894.csv",sep=',',header=TRUE,skip=4)
health_expenditure <- read.csv("data/API_SH.XPD.CHEX.GD.ZS_DS2_en_csv_v2_10183765.csv",sep=',',header=TRUE,skip=4)
household_consumption <- read.csv("data/API_NE.CON.PRVT.CD_DS2_en_csv_v2_10184156.csv",sep=',',header=TRUE,skip=4)
GDP_per_capita <- read.csv("data/API_NY.GDP.PCAP.CD_DS2_en_csv_v2_10181232.csv",sep=',',header=TRUE,skip=4)

# dropping all year columns except 2015
keeps <- c("Country.Name", "X2015")
df1 <- age_dependency_old[ , keeps, drop = FALSE]
df2 <- age_dependency_young[ , keeps, drop = FALSE]
df3 <- age_dependency_ratio[ , keeps, drop = FALSE]
df4 <- GDP[ , keeps, drop = FALSE]
df5 <- health_expenditure_capita[ , keeps, drop = FALSE]
df6 <- health_expenditure[ , keeps, drop = FALSE]
df7 <- household_consumption[ , keeps, drop = FALSE]
df8 <- GDP_per_capita[ , keeps, drop = FALSE]

# reshape dataframes from wide to long format <-- there must be a way to automate this...
df1.2 <- reshape(df1, direction = "long", varying = list(names(df1)[2]), v.names = "age_dependency_old", 
                 idvar = c("Country.Name"), timevar = "Year", times = 2015)
df2.2 <- reshape(df2, direction = "long", varying = list(names(df2)[2]), v.names = "age_dependency_young", 
                 idvar = c("Country.Name"), timevar = "Year", times = 2015)
df3.2 <- reshape(df3, direction = "long", varying = list(names(df3)[2]), v.names = "age_dependency_ratio", 
                 idvar = c("Country.Name"), timevar = "Year", times = 2015)
df4.2 <- reshape(df4, direction = "long", varying = list(names(df4)[2]), v.names = "GDP", 
                 idvar = c("Country.Name"), timevar = "Year", times = 2015)
df5.2 <- reshape(df5, direction = "long", varying = list(names(df5)[2]), v.names = "health_expenditure_capita", 
                 idvar = c("Country.Name"), timevar = "Year", times = 2015)
df6.2 <- reshape(df6, direction = "long", varying = list(names(df6)[2]), v.names = "health_expenditure", 
                 idvar = c("Country.Name"), timevar = "Year", times = 2015)
df7.2 <- reshape(df7, direction = "long", varying = list(names(df7)[2]), v.names = "household_consumption", 
                 idvar = c("Country.Name"), timevar = "Year", times = 2015)
df8.2 <- reshape(df8, direction = "long", varying = list(names(df8)[2]), v.names = "GDP_per_capita", 
                 idvar = c("Country.Name"), timevar = "Year", times = 2015)

total <- Reduce(function(x, y) merge(x, y, all=TRUE), list(df1.2, df2.2, df3.2, df4.2, df5.2, df6.2, df7.2, df8.2))

total_NA <- total[complete.cases(total), ]

# Normalize data
normFunc <- function(x) { (x-mean(x, na.rm = T))/sd(x, na.rm = T) }

total_NA[3:10] <- apply(total_NA[3:10], 2, normFunc)

# Create scatterplot matrix
dta <- total_NA[c(3,4,5,6,7,8,9,10)] # get data 
dta.r <- abs(cor(dta)) # get correlations
dta.col <- dmat.color(dta.r) # get colors
dta.o <- order.single(dta.r) # reorder variables so those with highest correlation are closest to the diagonal
cpairs(dta, dta.o, panel.colors=dta.col, gap=.5,
       main="Normalized Variables Ordered and Colored by Correlation" )
