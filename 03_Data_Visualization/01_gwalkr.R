install.packages("GWalkR")
library(GWalkR)
data(ChickWeight)
data(ToothGrowth)

gwalkr(ToothGrowth)
gwalkr(ChickWeight)

library(readxl)
df <- read_excel("C:/Users/RAMESH/Downloads/Ramesh/projects/03_R_Project/01_Basic/titanic.xlsx")
head(df)
gwalkr(df)








