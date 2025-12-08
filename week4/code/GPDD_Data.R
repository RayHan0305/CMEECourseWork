rm(list = ls())

load("../data/GPDDFiltered.RData") 

library("maps")
library("ggplot2")

world <-map_data("world")#
p = ggplot() + geom_polygon(data=world, aes(x=long, y=lat, group=group), fill="grey")  + 
  geom_point(data=gpdd,aes(x=long,y=lat),alpha=0.5, col = "red") + theme_minimal()

pdf("../results/GPDD_Data_MAP.pdf") # Open blank pdf page using a relative path
print (p)
dev.off()

#Bias1: Only terrestrial locations are shown; there are
#    no marine or open-ocean locations on the map, so results will
#    not reflect marine biodiversity or population trends.
#Bias2: Strong geographic bias: most GPDD time series come from Europe
#    (especially the UK) and North America. Large regions such as
#    most of Africa, South America, Asia and the tropics are poorly
#    represented, so any “global” analysis will be dominated by
#    temperate, well-studied regions
