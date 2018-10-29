<<<<<<< HEAD
### This script plots correlations between the age dependency ratio and other indicators

# These are the indicators we are concerned about
indicatorsVect = c(
    "NY.GDP.MKTP.CD","SH.XPD.EHEX.PC.CD","SH.XPD.CHEX.GD.ZS",
    "NE.CON.PRVT.CD","SI.POV.GINI","SP.DYN.LE00.IN","SP.POP.TOTL")

AllInds_cast['SP.POP.DPND']
# for indicator to compare to age
    # for country
        # for year

# dim(AllInds_cast['SP.POP.DPND'])
# dim(AllInds_cast[indicator])

for (indicator in indicatorsVect) { # Ignore the three age dependency indicators
    # new subplot
    # if countries are separated (maybe they should be?), then call maybe subset each country?
    plot(unlist(AllInds_cast['SP.POP.DPND']),unlist(AllInds_cast[indicator]))
}

=======
## This script plots correlations between the age dependency ratio and other indicators

plot()
>>>>>>> ef7d6a5e26fea4afcab0d1e992dc86a6e3ef7672
