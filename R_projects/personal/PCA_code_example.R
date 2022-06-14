# Example of a Principal Component Analysis 
# https://www.datacamp.com/tutorial/pca-analysis-r

#########
# NOTES # 
# works best with numerical data

#########

pacman::p_load(tidyverse)

# Dataset 
View(mtcars)

## CALCULATING 
mtcars.pca <- prcomp(mtcars[,c(1:7,10,11)], center = TRUE, scale. = TRUE)
# test <- prcomp(mtcars, center= TRUE, scale. = TRUE)
# summary(test)

summary(mtcars.pca)

str(mtcars.pca)

mtcars.pca$rotation
# realtionship between the intial variables and the principal components
mtcars.pca$sdev
# standard deviation of each principal component 
mtcars.pca$center
# the center point of each principal component 
mtcars.pca$scale
# of each principal component 
mtcars.pca$x
# values of each observation in terms of the principal component


library(devtools)
library(ggbiplot)
# //! can not install scales package


