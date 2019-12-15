###################################################
# This code performs applies Support Vector
# Machines to exoplanet data
# Author: Jasmine Clark 13 December 2019
###################################################

#clear workspace
rm(list = ls())

setwd("/Users/jasmineclark/Documents/Bay Path MSADS/ADS 635/Final Project")

#install the packages needed
install.packages("e1071")
library(e1071) 

##############################################
# Loading data and sampling
# test and training set
##############################################

exo_data <- read.csv("exoplanets.csv")
exo_data <- exo_data[, -c(1:4)] 
exo_data$Y_habitable <- as.numeric(exo_data$Y_habitable)

#Divide into test and training data
set.seed(123)
test_indis <- sample(1:nrow(exo_data), 1/3*nrow(exo_data))
test <- exo_data[test_indis, ]
training <- exo_data[-test_indis, ]

###########################################
# SVM with linear kernel
###########################################
tune.model <- tune(svm, Y_habitable~., data = training, kernel = "linear",
                   ranges = list(cost = c(0.001, 0.01, 1, 5, 10, 100)))
tune.model
summary(tune.model)

bestmod <- tune.model$best.model
bestmod

# predict the test data
y_hat <- predict(bestmod, newdata = test)
y_true <- test$Y_habitable
svm.pred.lin <- ifelse(y_hat > 0.5, 1, 0)
mean(svm.pred.lin == y_true) #0.92727

table(predict=svm.pred.lin, truth=y_true)

###########################################
# SVM with radial kernel
###########################################
tune.model.rad <- tune(svm, Y_habitable ~., data = training, kernel="radial",
  ranges = list(cost = c(.001, .01, .1, 1, 5, 10, 100), gamma = c(.5, 1, 2, 3, 4)))

#summary
tune.model.rad
summary(tune.model.rad)

bestmod <- tune.model.rad$best.model
bestmod

#Prediction and accuracy rate
y_hat <- predict(bestmod, newdata=test)
y_true <- test$Y_habitable
svm.pred.rad <- ifelse(y_hat > 0.5, 1, 0)
mean(svm.pred.rad == y_true) #0.9393939

table(predict=svm.pred.lin, truth=y_true)



