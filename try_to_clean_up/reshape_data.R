# install.packages("rlist")
library(gclus)
library(rlist)

Reshape <- function(which_year, dataframe) {
    keeps <- c("Country_Name", as.character(which_year))
    dataframe <- dataframe[, keeps, drop = FALSE]
    dataframe <- reshape(dataframe, direction = "long", varying = list(names(dataframe)[2]), v.names = str_of_dataframes[i],
                 idvar = c("Country.Name"), timevar = "Year", times = as.character(which_year))
}

var_names <- paste("df", 1:length(str_of_dataframes), sep = "")
# p_all <- mget(var_names, envir = globalenv())

for (i in 1:length(str_of_dataframes)) {
    assign(var_names[i], Reshape(2015, get(str_of_dataframes[i])))
}

data <- get(var_names[1])
for (i in 2:length(str_of_dataframes)) {
    data <- Reduce(function(x, y) merge(x, y, all=TRUE), list(data, get(var_names[i])))
}
all_data <- data
data <- data[complete.cases(data), ]

# Normalize data
normFunc <- function(x) {
    (x-mean(x, na.rm = T))/sd(x, na.rm = T)
}

data[match(str_of_dataframes[1], names(data)):ncol(data)] <- apply(data[match(str_of_dataframes[1], names(data)):ncol(data)], 2, normFunc)

# Create scatterplot matrix
dta <- data[c(match(str_of_dataframes[1],names(data)):ncol(data))] # get data
dta.r <- abs(cor(dta)) # get correlations
dta.col <- dmat.color(dta.r) # get colors
dta.o <- order.single(dta.r) # reorder variables so those with highest correlation are closest to the diagonal
cpairs(dta, dta.o, panel.colors=dta.col, gap=.5,
       main="Normalized Variables Ordered and Colored by Correlation" )
