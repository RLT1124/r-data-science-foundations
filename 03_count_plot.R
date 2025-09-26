## libraries
library(tidyverse)
library(readxl)

# load data
df_ghgs <- read_excel("C:/Users/RAMESH/Downloads/Ramesh/projects/03_R_Project/R_training/02_ploting/data/GHGs.xlsx")

p1 <- df_ghgs %>%
  group_by(crop.type) %>%
  summarise(counts = n()) %>% 
  ggplot(aes(crop.type, counts, fill = crop.type)) + 
  geom_bar(stat = "identity") +
  xlab("Crop Type") + 
  ylab("Number of Observations") + 
  theme_classic() +
  theme(text = element_text(size = 14),
        axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9", "#2415ce", "blue", "green", "orange"))

# Save plots
ggsave("C:/Users/RAMESH/Downloads/Ramesh/projects/03_R_Project/R_training/02_ploting/data/01_plot.png", plot = p1, scale=1, height = 8, width = 6, dpi = 300)
ggsave("C:/Users/RAMESH/Downloads/Ramesh/projects/03_R_Project/R_training/02_ploting/data/01_plot.svg", plot = p1, scale=1, height = 8, width = 6, dpi = 300)