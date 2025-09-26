### install packages in r ----

install.packages("readxl")
library(readxl)
require(readxl)
detach("package:readxl",unload=TRUE)


# tidyverse
install.packages("tidyverse")
library(tidyverse)


# set repositories
setRepositories()


### explor datasets----
data()
data(iris)
data(co2)
View(co2)
View(iris)
data("USArrests")
View(USArrests)
?writexl


# Load a built-in dataset----
data(mtcars)

# Or, read your own data
# my_data <- read.csv("path/to/your/file.csv")
View(mtcars)
# See the first 6 rows
head(mtcars)


# See the last 6 rows
tail(mtcars)
# Get the dimensions: Number of Rows and Columns
dim(mtcars)
# Get the column names
names(mtcars)
# Get a quick overview of the entire structure
# Shows variables, types, and first few values
str(mtcars)
View(mtcars)

# Check the class of the entire object (e.g., data.frame, tibble)
class(mtcars)
# Check the data type of a specific column
class(mtcars$mpg) # Numerical
class(mtcars$cyl) # Numerical (but might be categorical!)
class(mtcars$vs) # Numerical (but is actually categorical)
# Convert 'cyl' (cylinders) to a categorical variable
mtcars$cyl_factor <- factor(mtcars$cyl)
str(mtcars$cyl_factor)
# Summary for all columns: min, 1Q, median, mean, 3Q, max, NA count
summary(mtcars)

# Detailed summary for a single numeric column
summary(mtcars$mpg)
# Calculate specific statistics
mean(mtcars$mpg, na.rm = TRUE) # Always use na.rm to ignore missing values
median(mtcars$mpg)
sd(mtcars$mpg) # Standard Deviation
range(mtcars$mpg)
quantile(mtcars$mpg)
# For a categorical variable, get a frequency table
table(mtcars$cyl)
# Get proportions instead of counts
prop.table(table(mtcars$cyl))
# Check for ANY missing values in the entire dataset
any(is.na(mtcars))
# Check for missing values in a specific column
sum(is.na(mtcars$mpg)) # Count of NAs
# Get a complete summary of NAs per column (very useful!)
colSums(is.na(mtcars))
# Visualize missing data pattern (requires the 'naniar' package)
# install.packages("naniar")
library(naniar)
gg_miss_var(mtcars)
# Histogram for a single numeric variable
hist(mtcars$mpg)
# Boxplot to see distribution and outliers
boxplot(mtcars$mpg)
# Boxplot by group
boxplot(mpg ~ cyl, data = mtcars) # MPG for each number of cylinders

# Scatterplot to see relationship between two numeric variables
plot(mtcars$wt, mtcars$mpg) # Weight vs. Miles per Gallon
# Barplot for a categorical variable
barplot(table(mtcars$cyl))

# Install first if needed: install.packages("ggplot2")
library(ggplot2)

# Histogram
ggplot(mtcars, aes(x = mpg)) + geom_histogram(bins = 10)

# Boxplot
ggplot(mtcars, aes(x = factor(cyl), y = mpg)) + geom_boxplot()
# Scatterplot
ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point(size = 3)

library(corrplot)
# Calculate correlation matrix
cor_matrix <- cor(mtcars)

# Create the correlation plot
corrplot(cor_matrix, method = "number")


# Install first if needed: install.packages("dplyr")
library(dplyr)

# Get a overview for all columns
glimpse(mtcars)

# Summarize data by groups
mtcars %>%
  group_by(cyl) %>% # Group by number of cylinders
  summarise(
    count = n(), # Number of cars in each group
    avg_mpg = mean(mpg), # Average MPG
    sd_mpg = sd(mpg) # Standard Deviation of MPG
  )






# loas iris dataset----
# Load the iris dataset
data(iris)
# Assign it to a variable for easier typing (it's already loaded, but this is common)
df <- iris
# See the first 6 rows
head(iris)
# See the last 6 rows
tail(iris)
# Get the dimensions: Number of Rows and Columns
dim(iris) # 150 rows, 5 columns

# Get the column names
names(iris)
# Get a quick overview of the entire structure
str(iris)
View(iris)
# Check the class of the entire object
class(iris) # "data.frame"

# Check the data type of specific columns
class(iris$Sepal.Length) # "numeric"
class(iris$Species)      # "factor"
# Check the levels of the Species factor
levels(iris$Species)
# > [1] "setosa"     "versicolor" "virginica"
# Summary for all columns
summary(iris)
# Calculate the mean of each numeric column, grouped by Species
aggregate(. ~ Species, data = iris, FUN = mean)
# Check for ANY missing values in the entire dataset
any(is.na(iris)) # FALSE

# Get a complete summary of NAs per column
colSums(is.na(iris))
# All columns will show 0
# Histogram for a single numeric variable (e.g., Sepal Length)
hist(iris$Sepal.Length, main = "Distribution of Sepal Length")
# Boxplot to see distribution of Sepal Width by Species
boxplot(Sepal.Width ~ Species, data = iris,
        main = "Sepal Width by Species",
        col = c("red", "green", "blue"))

# Scatterplot to see relationship between Sepal Length and Width
plot(iris$Sepal.Length, iris$Sepal.Width,
     xlab = "Sepal Length", ylab = "Sepal Width",
     main = "Sepal Length vs. Sepal Width")

library(ggplot2)

# Histogram faceted by Species
ggplot(iris, aes(x = Sepal.Length, fill = Species)) +
  geom_histogram(bins = 15, alpha = 0.6) +
  facet_wrap(~Species) +
  ggtitle("Sepal Length Distribution by Species")

# Boxplot
ggplot(iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
  geom_boxplot() +
  ggtitle("Sepal Length by Species")


# Scatterplot colored by Species (very insightful!)
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point(size = 3, alpha = 0.7) +
  ggtitle("Sepal Length vs. Width Colored by Species")

# Pair Plot (SCATTERPLOT MATRIX) - Excellent for this dataset!
pairs(iris[, 1:4], col = iris$Species, pch = 16)

# Calculate correlation matrix for just the numeric columns (1:4)
cor_matrix <- cor(iris[, 1:4])
print(round(cor_matrix, 2)) # Round to 2 decimal places for readability

# Visualize the correlation matrix
library(corrplot)
corrplot(cor_matrix, method = "number", type = "upper")




# Load only dplyr and nothing else
library(dplyr)

# Then run your summarise code
iris %>%
  group_by(Species) %>%
  summarise(
    count = n(),
    avg_sepal_length = mean(Sepal.Length),
    min_sepal_length = min(Sepal.Length),
    max_sepal_length = max(Sepal.Length),
    sd_sepal_length = sd(Sepal.Length)
  )






#1.packages for data loading and data writting----
#2.packages for data manipulation or data wrangling/handling----
install.packages("dplyr")
?base::Logic
?Comparison
?base::Arithmetic


# tidyverse
install.packages("tidyverse")
library(tidyverse)

#lubridate
install.packages("lubridate")

#3.packages for data visualization----
install.packages("ggplot2")
library(ggplot2)


# Load the built-in dataset
data(mpg)
# Look at the data structure
View(mpg)
# plot


# Basic scatterplot (not very informative with categorical x-axis)
ggplot(data = mpg, aes(x = manufacturer, y = cty)) +
  geom_point()

#plotly
install.packages("plotly")
library(plotly)
plot_ly(midwest, x = ~percollege, color = ~state, type = "box")


#gganimate
install.packages("gganimate")
library(gganimate)

#ggpubr
install.packages("ggpubr")
library(ggpubr)
#heatmaply
install.packages("heatmaply")
library(heatmaply)
#d3heatmap

#rgl
install.packages("rgl") #3D

#leaflets
install.packages("leaflet") # map

#dygraphs
install.packages("dygraphs") # time series plots








#4.packages for color pallet----
install.packages("RColorBrewer")
library(RColorBrewer)










#5.packages for statistics and machine learning----
#6.packages for Reporting----

#rmarkdown
install.packages("rmarkdown")

#7.packages for systematic Review and meta----

install.packages("tidyverse")

#meta
install.packages("meta")

#metafor
install.packages("metafor")

#dmetar

install.packages("devtools")
devtools::install_github("mathiasharrer/dmetar")

#openxlsx
install.packages("openxlsx")












