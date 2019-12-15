###################################################
# This code subsets the CSV files downloaded from 
# https://exoplanetarchive.ipac.caltech.edu/cgi-bin/TblView/nph-tblView?app=ExoTbls&config=q1_q17_dr24_koi
# and subsets it, merges, and creates new data set for 
# analysis.
# Author: Jasmine Clark - 4 December 2019
###################################################

#clear workspace
rm(list = ls())

setwd("/Users/jasmineclark/Documents/Bay Path MSADS/ADS 635/Final Project")

install.packages("tidyverse")
library(tidyverse)

################################################
# Subsetting the confirmed habitable planets
# from full confirmed data set
################################################

data <- read.csv("full_confirmed.csv")

confirmed_habit <- c("Kepler-296 e", "Kepler-452 b", "Kepler-62 f", "Kepler-296 f", 
               "Kepler-440 b", "Kepler-395 c", "Kepler-438 b", "Kepler-442 b",
               "Kepler-62 e", "Kepler-155 c", "Kepler-235 e", "Kepler-436 b",
               "Kepler-69 c", "Kepler-22 b", "Kepler-443 b", "Kepler-26 e", 
               "Kepler-61 b", "Kepler-439 b", "Kepler-309 c", "Kepler-441 b",
               "Kepler-186 f", "Kepler-174 d")

habitable_confirmed_subset <- data[which(data$kepler_name %in% confirmed_habit), ]

#need this to take a sample of uninhabitable, confirmed planets
new.data <- data[!data$kepler_name %in% confirmed_habit, ]

################################################
# Subsetting the candidate habitable planets
# from full candidate data set
################################################

data2 <- read.csv("full_candidate.csv")

candidate_habit <- c("K07235.01", "K02626.01", "K06425.01", "K07223.01", "K03138.01",
                     "K02418.01", "K07591.01", "K07179.01", "K03010.01", "K00463.01",
                     "K04550.01", "K04036.01", "K06676.01", "K05475.01", "K05856.01",
                     "K07554.01", "K05236.01", "K03282.01", "K04450.01", "K04103.01",
                     "K04054.01", "K05202.01", "K07587.01", "K01871.01", "K02020.01",
                     "K00854.01", "K06343.01", "K01876.01", "K07470.01", "K05276.01",
                     "K07345.01", "K04016.01", "K02834.01", "K04458.01", "K06734.01",
                     "K07136.01", "K03946.01", "K07040.01", "K02770.01", "K04356.01",
                     "K00959.01")

habitable_candidate_subset <- data2[which(data2$kepoi_name %in% candidate_habit), ]


################################################
# Taking random sample of full "CONFIRMED "data set 
# to be used in the analysis.
# These will planets will be the non-habitable ones
################################################
set.seed(12345)
sub <- sample(1:nrow(new.data), 0.20*nrow(new.data))
non_habit_subset <- new.data[sub,]

################################################
# Data merging and cleaning
# Here I will add output (Y) column with
# 0 - non-habitable and 1 - habitable
################################################

#Merging all exoplanet subsets
merged_habitable_data <- rbind(habitable_confirmed_subset, habitable_candidate_subset, non_habit_subset)

#output variable
Y_habitable <- c(rep(1, 44), rep(0, 451))

#Adding the output column (Y_habitable) to the merged data set
merged_habitable_data <- cbind(merged_habitable_data, Y_habitable)

#Removing columns that contain "err" - the upper and lower bounds of a variable
merged_habitable_data <- merged_habitable_data %>% select(-contains("err"))

#Randomize data set
set.seed(123)
rows <- sample(nrow(merged_habitable_data))
merged_habitable_data <- merged_habitable_data[rows,]

#Creating a CSV of the values and variables
write.csv(merged_habitable_data, file="exoplanets.csv")

#"exoplanets.csv" can now be used for EDA and model fitting!

