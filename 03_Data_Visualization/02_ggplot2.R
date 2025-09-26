installed.packages("tidyvesre")
library(tidyverse)
install.packages("plotly")
library(plotly)
library(readxl)
df <- read_excel("C:/Users/RAMESH/Downloads/Ramesh/projects/03_R_Project/01_Basic/titanic.xlsx")
head(df)
# creat a ggplot2 object
plot <-ggplot(df, aes(x=Age, y=Fare)) + geom_point()
print(plot)

ggplot(df,aes(x=Age, y=Fare ))+
  geom_point(aes(size=Fare,shape=Sex , colour = "red")) +
  theme_classic();plot_2



# Load data
df_clean <- read_excel("C:/Users/RAMESH/Downloads/Ramesh/projects/03_R_Project/01_Basic/titanic.xlsx")

# Clean data
df_clean <- df %>% 
  filter(!is.na(Age)) %>%  # Remove missing Age
  mutate(Survived = factor(Survived, labels = c("No", "Yes")),
         Pclass = factor(Pclass))

# Create a comprehensive plot
final_plot <- ggplot(df_clean, aes(x = Age, y = Fare, 
                                   color = Pclass, 
                                   shape = Sex,
                                   size = SibSp + Parch)) +
  geom_point(alpha = 0.7) +
  labs(title = "Titanic Passengers: Age vs Fare",
       subtitle = "Colored by Class, Shaped by Gender, Sized by Family Size",
       x = "Age", y = "Fare") +
  scale_color_brewer(palette = "Dark2") +
  theme_minimal() +
  facet_wrap(~ Survived)

print(final_plot)

# Interactive version
ggplotly(final_plot)








       