### This script plots correlations between the age dependency ratio and other indicators
## Deprecated? - Jason

library(ggplot2)

# These are the indicators we are concerned about
indicatorsVect = c(
    "NY.GDP.MKTP.CD","SH.XPD.EHEX.PC.CD","SH.XPD.CHEX.GD.ZS",
    "NE.CON.PRVT.CD","SI.POV.GINI","SP.DYN.LE00.IN","SP.POP.TOTL")

# Create exploratory plots
for (indicator in indicatorsVect) { # Ignore the three age dependency indicators
    # Ideally, subplot this

    # if countries are separated (maybe they should be?), then call maybe subset each country?
    # plot(unlist(AllInds_cast['SP.POP.DPND']),unlist(AllInds_cast[indicator])) <-- group by country

    # ggplot2
    plot <- ggplot(data = AllInds_cast, aes(x = SP.POP.DPND, y = get(indicator), colour = Year) ) + geom_point() # colour can be by 'Country_Name' too
    plot <- plot + guides(colour = FALSE) # Turn off the legend since it will get too confusing with all countries
    plot + scale_y_log10() # (GDP looks weird! Plot in log10 to see if there is something interesting...)
    plot + ylab(paste0(indicator)) # Run this instead of 'get(indicator)', which is the default output
    # We should instead match these with the actual indicator names
    saveName = sprintf('figures/%s.png',gsub('\\.','',indicator) )
    ggsave(saveName)
}

## Grammar Validation and Examples
test = subset(AllInds_cast, Country_Name == c('Canada','Netherlands') )
test2 = AllInds_cast[ which(AllInds_cast['Country_Name'] == 'Canada'), ])

p0 = ggplot(data = test, aes(x = Year, y = NY.GDP.MKTP.CD, colour = Year) ) + geom_point()
p0+guides(colour=FALSE)