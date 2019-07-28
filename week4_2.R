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

# Exercises 20.3.5
# Describe the difference between is.finite(x) and !is.infinite(x).
# is.finite() is evalutated to true for all non-missing numeric values whereas, !is.infinite() would
# evaluate true for all things other than -Inf and Inf. So missing values are not considered finite
# but they are considered not-infinite. This is more evident below.
x <- c(0, NA, NaN, Inf, -Inf)
is.finite(x)
# Gives TRUE FALSE FALSE FALSE FALSE
!is.infinite(x)
# gives TRUE  TRUE  TRUE FALSE FALSE

# Read the source code for dplyr::near() (Hint: to see the source code, drop the ()). How does it work?
dplyr::near
# Code take in effect a tolerance which can be configurable but defaulted to .Machine$double.eps^0.5 i.e
# ~ 1.490116e-08 and if diff of number is below this they are evaluated to be near.

# A logical vector can take 3 possible values. How many possible values can an integer vector take? 
#How many possible values can a double take? Use google to do some research.
# For int: 2^32
# For double: 2^64

# Brainstorm at least four functions that allow you to convert a double to an integer. 
#How do they differ? Be precise.
# round with digits=0: Round rounds it to given decimal places so with 0 we will end up with integer
# ceiling: Ceiling rounds it to smallest whole number larger that the current number
# floor: Floor rounds it to the largest whole number just lesser than current number
# trunc: truncation just removes the decimal places to end up with integer.
# signif with digits = number of non decimal places. i.e. 1234.56 with signif = 4 would get us 1235

# What functions from the readr package allow you to turn a string into logical, integer, and 
#double vector?
# parse_logical, parse_integer, parse_number, respectively. P.S. parse_number and parse_integer works
# similarly but parse_number are more forgiving.

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


# 20.4.6 Exercises
# What does mean(is.na(x)) tell you about a vector x? What about sum(!is.finite(x))?
# mean(is.na(x)) gives average number of missing values - ie. NaN and NA in the series
# sum(!is.finite(x)) gives us total number of 
  
# Carefully read the documentation of is.vector(). What does it actually test for? 
# Why does is.atomic() not agree with the definition of atomic vectors above?

# is.vector checks for data type where we can specify the mode which is primitive datatypes.
# is.atomic checks for primitive atomic types - logical, integer, numeric, complex, character and raw.
# difference between the two is that vectors are list of same datatype, if they hold additional data types
# then it's no longer vector but it still can be atomic if these all elements are atomic.


# Compare and contrast setNames() with purrr::set_names().
# set_names is more enhanced and have more tools, it is based on setNames but with more options and 
# stricter argument validations.

# Create functions that take a vector as input and returns:
  
#  1. The last value. Should you use [ or [[?
last_value <- function(x) {
  if (is.vector(x)){
    if(length(x) > 0){
      x[[length(x)]]  # We use [[ and not [
    } else {
      cat("0 length")
      x
    }
    
  } else {
    cat("Not a vector")
    x
  }
}

#  2. The elements at even numbered positions.
even_positions <- function(x) {
  if (length(x)>1) {
    x[seq(2,length(x), by=2)]
  } else {
    cat("Length should atleast be 2")
    x
  }
}                                        

#  3. Every element except the last value.
minus_last <- function(x) {
  if (length(x)>0) {
    x[-length(x)]
  } else {
    cat("Not enough elements")
    x
  }
}                                

#  4. Only even numbers (and no missing values).
even_wo_missing <- function(x) {
  x <- even_positions(x)
  x[!is.nan(x) & !is.na(x)]
} 

# Why is x[-which(x > 0)] not the same as x[x <= 0]?
# First one gives us all elements in x which are negative subset of x greater than 0 so all elements
# less than 0 or 0.
# The second one gives us all elements of x which are less than or equal to 0.
# So in essence they produce exactly same results for all finite or non missing values.
# let's check for Missing or NAN values
x <- c(-3:3, 'a','b', NaN, NA, Inf, -Inf)
x[-which(x > 0)]
# yields "-3"   "-2"   "-1"   "0"    NA     "-Inf"
x[x <= 0]
# yields "-3"   "-2"   "-1"   "0"    NA     "-Inf"

# So it seems both of these yields same results.
        
# What happens when you subset with a positive integer that’s bigger than the length of the vector? 
x <- c(1:3)
x[4:5]
# this yields NA NA, so we get the subset of NA values for all the values which are not fulfilled by 
# original vector

# What happens when you subset with a name that doesn’t exist?
x <- c(a=1, b=2, c=3)
x[['a']]
x[['z']] # We get subscript out of bounds error but for
x['z'] # we get <NA> NA

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

# 20.5.4 Exercises
# Draw the following lists as nested sets:
  
# list(a, b, list(c, d), list(e, f))
#  ______
# |  a  |
# |  b  |
# |[c,d]|
# |[e,f]|
# ______

# list(list(list(list(list(list(a))))))
#   ____________
#  |[[[[[a]]]]]|
#  ____________

# What happens if you subset a tibble as if you’re subsetting a list? 
# Tibbles can be subsetted just like a list. so these are spliced and manipulated alike.

# What are the key differences between a list and a tibble?
# A list may have different data types a tibble is homogenous.

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
x # this prints time in format of HR:MM:SS
# this is double
typeof(x)

# following fails as we cannot make tibble of varying lengths. I would conclude due to indeterminate
# size of a list we cannot make lists inside a tibble.
tibble::tibble(x = 1:5, y = 1:2)

# Based on the definition above, is it ok to have a list as a column of a tibble?
tibble(x = 1:3, y = list("a", "b", 2))
# it works so we can have it till they are of same length.
       