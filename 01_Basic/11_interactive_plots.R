####----- Plotly for interactive plots -----####
install.packages("plotly")
library(plotly)
library(tidyverse)
library(readxl)
# Load the data
df <- read_excel("C:/Users/RAMESH/Downloads/Ramesh/projects/03_R_Project/01_Basic/titanic.xlsx")
colnames(df) 

# scatter plot
plot_ly(df, x = ~Age, y = ~Fare, color = ~Sex, type = "scatter", mode = "markers")
plot_ly(df, x = ~Age, y = ~Fare, color = ~Sex, type = "scatter", mode = "markers",
        size = ~Fare
)
# line plot
plot_ly(df, x = ~Pclass, y = ~Embarked, color = ~Sex, type = "scatter", mode = "lines")

# bar plot
plot_ly(df, x = ~Pclass, y = ~Fare, color = ~Sex, type = "bar")

#histogram
plot_ly(df, x = ~Age, type = "histogram")

#boxplot
plot_ly(df, x = ~Pclass, y = ~Fare,color=~who, type = "box")


# heatmap
plot_ly(df, x = ~Pclass, y = ~Embarked, z = ~Age, type = "heatmap")

# pie chart
plot_ly(df, labels = ~Pclass, type = "pie")

#bubble chart
plot_ly(df, x = ~Age, y = ~Fare, color = ~Sex, type = "scatter", mode = "markers",
        size = ~Fare * 2
)

# violin plot
plot_ly(df, x = ~Pclass, y = ~Age, type = "violin")

# 3D scatter plot
plot_ly(df, x = ~Age, y = ~Fare, z = ~Pclass, color = ~Sex, type = "scatter3d", mode = "markers")




