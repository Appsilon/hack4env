load_thrash_data <- function(path = "data/jsondata.csv") {
  read.csv(path)
}

find_row_in_data <- function(dat, lon, lat){
  ind <- which(dat$latlon == paste(round(lat*10000)/10000, round(lon*10000)/10000, sep = "_"))
  if (length(ind) > 0) {
    data_cluster[ind[[1]], ]
  } else{
    NULL
  }
}

combined_string_to_df <- function(comb_string){
  tmp <- strsplit(comb_string, split=', ')
  tmp <- as.data.frame(t(data.frame(strsplit(tmp[[1]], split = ' '))))
  colnames(tmp)<- c("rodzaj", "ilosc")
  rownames(tmp) <- NULL
  tmp$ilosc <- as.numeric(tmp$ilosc)
  tmp
}
