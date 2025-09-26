## libraries
library(tidyverse)
library(readxl)
# load data
df_ghgs <- read_excel("C:/Users/RAMESH/Downloads/Ramesh/projects/03_R_Project/R_training/02_ploting/data/GHGs.xlsx")

# create a piechart of the GHGs$crop_type
# Assuming your data is already in a dataframe named 'data' with a column 'crop.type'

# Step 1: Create a table with the counts of each crop type
crop_counts <- table(df_ghgs$crop.type)
crop_counts

# Step 2: Create the pie chart using base R
pie(
  crop_counts, 
  labels = paste(names(crop_counts), round(prop.table(crop_counts) * 100, 1), "%"), 
  col = c("#ff9999", "#66b3ff", "#99ff99", "#ffcc99", "#c2c2f0", "#ffb3e6", "#c4e17f"),
  main = "Crop Distribution"
)

# Step 3: Create the pie chart using ggplot2
df_ghgs %>%
  count(crop.type) %>%
  ggplot(aes(x = "", y = n, fill = crop.type)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  geom_text(aes(label = paste0(round(n/sum(n)*100, 1), "%")), 
            position = position_stack(vjust = 0.5)) +
  labs(title = "Crop Distribution", fill = "Crop Type") +
  theme_void()