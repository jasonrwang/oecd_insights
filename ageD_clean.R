ageD_all = read.csv('data/API_SP.POP.DPND_DS2_en_csv_v2_10188478.csv', header=TRUE, skip=4)
ageD_young = read.csv('data/API_SP.POP.DPND.YG_DS2_en_csv_v2_10199819.csv', header=TRUE, skip=4)
ageD_old = read.csv('data/API_SP.POP.DPND.OL_DS2_en_csv_v2_10184911.csv', header=TRUE, skip=4)

colnames(ageD_all)

# Is it worth using country names as indices?
rownames(ageD_all)
dim(ageD_all)[2]

# I really need an R crash course again.. I have no idea how to do anything anymore!
for (i in seq(0, dim(ageD_all)[2]) ) {
    if  ( (dim(ageD_all[i,])[2]) < 63 ) {
        print('LESS')
    }
}

## Make a list of how many NA's are in each country's data to find the countries with the most (sort)