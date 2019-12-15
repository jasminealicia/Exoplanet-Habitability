###################################################
# This code performs applies a Random Forest
# classifier to the exoplanet data
# Author: Jasmine Clark 11 December 2019
###################################################

#clear workspace
rm(list = ls())

setwd("/Users/jasmineclark/Documents/Bay Path MSADS/ADS 635/Final Project")

#install the packages needed
install.packages("randomForest")
library(randomForest)

##############################################
# Loading data and sampling
# test and training set
##############################################

exo_data <- read.csv("exoplanets.csv")
exo_data <- exo_data[, -c(1:4)] 
exo_data$Y_habitable <- as.factor(exo_data$Y_habitable)

#Set the seed and put aside a test set
set.seed(12345)
test_indis <- sample(1:nrow(exo_data),  0.20*nrow(exo_data))
test <- exo_data[test_indis,]
training <- exo_data[-test_indis,]

#Y output (true)
y_true <- as.numeric(test$Y_habitable)-1

###########################################
# Random Forest
###########################################
rf.fit <- randomForest(Y_habitable ~ ., data=training, n.tree=10000)
names(rf.fit)

#looks at variable importance over the ensemble
quartz()
varImpPlot(rf.fit) 
#summarize the importance (in table form)
importance(rf.fit)

#Prediction
?predict.randomForest

#Y output (estimate)
y_hat <- predict(rf.fit, newdata=test, type="response")
y_hat <- as.numeric(y_hat)-1
rf.pred <- ifelse(y_hat > 0.5, 1, 0)

#Error rate
misclass_rf <- sum(abs(y_true - y_hat))/length(y_hat)
misclass_rf #0.02020

#Prediction accuracy - how often the prediction was correct
mean(rf.pred == y_true) #0.9798



