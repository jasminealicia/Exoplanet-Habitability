#clear workspace
rm(list = ls())

setwd("/Users/jasmineclark/Documents/Bay Path MSADS/ADS 635/Final Project")

#install the packages needed
install.packages("leaps")
install.packages("corrplot")
install.packages("ggplot2")
install.packages("glmnet")
install.packages("logistf")
library(leaps)
library(corrplot)
library(ggplot2)
library(glmnet)

##############################################
# Loading data and cleaning up a tad bit
##############################################

exo_data <- read.csv("exoplanets.csv")
#exo_data <- exo_data[, apply(exo_data, 2, function(x) !any(is.na(x)))]
exo_data <- exo_data[, -c(1:4)] #don't need columns 1-4 (they're just ID's and names)

#############################################
# Some exploratory data analysis
# on original and subsetted data
#############################################

dim(exo_data)
names(exo_data)
#check for missing values
sum(is.na(exo_data)) #0 

#take a peak at some summary statistics
summary(exo_data)

#Correlations in exo_data
quartz()
corrplot(cor(exo_data))

cor(exo_data)

#Distribution of habitable vs non-habitable exoplanets
quartz()
ggplot(exo_data, aes(x=Y_habitable, fill=factor(Y_habitable))) + 
  geom_bar(stat = "count", position="dodge") + scale_x_continuous(breaks = seq(0,1,1)) +
  ggtitle("Distribution of Habitable/Non-Habitable Exoplanets") +
  theme_classic()

quartz()
boxplot(exo_data$koi_teq)
                                                                             
##############################################
# Subset Selection - A bust!
##############################################

#Exhaustive/ Best subset selection
regfit.full <- regsubsets(Y_habitable~., data = exo_data, nbest = 1, nvmax=18, method = "exhaustive")
my_sum <- summary(regfit.full)

#Graphical representations of the number of variables that minimize the RSS
par(mfrow = c(2,2))
quartz()
plot(my_sum$cp, xlab = "Number of Variables", ylab = "Cp", type = "l")
quartz()
plot(my_sum$bic, xlab = "Number of Variables", ylab = "BIC", type = "l")

which(my_sum$cp == min(my_sum$cp)) #12 variables
which(my_sum$bic == min(my_sum$bic)) #5 variables 

#Best n variables
summary(regfit.full)$outmat[12,]
summary(regfit.full)$outmat[5,]


#Excluding the variables not needed

vars_5 <- names(exo_data) %in% c("koi_period", "koi_srho", "koi_sma", "koi_dor", "koi_steff", "Y_habitable")

vars_12 <- names(exo_data) %in% c("koi_impact", "koi_ror", "koi_prad", "koi_teq", "koi_count", "koi_srad")

#new exo data set with 12 variables
new.exo_data <- exo_data[-vars_12] 



##############################################
# Logistic Regression - A bust!! - Explained in video presentation
##############################################

#Create training and test set
set.seed(12345)
train <- sample(1:nrow(new.exo_data), .66*nrow(new.exo_data))
exo.train <- new.exo_data[train,]
exo.test <- new.exo_data[-train,]


#Firth Logistic Regression for 12 variable model
#firth <- logistf(Y_habitable ~ ., data=exo.train)
#summary(firth)

#Fitting the logistic regression model
log.model <- glm(Y_habitable ~ ., data = exo.train, family="binomial")




