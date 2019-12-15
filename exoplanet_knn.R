###################################################
# This code performs K-nearest neighbors
# classification on the exoplanet data 
# Author: Jasmine Clark 6 December 2019
###################################################

#clear workspace
rm(list = ls())

setwd("/Users/jasmineclark/Documents/Bay Path MSADS/ADS 635/Final Project")

install.packages("class")


##############################################
# Loading data
##############################################

exo_data <- read.csv("exoplanets.csv")
exo_data <- exo_data[, -c(1:4)] 


##############################################
# KNN Model
##############################################

require(class)
set.seed(12345)
train <- sample(1:nrow(exo_data), .80*nrow(exo_data))
exo.train <- exo_data[train,]
exo.test <- exo_data[-train,]

train.x <- cbind(exo.train[,-19])
test.x <- cbind(exo.test[,-19])
train.y <- cbind(exo.train$Y_habitable)
pred.knn <- knn(train.x, test.x, train.y, k=10)
table(pred.knn, exo.test$Y_habitable)

#Prediction accuracy 
mean(pred.knn == exo.test$Y_habitable) #0.9393



