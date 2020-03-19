# read dataset which has limited records and columns
bank2012_clean <- read.csv("bank2012_clean.csv")
View(bank2012_clean)

# normalize function which ignores NA values
normalize <- function(x){
  return((x-min(x, na.rm = TRUE))/(max(x, na.rm = TRUE)-min(x, na.rm = TRUE)))
}
# normalize data
bank2012_norm <- as.data.frame(lapply(bank2012_clean[,3:9],normalize))
View(bank2012_norm)

library(stats)

# k-means clastering with four clusters
country_clusters <- kmeans(bank2012_norm, 4)
country_clusters$size
country_clusters$centers
