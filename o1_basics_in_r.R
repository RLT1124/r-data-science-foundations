### basic arithmatic operation----
2+3  # we add 2+3
# we will add x in y
x=2
y=3
x+y
x*y
x-y
y-x
x/y
### some other oparators----
a<-2
b<- 4+2
b
print(b)
a*2+b-(3*2)/20
num_vector <- c(1,2,3,4,5)
num_vector

char_vector <-c("ramesh","suresh","ankush")
char_vector


df <- data.frame(
  product = c("Apple", "Banana", "Orange"),
  price = c(1.00, 0.50, 0.75),
  in_stock = c(TRUE, FALSE, TRUE)
)

print(df)


# Create a vector of 12 numbers
my_data <- 1:12

# Create a 3x4 matrix (fills down each column first)
mat <- matrix(
  data = my_data, 
  nrow = 3, 
  ncol = 4)
print(mat)



# Create a 2x3 array (2 rows, 3 columns)
arr_2d <- array(
  data = 1:6, 
  dim = c(2, 3))
print(arr_2d)





# Create a simple list with different data types
my_list <- list(
  "Alice",         # Character element
  25,              # Numeric element
  TRUE,            # Logical element
  c("New York", "London") # A vector as an element
)

print(my_list)


seq(1,10)

seq(1,100 ,by=5 )


# Create 5 numbers evenly spaced from 0 to 10
seq_result <- seq(from = 0, to = 10, length.out = 5)
print(seq_result)














