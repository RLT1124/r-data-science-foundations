## 1. Packages ----
# Clear environment and restart
rm(list = ls())

# Install required packages if not already installed
if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr")
}
if (!requireNamespace("nycflights13", quietly = TRUE)) {
  install.packages("nycflights13")
}

# Load individual packages instead of tidyverse
library(dplyr)
library(tidyr)
library(nycflights13)


# Check if flights dataset is available
data("flights")
df <- flights

# Explore the dataset
print("Dataset structure:")
str(df)
print("First few rows:")
head(df)
print("Column names:")
colnames(df)

# Basic information about the dataset
print("Dataset dimensions:")
dim(df)
print("Summary statistics:")
summary(df)

## 2. Data Handling ----


# Check if flights dataset is available
data("flights")
df <- flights

# Basic dataset information
cat("Dataset dimensions:", dim(df), "\n")
cat("Column names:\n")
print(colnames(df))

# Range of columns using base R
cat("Range of year:", range(df$year), "\n")
cat("Range of month:", range(df$month), "\n")
cat("Range of day:", range(df$day), "\n")

# Filter January 2013 flights using base R
jan_2013 <- df[df$month == 1, ]
cat("January 2013 flights:", nrow(jan_2013), "\n")

# Basic summary statistics
cat("Summary of departure delays:\n")
summary(df$dep_delay)

# Count flights by carrier
carrier_counts <- table(df$carrier)
cat("Flights by carrier:\n")
print(carrier_counts)

# Top 5 destinations
dest_counts <- sort(table(df$dest), decreasing = TRUE)
cat("Top 5 destinations:\n")
print(head(dest_counts, 5))

# Average departure delay by month
avg_delay_by_month <- tapply(df$dep_delay, df$month, mean, na.rm = TRUE)
cat("Average departure delay by month:\n")
print(avg_delay_by_month)





## 3. Missing Values ----
# check for missing values  
is.na(df)
sum(is.na(df))
# calculate the percentage of missing values
# number of rows in data
nrow(df)
sum(is.na(df)) / nrow(df) * 100
sum(is.na(df$dep_time))

# find number of missing values in each column of df
colSums(is.na(df))
#plot these missing values in each column

# df %>% is.na() %>% barplot() # takes a lot of memory

# Base R approach for missing values analysis

# 1. Calculate missing values per column
missing_counts <- colSums(is.na(df))
cat("Missing values per column:\n")
print(missing_counts)

# 2. Barplot of missing values (if graphics work)
barplot(missing_counts, 
        main = "Missing Values by Column",
        las = 2,  # Vertical labels
        cex.names = 0.8)

# 3. Save to CSV
write.csv(missing_counts, "data/missing_values.csv")

# 4. Percentage of missing values
missing_percent <- round((missing_counts / nrow(df)) * 100, 2)
cat("Missing values percentage:\n")
print(missing_percent)

# 5. Alternative: Create a summary data frame
missing_summary <- data.frame(
  column = names(missing_counts),
  missing_count = missing_counts,
  missing_percent = missing_percent
)
print("Missing values summary:")
print(missing_summary)

# 6. Save the detailed summary
write.csv(missing_summary, "data/missing_values_detailed.csv", row.names = FALSE)
















