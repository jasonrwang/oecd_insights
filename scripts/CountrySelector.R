## Function to select 50 countries with fewest NA's across multiple dataframes
# Not yet linked to main.R – where else is it used?

CountrySelector <- function(...) {
  DataFrames <- list(...)  # list all dataframes fed to CountrySelector
  l2 <- lapply(DataFrames, function(x) cbind(x, na_count = rowSums(is.na(x))))  # Add column with NA-value count per row
  l3 <- Reduce(rbind, l2)  # Create one big dataframe
  l4 <- aggregate(x = l3$na_count, by = list(l3$Country.Name), FUN = sum)  # Combined NA-value counts for all dataframes per country
  l5 <- l4[order(l4$x),]  # Order ascending
  CountryList <- list(head(l5$Group.1, 50))  # List 50 countries with lowest NA-value counts
  return(CountryList)
}
