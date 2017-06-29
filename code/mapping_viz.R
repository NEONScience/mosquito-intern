# Clean starting environment
# rm(list = ls())

# LIBRARIES
library(foreign)
library(rgeos)
library(maptools)
library(raster)
library(rbokeh) # Maybe with a map?
library(plyr)
library(dplyr)
library(rgdal) # requires sp, will use proj.4 if installed
library(ggplot2)


require("rgdal") # requires sp, will use proj.4 if installed
require("maptools")
require("ggplot2")
require("plyr")



# My working directory
if(file.exists('~/mosquito-intern')){ # Charlotte's path
  repo_location = '~/mosquito-intern'
}
if(file.exists('~/GitHub/mosquito-intern')){
  repo_location = '~/GitHub/mosquito-intern'
}
if(!exists('repo_location')){stop('Set the location of the neon_data repository.')}



# Two ways to make a map
# Way #1: Map the data using maptools & the plot function
# # Get shp files of NEON domains
# Ddbf<-read.dbf(paste(repo_location, '/resources/spatial files/NEON-domain-map/NEON_Domains.dbf', sep='/'))
# Dmap<-readShapePoly(paste(repo_location, '/resources/spatial files/NEON-domain-map/NEON_Domains.shp', sep='/'))
# crs(Dmap) <- "+proj=utm +units=m +ellps=WGS84"
# plot(Dmap,col="#ADA96E",bg='#77BFC7',main='NEON Domains',cex.main=1)
# points(tars.firstdomain$lon2, tars.firstdomain$lat2, pch=21, bg= "blue",cex=1)
# # points(long, lat)

# Way #2: Using rgdal, ggplot and aes
# Read blog post here: https://github.com/tidyverse/ggplot2/wiki/plotting-polygon-shapefiles



#Read in file  
NEONmap = readShapePoly(paste(repo_location, 'resources/spatial files/NEON-domain-map/NEON_Domains.shp', sep='/'))
# Manipulate for plotting
NEONmap@data$id = rownames(NEONmap@data)
NEONmap.points = fortify(NEONmap, region="id")
NEONmap.df = join(NEONmap.points, NEONmap@data, by="id")
NEONmap.df$id<-ifelse(nchar(NEONmap.df$id)<2, paste("D0",NEONmap.df$id, sep=""), paste("D",NEONmap.df$id, sep=""))

# labelnames <- aggregate(cbind(long, lat) ~ DomainName, data=NEONmap.df, FUN=function(x)mean(range(x)))
# labelnames[grepl("Tundra",labelnames$DomainName),"lat"] <-69
# labelnames[grepl("Taiga",labelnames$DomainName),"lat"] <-64
# labelnames[grepl("Pacific Northwest",labelnames$DomainName),c("long","lat")] <-c(-130,60.5)

# make the plot, allows for multiple df use
q <- ggplot()+
  geom_polygon(data = NEONmap.df, aes(long, lat, group=group,fill=DomainName))+
  # geom_text(data= labelnames, aes(long, lat, label = DomainName), size=2) +
  guides(fill=FALSE)+
  geom_path(data = NEONmap.df, aes(long,lat, group=group), color = 'white')

plot(q)

gg <- ggplot()+
  geom_polygon(data = NEONmap.df, aes(long, lat, group=group), fill = 'white')+
  geom_path(data = NEONmap.df, aes(long, lat, group = group), color = 'black')
gg
