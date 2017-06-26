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
NEONmap = readOGR(paste('mosquito-intern/resources/spatial files/NEON-domain-map/NEON_Domains.shp', sep='/'))
# Manipulate for plotting
NEONmap@data$id = rownames(NEONmap@data)
NEONmap.points = fortify(NEONmap, region="id")
NEONmap.df = join(NEONmap.points, NEONmap@data, by="id")
NEONmap@data$id = rownames(NEONmap@data)
NEONmap.points = fortify(NEONmap, region="id")
NEONmap.df = join(NEONmap.points, NEONmap@data, by="id")

# make the plot, allows for multiple df use
q <- ggplot()+
  geom_polygon(data = NEONmap.df, aes(long, lat, group=group))+
  geom_path(data = NEONmap.df, aes(long,lat, group=group), color = 'white')


