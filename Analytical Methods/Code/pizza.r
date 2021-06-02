library(ggbiplot)
library(tidyverse)
library(readxl)

# Set WD
getwd()
setwd("C:\\Users\\optim\\Downloads")
getwd()

# Read in data and store in pizza vector
pizza <- read.csv("Pizza.csv", header = T)

# Check the data
head(pizza, n=10)
str(pizza)
summary(pizza)

# Perform PCA transform
pizza.pca <- prcomp(pizza[,-c(1,2)], scale. = T)
pizza.pca

# Plot PCA
?ggbiplot

ggbiplot(pizza.pca, ellipse = T, circle = T, groups = pizza$brand, var.axes = T) +
  scale_color_discrete(name = '') +
  ggtitle('Pizza Brand by Ingredients') +
  scale_color_discrete(name = "Brand")

