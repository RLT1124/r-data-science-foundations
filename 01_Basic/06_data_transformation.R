#1. Basic Data Transformation with Base R----


# Create sample data
df <- data.frame(
  id = 1:10,
  name = c("Alice", "Bob", "Charlie", "David", "Eve", "Frank", "Grace", "Henry", "Ivy", "Jack"),
  age = c(25, 32, 45, 29, 38, 52, 27, 41, 33, 48),
  salary = c(50000, 65000, 80000, 55000, 72000, 95000, 48000, 88000, 60000, 92000),
  department = c("HR", "IT", "Finance", "IT", "HR", "Finance", "IT", "Finance", "HR", "IT"),
  experience = c(2, 5, 12, 4, 8, 15, 3, 10, 6, 13)
)

# Basic transformations
df$salary_k <- df$salary / 1000  # Convert to thousands
df$age_group <- ifelse(df$age < 30, "Young", 
                       ifelse(df$age < 45, "Middle", "Senior"))
df$bonus <- df$salary * 0.1  # 10% bonus

# Subsetting and filtering
young_employees <- df[df$age < 30, ]
high_salary <- df[df$salary > 70000, c("name", "salary", "department")]

# Aggregation
avg_salary_by_dept <- aggregate(salary ~ department, data = df, FUN = mean)




#2. Data Transformation with dplyr----

library(dplyr)



# Using dplyr for data transformation
df_transformed <- df %>%
  # Select specific columns
  select(name, age, salary, department) %>%
  
  # Filter rows
  filter(age > 25 & salary > 50000) %>%
  
  # Create new variables
  mutate(
    salary_category = case_when(
      salary < 60000 ~ "Low",
      salary < 80000 ~ "Medium",
      TRUE ~ "High"
    ),
    experience_years = age - 22,  # Assuming starting age 22
    performance_score = (salary / 1000) + (experience_years * 2)  # Fixed: changed 'experience' to 'experience_years'
  ) %>%
  
  
  # First, check what columns are available
  colnames(df)


# See what's available
ls()

# Check if df exists and what type it is
exists("df")
class(df)



# Check column names and first few rows
colnames(df)
head(df)

# Or get more detailed structure
str(df)

# Check if salary column exists with different case or spelling
names(df)  # Alternative to colnames()







# Look for possible variations of salary
names(df)[grepl("sal", names(df), ignore.case = TRUE)]

# See all column names with their exact spelling
print("Exact column names:")
for(col in names(df)) {
  cat('"', col, '"\n', sep = "")
}





# Run each step separately to find where salary disappears
step1 <- df %>% select(name, age, salary, department)
print("After select:")
colnames(step1)

step2 <- step1 %>% filter(age > 25 & salary > 50000)
print("After filter:")
colnames(step2)

step3 <- step2 %>% mutate(
  salary_category = case_when(
    salary < 60000 ~ "Low",
    salary < 80000 ~ "Medium",
    TRUE ~ "High"
  ),
  experience_years = age - 22,
  performance_score = (salary / 1000) + (experience_years * 2)
)
print("After mutate:")
colnames(step3)

# If all steps work, then continue
df_transformed <- step3 %>%
  arrange(desc(salary)) %>%
  group_by(department, salary_category) %>%
  summarise(
    count = n(),
    avg_age = mean(age),
    avg_salary = mean(salary),
    max_salary = max(salary),
    .groups = 'drop'
  )



#3. Advanced dplyr Operations----

# More complex transformations
library(dplyr)

# Create a more complex dataset
set.seed(123)
sales_data <- data.frame(
  product_id = rep(1:5, each = 20),
  month = rep(1:12, length.out = 100),
  year = rep(2023:2024, each = 50),
  sales_amount = round(runif(100, 1000, 10000), 2),
  region = sample(c("North", "South", "East", "West"), 100, replace = TRUE),
  category = sample(c("Electronics", "Clothing", "Food", "Books"), 100, replace = TRUE)
)

# Complex transformations
sales_summary <- sales_data %>%
  # Filter for specific conditions
  filter(sales_amount > 2000, year == 2024) %>%
  
  # Create calculated columns
  mutate(
    sales_quartile = ntile(sales_amount, 4),
    sales_bucket = case_when(
      sales_amount < 3000 ~ "Low",
      sales_amount < 6000 ~ "Medium",
      TRUE ~ "High"
    ),
    log_sales = log(sales_amount)
  ) %>%
  
  # Group by multiple variables
  group_by(region, category, sales_bucket) %>%
  
  # Multiple summary statistics
  summarise(
    total_sales = sum(sales_amount),
    avg_sales = mean(sales_amount),
    median_sales = median(sales_amount),
    sales_count = n(),
    unique_products = n_distinct(product_id),
    .groups = 'drop'
  ) %>%
  
  # Calculate percentages
  group_by(region) %>%
  mutate(
    region_percentage = total_sales / sum(total_sales) * 100
  ) %>%
  ungroup() %>%
  
  # Final arrangement
  arrange(region, desc(total_sales))

print(sales_summary)





#4. Advanced dplyr Operations----


    
# Load required packages
library(dplyr)
library(stringr)

# Create text data
text_data <- data.frame(
  id = 1:6,
  text = c(
    "Hello World 2024",
    "Data Science is fun",
    "R programming 2023",
    "Machine Learning AI",
    "Big Data Analytics",
    "Deep Learning 2024"
  ),
  category = c("A", "B", "A", "C", "B", "A")
)

# String transformations
text_transformed <- text_data %>%
  mutate(
    # Extract numbers
    year_extracted = str_extract(text, "\\d{4}"),
    
    # Convert to lowercase
    text_lower = str_to_lower(text),
    
    # Remove numbers
    text_no_numbers = str_remove_all(text, "\\d"),
    
    # Extract first word
    first_word = word(text, 1),
    
    # Count words
    word_count = str_count(text, "\\S+"),
    
    # Check if contains specific words
    contains_learning = str_detect(text, "[Ll]earning"),
    
    # Replace patterns
    text_clean = str_replace_all(text, "202[0-9]", "YEAR")
  )

# View the transformed data
print(text_transformed)
View(text_transformed)

#5. Date Transformation with lubridate----
library(lubridate)
library(dplyr)

# Create date data
date_data <- data.frame(
  id = 1:8,
  date_string = c(
    "2024-01-15", "2023-12-25", "2024-02-28",
    "2023-11-01", "2024-03-15", "2023-10-31",
    "2024-04-01", "2023-09-15"
  ),
  datetime_string = c(
    "2024-01-15 10:30:00", "2023-12-25 14:45:00",
    "2024-02-28 09:15:00", "2023-11-01 16:20:00",
    "2024-03-15 11:00:00", "2023-10-31 13:30:00",
    "2024-04-01 08:45:00", "2023-09-15 15:10:00"
  )
)

# Date transformations
date_transformed <- date_data %>%
  mutate(
    # Convert to proper date format
    date_proper = ymd(date_string),
    datetime_proper = ymd_hms(datetime_string),
    
    # Extract components
    year = year(date_proper),
    month = month(date_proper, label = TRUE),
    day = day(date_proper),
    weekday = wday(date_proper, label = TRUE),
    
    # Calculate differences
    days_from_today = as.numeric(difftime(Sys.Date(), date_proper, units = "days")),
    
    # Create date ranges
    quarter = quarter(date_proper),
    is_q1 = quarter == 1,
    
    # Time calculations
    hour = hour(datetime_proper),
    is_morning = hour(datetime_proper) < 12
  )

print(date_transformed)




#6. Reshaping Data with tidyr----
library(tidyr)
library(dplyr)

# Create wide format data
wide_data <- data.frame(
  country = c("USA", "Canada", "UK"),
  `2021_population` = c(331, 38, 67),
  `2022_population` = c(332, 38.5, 67.2),
  `2021_gdp` = c(21.4, 1.6, 2.7),
  `2022_gdp` = c(23.3, 1.7, 2.8)
)


# Clear environment and load packages
rm(list = ls())
library(dplyr)
library(tidyr)

# Create wide format data
wide_data <- data.frame(
  country = c("USA", "Canada", "UK"),
  `2021_population` = c(331, 38, 67),
  `2022_population` = c(332, 38.5, 67.2),
  `2021_gdp` = c(21.4, 1.6, 2.7),
  `2022_gdp` = c(23.3, 1.7, 2.8),
  check.names = FALSE  # Keep the original column names as is
)



# Reshape from wide to long - step by step approach
# First, pivot to long format
long_step1 <- wide_data %>%
  pivot_longer(
    cols = -country,
    names_to = "year_metric",
    values_to = "value"
  )

print("After first pivot_longer:")
print(long_step1)




# Separate year and metric
long_step2 <- long_step1 %>%
  separate(
    col = year_metric,
    into = c("year", "metric"),
    sep = "_"
  )

print("After separating year and metric:")
print(long_step2)







# Pivot to wider format to get separate columns for population and GDP
long_data <- long_step2 %>%
  pivot_wider(
    names_from = metric,
    values_from = value
  ) %>%
  mutate(
    year = as.numeric(sub("X", "", year)),  # Remove 'X' prefix if present
    gdp_per_capita = gdp * 1000 / population  # GDP in billions, population in millions
  )

print("Final long data:")
print(long_data)















#7. Practice Exercises----

# Exercise 1: Student Data Transformation

# Create the dataset
set.seed(123) # For reproducible results
practice_data <- data.frame(
  student_id = 1:20,
  name = paste0("Student_", 1:20),
  math_score = round(rnorm(20, 75, 10)),
  science_score = round(rnorm(20, 72, 12)),
  english_score = round(rnorm(20, 78, 8)),
  attendance = round(runif(20, 70, 100))
)

# View original data
print("Original Data:")
print(practice_data)

# Task 1: Calculate average score for each student
practice_data <- practice_data %>%
  mutate(average_score = round((math_score + science_score + english_score) / 3, 1))

# Task 2: Create a grade column
practice_data <- practice_data %>%
  mutate(grade = case_when(
    average_score >= 90 ~ "A",
    average_score >= 80 ~ "B",
    average_score >= 70 ~ "C",
    average_score >= 60 ~ "D",
    TRUE ~ "F"
  ))

# Task 3: Filter students with attendance > 85%
high_attendance_students <- practice_data %>%
  filter(attendance > 85)

print("\nStudents with attendance > 85%:")
print(high_attendance_students)

# Task 4: Group by grade and calculate statistics
grade_statistics <- practice_data %>%
  group_by(grade) %>%
  summarise(
    count = n(),
    avg_math = round(mean(math_score), 1),
    avg_science = round(mean(science_score), 1),
    avg_english = round(mean(english_score), 1),
    avg_overall = round(mean(average_score), 1),
    avg_attendance = round(mean(attendance), 1),
    min_score = min(average_score),
    max_score = max(average_score)
  ) %>%
  arrange(desc(avg_overall))

print("\nGrade Statistics:")
print(grade_statistics)

# Task 5: Find top 5 students by average score
top_5_students <- practice_data %>%
  arrange(desc(average_score)) %>%
  head(5) %>%
  select(name, math_score, science_score, english_score, average_score, grade, attendance)

print("\nTop 5 Students by Average Score:")
print(top_5_students)

# Additional: Summary of the transformed data
print("\nFinal Transformed Data:")
print(practice_data)

# Summary statistics
cat("\nOverall Summary:\n")
cat("Number of students:", nrow(practice_data), "\n")
cat("Average math score:", round(mean(practice_data$math_score), 1), "\n")
cat("Average science score:", round(mean(practice_data$science_score), 1), "\n")
cat("Average english score:", round(mean(practice_data$english_score), 1), "\n")
cat("Overall average score:", round(mean(practice_data$average_score), 1), "\n")
cat("Average attendance:", round(mean(practice_data$attendance), 1), "%\n")