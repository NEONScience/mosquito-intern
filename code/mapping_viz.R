# Clean starting environment
# rm(list = ls())

# LIBRARIES
library(foreign)
library(maptools)
library(raster)
library(rbokeh) # Maybe with a map?
library(dplyr)

# My working directory
if(file.exists('~/mosquito-intern')){
  repo_location = '~/mosquito-intern'
}
if(!exists('repo_location')){stop('Set the location of the neon_data repository.')}

# Functions to pull NEON data
# source(paste(repo_location, 'get_data/retrieve_data_by_product.R', sep='/'))

# Get map of NEON domains
Ddbf<-read.dbf(paste(repo_location, '/resources/spatial files/NEON_Domains.dbf', sep='/'))
Dmap<-readShapePoly(paste(repo_location, '/resources/spatial files/NEON_Domains.shp', sep='/'))
crs(Dmap) <- "+proj=utm +units=m +ellps=WGS84"

# Map the data
plot(Dmap,col="#ADA96E",bg='#77BFC7',main='NEON Domains',cex.main=1)
points(tars.firstdomain$lon2, tars.firstdomain$lat2, pch=21, bg= "blue",cex=1)
# points(#long, #lat)


