# practicing R vectors

library(tidyverse)

# Typeof is used to find the R data type
typeof(letters)
typeof(1:10)

# Length is to determine the lenght of list-types in R
x <- list("a", "b", 1:10)
length(x)

# logical type in R. Below would give us if numbers 1 to 10 are divisible by 3 or not
1:10 %% 3 == 0
# NA is also a valid boolean type
c(TRUE, TRUE, FALSE, NA)


# By default numeric is double
typeof(1)

# Adding L makes it an integer
typeof(1L)

x <- sqrt(2) ^ 2
# this gives 2
x
x - 2
# this gives approximation of 0
x
x <- sqrt(2) ^ 2
typeof(sqrt(2) ^ 2)

c(-1, 0, 1) / 0
# -Inf  NaN  Inf

install.packages("pryr")
x <- "This is a reasonably long string."
pryr::object_size(x)

y <- rep(x, 1000)
pryr::object_size(y)
# by this excercise we see that y doesn't take 1000 times memory of x as we just make 1000 pointers point to one character location instead

# Missing values in R
typeof(NA) # logical
typeof(NA_integer_) # Integer
typeof(NA_real_) # double
typeof(NA_character_) # character


x <- sample(20, 100, replace = TRUE)
y <- x > 10 # Gives vector/ list of each sample greater than or not 
sum(y)  # how many are greater than 10?
mean(y) # what proportion are greater than 10?

# We see below how R adapts the vector to integer in case 1, double in case 2 and character in 3. 
typeof(c(TRUE, 1L))
typeof(c(1L, 1.5))
typeof(c(1.5, "a"))


# sample creates a randomized list from 1 to 10 and + 100 adds 100 to each element of those list
sample(10) + 100
# creates a logical list where condition is true or not for each element
runif(10) > 0.5

# Adds the repeat of 1,2 to list 1..10 so 1,2,1,2,1,2,1,2,1,2 gets added to 1,2,3,4,5..10
1:10 + 1:2
# This fails as larger list is not a multiple of shorter list
1:10 + 1:3


# Tibbles
# fails as x and y don't have same lengths
tibble(x = 1:4, y = 1:2)
# Fixed as y is now same length as x
tibble(x = 1:4, y = rep(1:2, 2))
# each is used where we want element in rep to be repeated and not the pattern collectively
tibble(x = 1:4, y = rep(1:2, each = 2))

# Vector names
c(x = 1, y = 2, z = 4)
install.packages("purrr")
purrr::set_names(1:3, c("a", "b", "c"))

# Subsetting
x <- c("one", "two", "three", "four", "five")
# Positional index access
x[c(3, 2, 5)]
x[c(1, 1, 5, 5, 5, 2)]

# Using negative values drop out that indexed element
x[c(-1, -3, -5)]

# This yields error as we are adding and removing same index
x[c(1, -1)]

# These yield NA as indexes are invalid for x
x[0]
x[7]


x <- c(10, 3, NA, 5, 8, 1, NA)
x
# Removing NA values
x[!is.na(x)]

# All even (or missing!) values of x
x[x %% 2 == 0]

# If you have a named vector, you can subset it with a character vector:
x <- c(abc = 1, def = 2, xyz = 5)
x[c("xyz", "def")]



# Recursive vectors (lists). As lists can contain another lists
x <- list(1, 2, 3)
x
str(x)

# making named lists
x_named <- list(a = 1, b = 2, c = 3)
str(x_named)

# Lists with different types. Lists do not adapt to character like matrices
y <- list("a", 1L, 1.5, TRUE)
str(y)

# This creates nested lists.
z <- list(list(1, 2), list(3, 4))
str(z)

# another sophisticated lists
a <- list(a = 1:3, b = "a string", c = pi, d = list(-1, -5))

# Accessing elements of the list
str(a[1:2])
str(a[4])

# accessing by name
a$a
# This takes two un-zipping.
a[["a"]]



x <- 1:10

# attr is to access the element of an object. There's no element called greeting so we get NULL
attr(x, "greeting")

# adding new elements to the x with names greeting and farewell
attr(x, "greeting") <- "Hi!"
attr(x, "farewell") <- "Bye!"

# Shows all elements in x
attributes(x)

# get different implementation of function as.Date
methods("as.Date")

# get s3 specific methods
getS3method("as.Date", "default")
getS3method("as.Date", "numeric")

# Factors and levels for categorical datas
x <- factor(c("ab", "cd", "ab"), levels = c("ab", "cd", "ef"))
typeof(x)
attributes(x)


x <- as.Date("1971-01-01")
# shows the days from start set date posix. 1 January 1970.
unclass(x)
typeof(x)
attributes(x)


x <- lubridate::ymd_hm("1970-01-01 01:00")
# using this method gives timezone and datestamp
unclass(x)

typeof(x)
attributes(x)


# Using different Timezones
attr(x, "tzone") <- "US/Pacific"
x
attr(x, "tzone") <- "US/Eastern"
x


y <- as.POSIXlt(x)
typeof(y)
attributes(y)


# Tibbles are special matrices which can hold different datatypes but with same length
tb <- tibble::tibble(x = 1:5, y = 5:1)
typeof(tb)
attributes(tb)


df <- data.frame(x = 1:5, y = 5:1)
typeof(df)
attributes(df)


# Practice questions

# This print 1 in hour. Takes 3600 seconds
x <- hms::hms(3600)
# this is double
typeof(x)

# following fails as we cannot make tibble of varying lengths. I would conclude due to indeterminate
# size of a list we cannot make lists inside a tibble.
tibble::tibble(x = 1:5, y = 1:2)
