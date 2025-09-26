# 1.readr package----
install.packages("readr")
library(readr)

# Try installing with a different CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))
install.packages("readr")
library(readr)



# Method 1: Using read.csv (base R)
data <- read.csv("C:/Users/RAMESH/Downloads/Ramesh/projects/03_R_Project/01_Basic/data/titanic (2).csv")
View(data)


# 2.Using readxl package---
install.packages("readxl")  # Install if not already installed
library(readxl)
























# 3.writexl----
install.packages("writexl")
library(writexl)
#openxlsx----
install.packages("openxlsx",dependencies = TRUE)
library(openxlsx)
?openxlsx

#practice

# Create a new workbook and add a sheet
wb <- createWorkbook()
addWorksheet(wb, "Sheet 1")

# Write data to the sheet
writeData(wb, "Sheet 1", mtcars)
View(mtcars)


# Save the workbook
saveWorkbook(wb, "my_mtcars.xlsx", overwrite = TRUE)











