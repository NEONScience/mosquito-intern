#Temperature and Precip lag functions

#Creation of Templag
Templag <- function(siteID, date){
  date <- as.Date(date)
  filter1 <- temp.df[grepl(siteID, temp.df$siteID),]
  filter2 <- filter1[filter1$date >= date - 14 & filter1$date < date + 1,]
  TwoWeekAvgT <- mean(filter2$value)/10
  # GDD <- sum(filter2$value > 20) 
  return(TwoWeekAvgT)
  # how to return multiple objects from a single function call
  # return(list(TwoWeekAvgT=TwoWeekAvgT, GDD=GDD))
}


#Two week average precip
Preciplag <- function(siteID, date){
  date <- as.Date(date)
  filter1 <- precip.df[grepl(siteID, precip.df$siteID),]
  filter2 <- filter1[filter1$date >= date - 14 & filter1$date < date + 1,]
  TwoWeekAvgP <- mean(filter2$value)/10
  return(TwoWeekAvgP)
}

