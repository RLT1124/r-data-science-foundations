# library packages -----
library(readxl)

df <- read_excel("C:/Users/RAMESH/Downloads/Ramesh/projects/03_R_Project/01_Basic/titanic.xlsx")


# 1
View(df) # to view the dataframe

#2
str(df) # to see the structure of the dataframe

#3
summary(df) # to see the summary of the dataframe

#4
dim(df) # to see the dimensions of the dataframe

#5
head(df) # to see the first 6 rows of the dataframe

#6 
tail(df) # to see the last 6 rows of the dataframe

#7
nrow(df) # to see the number of rows in the dataframe

#8
ncol(df) # to see the number of columns in the dataframe

#9
colnames(df) # to see the column names of the dataframe
row.names(df) # to see the row names of the dataframe

#10
class(df$Pclass) # to see the class of the dataframe
class(df$Sex) # to see the class of the dataframe
sapply(df, class) # to see the class of each column in the dataframe

#11
levels(df$Pclass) 
# make pclass as factor
df$pclass <- as.factor(df$pclass)

#12
is.na(df) # to see the missing values in the dataframe
sum(is.na(df)) # to see the total missing values in the dataframe)
sum(is.na(df$Age)) # to see the total missing values in the age column

#13
colSums(is.na(df)) # to see the missing values in each column of the dataframe

#14
duplicated(df) # to see the duplicated rows in the dataframe

#15
sum(duplicated(df)) # to see the total duplicated rows in the dataframe

#16
df_first_class <- subset(df, class == "First") # to subset the dataframe based on the condition

#17
sort(df$Age) # to sort the age column in the dataframe
sort(df$Pclass)
min(df$Age, na.rm = TRUE) # to see the minimum value in the age column
max(df$Age, na.rm = TRUE) # to see the maximum value in the age column

#18
df[order(df$Age),] # to sort the dataframe based on the age column
df_ordered_Pclass <- df[order(df$Pclass), ]

#19
mean(df$Age, na.rm = TRUE) # to see the mean of the age column

#20
median(df$Age, na.rm = TRUE) # to see the median of the age column

#21
sd(df$Age, na.rm = TRUE) # to see the standard deviation of the age column
se <- sd(df$Age, na.rm = TRUE)/sqrt(nrow(df)) # to see the standard error of the age column

#22
quantile(df$Age, na.rm = TRUE) # to see the quantiles of the age column
# inter quartile range
IQR(df$Age, na.rm = TRUE)

#23
range(df$Age, na.rm = TRUE) # to see the range of the age column

### Categorical Variables frequencies
#24
table(df$Class) # to see the frequency of each class in the class column
table(df$Sex) # to see the frequency
table(df$who) # to see the frequency
table(df$embarked) # to see the frequency

#25
length(df) # to see the length of the dataframe
length(df$Sex) # to see


#26
length(unique(df$Sex)) # to see the number of unique values in sex
length(unique(df$Class)) # to see the number of unique values in 
length(unique(df$Age))
length(unique(df$Embarked))


#27
prop.table(table(df$Pclass)) # to see the proportion of each class in the class column
# find percentage of each class
prop.table(table(df$Pclass))*100

#28
cor(df$Age, df$Fare, use = "complete.obs") # to see the correlation between age and fare
cor(df$Age, df$Fare, use = "pairwise.complete.obs") # to see the correlation between age and fare
#29
hist(df$Age) # to see the histogram of  the age column

#30 
boxplot(df$Age) # to see the boxplot of the age column

plot(df)
