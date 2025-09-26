# Install packages for quick analysis -----
# install.packages("tidyverse")
install.packages("GWalkR")
install.packages("esquisse")
install.packages("explore")
# library or require packages
library(tidyverse)
library(GWalkR)
library(esquisse)
library(explore)
library(readxl)
# Load data -----
df_ghgs <- read_excel("C:/Users/RAMESH/Downloads/Ramesh/projects/03_R_Project/R_training/02_ploting/data/GHGs.xlsx")

# Explore data -----
gwalkr(df_ghgs)
esquisser(viewer = "browser")
explore(df_ghgs)
