###############################################################################
#' @title NEON location metadata
#'
#' @author Katherine LeVan \email{katherine.levan@gmail.com} 
#'
#' @description A curl wrapper that pull in location metadata from the NEON 
#' location REST API
#'
#' @param \code{namedLocation} A valid named location within the NEON 
#' Observatory, could be a domain, site, plot, or point.
#' @param \code{output} The desired spatial data to output. Options are 'latlon',
#' 'parent', 'child', or 'metadata'. 'latlon' gives only latitude/longitude, 
#' 'parent' and 'child' give all the parent and child location information. 
#' 'metadata' gives back everything.
#' 
#' @references data.neonscience.org/home
#'
#' @keywords NEON, location
#' @examples
#' @seealso None
#' @export
###############################################################################
get_NEON_location <- function(namedLocation = NULL, output = NULL){
  require(httr)
  require(jsonlite)
  url = paste0('data.neonscience.org/api/v0/locations/', namedLocation)
  request <- httr::GET(url)
  content <- jsonlite::fromJSON(httr::content(request, as = "text"))
  if(output == 'latlon'){
    con = data.frame('namedLocation' = content$data$locationName,
                     'decimalLatitude' = content$data$locationDecimalLatitude,
                     'decimalLongitude' = content$data$locationDecimalLongitude,
                     'northing' = content$data$locationUtmNorthing,
                     'easting' = content$data$locationUtmEasting,
                     'utmZone' = content$data$locationUtmZone,
                     'elevation' = content$data$locationElevation)
    if(nrow(con)>0){
      return(con)    
    } else {
      cat('Does not appear to be a valid named location.')
    }
  }
  if(output == 'metadata'){
    return(content$rows)  
  }
  if(output == 'parent'){
    if(length(con)>1){
      con = gsub('http://data.neonscience.org:80/api/v0/locations/', 
                 '', content$data$locationParentUrl)
      return(con)  
    } else {
      cat('Given location is not nested within a parent location.')
    }
  }
  if(output == 'child'){
    if(length(con)>1){
      con = gsub('http://data.neonscience.org:80/api/v0/locations/', 
                 '', content$data$locationChildrenUrls)
      return(con)  
    } else {
      cat('No child locations nested within given location.')
    }
  }
}