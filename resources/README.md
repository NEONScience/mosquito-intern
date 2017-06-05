# Resources
This repository contains csv files with metadata & supplementary data useful for this project. 

1. Files describing the variables within the mosquito data product (NEON.DOM.SITE.DP1.10041.001_variables.csv, NEON.DOM.SITE.DP1.10043.001_variables.csv)
1. Mosquito taxon table (mosquito_taxonomy.csv). Provides taxonID, acceptedTaxonID (for use in desynonymizing), higher taxonomy and nativity for each scientific name. 
1. Weather station data pulled from the NOAA National Climatic Data Center. Data are from the Global Historical Climatology Network - Daily data product and include:

* daily precipitation data per site (precipitation.csv)
* daily maximum temperature per site (temperature_maximum.csv)
* a metadata file describing the location of each weather station and its relative position to a given site (weather_station_metadata.csv)

NOTE: Temperature and precipitation are given as tenths of mm (Precipitation) and tenths of degrees C (Maximum temperature). To convert these values to mm and degrees C, divide the given number by 10. [see GHCND readme](ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/readme.txt)
