###################################################
# This code performs Linear Discriminant Analysis
# on the exoplanet data 
# Author: Jasmine Clark 11 December 2019
###################################################

#clear workspace
rm(list = ls())

setwd("/Users/jasmineclark/Documents/Bay Path MSADS/ADS 635/Final Project")

#install the packages needed
install.packages("MASS")
library(MASS)

##############################################
# Loading data
##############################################

exo_data <- read.csv("exoplanets.csv")
exo_data <- exo_data[, -c(1:4)]
exo_data$Y_habitable <- as.factor(exo_data$Y_habitable)

set.seed(12345)
train <- sample(1:nrow(exo_data), .80*nrow(exo_data))
exo.train <- exo_data[train,]
exo.test <- exo_data[-train,]
dim(exo.train)
dim(exo.test)

#Y output (true)
y_true <- as.numeric(exo.test$Y_habitable)-1

##############################################
## Linear Discriminant Analysis (LDA)
##############################################

lda.fit <- lda(Y_habitable ~ ., data=exo.train)

#Prediction
lda.pred.test <- predict(lda.fit, newdata = exo.test)
names(lda.pred.test)
y_hat <- as.numeric(lda.pred.test$class)-1
rf.pred <- ifelse(y_hat > 0.5, 1, 0)

#Test error rate
lda_test_error <- sum(abs(y_true - y_hat))/length(y_true)
lda_test_error #0.0808

#Prediction Accuracy
mean(rf.pred == y_true) #0.9191

