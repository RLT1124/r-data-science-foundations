# library packages -----
library(tidyverse)
library(readxl)

df <- read_excel("C:/Users/RAMESH/Downloads/Ramesh/projects/03_R_Project/01_Basic/titanic.xlsx")

# draw a histogram
hist(df$Age)


# draw a histogram with ggplot2 having 20 bins
ggplot(df, aes(x = Age)) + geom_histogram(bins = 20) + theme_classic()

# Mean and median
cat("Mean age:", mean(df$Age, na.rm = TRUE), "\n")
cat("Median age:", median(df$Age, na.rm = TRUE), "\n")

A <- c(2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 21, 34, 100, 500)
cat("Median of vector A:", median(A), "\n")

## Data Distributions ------
# Normal Distribution tests
hist(df$Age)
shapiro.test(df$Age)  # Note: shapiro.test removes NAs automatically

hist(df$Fare)
shapiro.test(df$Fare)

# ggplot histograms
ggplot(df, aes(x = Age)) + geom_histogram(bins = 50) + theme_classic()
ggplot(df, aes(x = Fare)) + geom_histogram(bins = 50) + theme_classic()

# Shapiro-Wilk test interpretation
# H0: data is normally distributed if P > 0.05 (95% confidence level)
# H1: data is not normally distributed if P < 0.05 (95% confidence level)

# Shapiro test on Age with interpretation
x <- df$Age
shapiro_result <- shapiro.test(x)
if (shapiro_result$p.value > 0.05) {
  print("Age data is normally distributed")
} else {
  print("Age data is not normally distributed")
}
cat("P-value:", shapiro_result$p.value, "\n")

- Skewness:", ske# Kurtosis and skewness
install.packages("moments")
library(moments)

cat("Age - Kurtosis:", kurtosis(df$Age, na.rm = TRUE), "\n")
cat("Age - Skewness:", skewness(df$Age, na.rm = TRUE), "\n")

cat("Fare - Kurtosis:", kurtosis(df$Fare, na.rm = TRUE), "\n")
cat("Fare wness(df$Fare, na.rm = TRUE), "\n")

# Density plot of age
ggplot(df, aes(x = Age)) + geom_density() + theme_classic()

# Categorical data visualization
# For categorical variables like Pclass (passenger class)
ggplot(df, aes(x = factor(Pclass))) + geom_bar() + 
  labs(x = "Passenger Class", title = "Count of Passengers by Class")

# For Sex column
ggplot(df, aes(x = Sex)) + geom_bar()

# Calculate mean and SD of age by sex
age_by_sex <- df %>% 
  group_by(Sex) %>% 
  summarise(
    mean_age = mean(Age, na.rm = TRUE), 
    sd_age = sd(Age, na.rm = TRUE),
    count = n()
  )
print(age_by_sex)

# Age distribution by sex
ggplot(df, aes(x = Age, fill = Sex)) + 
  geom_histogram(alpha = 0.6, position = "identity", bins = 30) + 
  theme_classic()

# Bar plot of mean age by sex
ggplot(age_by_sex, aes(x = Sex, y = mean_age)) + 
  geom_bar(stat = "identity") + 
  theme_classic() +
  labs(y = "Mean Age", title = "Average Age by Gender")





# Survival analysis
ggplot(df, aes(x = factor(Survived), fill = Sex)) + 
  geom_bar(position = "dodge") +
  labs(x = "Survived (0 = No, 1 = Yes)", title = "Survival by Gender")

# Age distribution by survival status
ggplot(df, aes(x = Age, fill = factor(Survived))) + 
  geom_density(alpha = 0.5) +
  labs(fill = "Survived")

# Fare by passenger class
ggplot(df, aes(x = factor(Pclass), y = Fare)) + 
  geom_boxplot() +
  labs(x = "Passenger Class", title = "Fare Distribution by Class")

# Summary of key variables
cat("\n=== KEY INSIGHTS ===\n")
cat("Total passengers:", nrow(df), "\n")
cat("Survival rate:", mean(df$Survived) * 100, "%\n")
cat("Missing age values:", sum(is.na(df$Age)), "\n")
cat("Average fare:", mean(df$Fare, na.rm = TRUE), "\n")





#kurtosis and skewness----
#1. Skewness - Measure of Asymmetry
library(moments)
library(ggplot2)

# Create example datasets with different skewness
set.seed(123)

# Example 1: Symmetrical (Normal) Distribution - Skewness ≈ 0
normal_data <- rnorm(1000, mean = 50, sd = 10)
skew_normal <- skewness(normal_data)

# Example 2: Right-skewed (Positive Skew) - Skewness > 0
right_skewed <- c(rnorm(800, mean = 50, sd = 10), runif(200, min = 80, max = 150))
skew_right <- skewness(right_skewed)

# Example 3: Left-skewed (Negative Skew) - Skewness < 0
left_skewed <- c(rnorm(800, mean = 50, sd = 10), runif(200, min = 0, max = 20))
skew_left <- skewness(left_skewed)

# Visualize them
par(mfrow = c(1, 3))
hist(normal_data, main = paste("Symmetrical\nSkewness =", round(skew_normal, 2)))
hist(right_skewed, main = paste("Right-skewed\nSkewness =", round(skew_right, 2)))
hist(left_skewed, main = paste("Left-skewed\nSkewness =", round(skew_left, 2)))

