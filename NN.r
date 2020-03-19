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

# separate data into training and testing data
bank2012_train <- bank2012_norm[1:116,]
View(bank2012_train)
bank2012_test <- bank2012_norm[117:155,]
View(bank2012_test)

library(neuralnet)

# neuralnet to predict tweets' sentiment from country's indices
sentiment_model <- neuralnet(formula = Sentiment.2014tweets ~ NY.GDP.MKTP.KD.ZG + NY.GDP.PCAP.CD + IT.NET.USER.P2 + SP.DYN.LE00.IN + SL.UEM.TOTL.ZS + EN.ATM.CO2E.PC, data = bank2012_train)
plot(sentiment_model)
model_results <- compute(sentiment_model, bank2012_test[2:7])
predicted_sentiment <- model_results$net.result
cor(predicted_sentiment, bank2012_test$Sentiment.2014tweets)

# with five hidden nodes
sentiment_model2 <- neuralnet(formula = Sentiment.2014tweets ~ NY.GDP.MKTP.KD.ZG + NY.GDP.PCAP.CD + IT.NET.USER.P2 + SP.DYN.LE00.IN + SL.UEM.TOTL.ZS + EN.ATM.CO2E.PC, data = bank2012_train, hidden=5)
plot(sentiment_model2)
model_results2 <- compute(sentiment_model2, bank2012_test[2:7])
predicted_sentiment2 <- model_results2$net.result
cor(predicted_sentiment2, bank2012_test$Sentiment.2014tweets)
