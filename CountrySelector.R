# Function to select 50 countries with fewest NA's across multiple dataframes

CountrySelector <- function(...) {
  DataFrames <- list(...)  # list all dataframes fed to CountrySelector
  l2 <- lapply(DataFrames, function(x) cbind(x, na_count = rowSums(is.na(x))))  # Add column with NA-value count per row
  l3 <- Reduce(rbind, l2)  # Create one big dataframe
  l4 <- aggregate(x = l3$na_count, by = list(l3$Country.Name), FUN = sum)  # Combined NA-value counts for all dataframes per country
  l5 <- l4[order(l4$x),]  # Order ascending
  CountryList <- list(head(l5$Group.1, 50))  # List 50 countries with lowest NA-value counts
  return(CountryList)
}

setwd("~/Dropbox (Personal)/EPA/EPA1315-Data analytics and visualization/oecd_insights")

GINI = read.csv(file = "GINI_index.csv", sep = ",", header = TRUE)
LIFE_EXP = read.csv(file = "Life_expectancy_at_birth.csv", sep = ",", header = TRUE)
POP = read.csv(file = "Total_population.csv", sep = ",", header = TRUE)

a <- CountrySelector(POP, LIFE_EXP)
a