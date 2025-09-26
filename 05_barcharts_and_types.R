# library
library(tidyverse)

# create a dataset
specie <- c(rep("sorgho" , 3) , rep("poacee" , 3) , rep("banana" , 3) , rep("triticum" , 3) )
condition <- rep(c("normal" , "stress" , "Nitrogen") , 4)
value <- abs(rnorm(12 , 0 , 15))
data <- data.frame(specie,condition,value)



## Bar plot on our own data ------

install.packages("readxl")
library(readxl)
# load data
df <- read_excel("C:/Users/RAMESH/Downloads/Ramesh/projects/03_R_Project/R_training/02_ploting/data/GHGs.xlsx")
colnames(df)


# Grouped
ggplot(df, aes(x=experiment.type, y=`pH type` , fill=`pH type`)) + 
  geom_bar(stat="identity", position="dodge")


#### Bar to Polar pie chart
# Stacked
ggplot(data, aes(x=specie, y=value, fill=condition)) + 
  geom_bar(stat="identity", position="stack") + coord_polar("y", start = 0)

# Stacked Percentage
ggplot(data, aes(x=specie, y=value, fill=condition)) + 
  geom_bar(stat="identity", position="fill") + coord_polar("y", start = 0)