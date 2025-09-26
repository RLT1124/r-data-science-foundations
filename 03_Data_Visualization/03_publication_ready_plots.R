library(readxl)
library(tidyverse)
library(ggpubr)

#load data
df <- read_excel("C:/Users/RAMESH/Downloads/Ramesh/projects/03_R_Project/01_Basic/titanic.xlsx")


# Histogram plot with mean lines and marginal rug
# :::::::::::::::::::::::::::::::::::::::::::::::::::
# Change outline and fill colors by groups ("sex")
# Use custom color palette
gghistogram(df, x = "Age",
            add = "mean", rug = TRUE,
            color = "Sex", fill = "Sex",
            palette = c("#00AFBB", "#E7B800"))



gghistogram(df, x = "Fare",
            add = "mean", rug = TRUE,
            color = "Sex", fill = "Sex",
            palette = c("#00AFBB", "#E7B800"))


ggdensity(df, x = "Age",
            add = "mean", rug = TRUE,
            color = "Sex", fill = "Sex",
            palette = c("#00AFBB", "#E7B800"))











