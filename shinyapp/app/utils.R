load_thrash_data <- function(path = "data/jsondata.csv") {
  read.csv(path)
}

find_row_in_data <- function(data, lon, lat){
  which.min(abs(data$lon - lon))
  which.max(abs(data$lon - lon))
}