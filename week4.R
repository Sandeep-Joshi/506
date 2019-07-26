# Matrices and dataframes

# Creating three vectors (value lists)
x <- 1:5
y <- 6:10
z <- 11:15

# Create a matrix where x, y and z are columns
cbind(x, y, z)

# Create a matrix where x, y and z are rows
rbind(x, y, z)

# A matrix will only support one datatype. If there's a character column in there it will turn all to character.
cbind(c(1, 2, 3, 4, 5),
      c("a", "b", "c", "d", "e"))

# 1,2,3,4.. numeric is converted to character.

# Using Matrix to create matrix 5 x 2
matrix(data = 1:10, nrow = 5, ncol = 2)

# Using Matrix to create matrix 2 x 5
matrix(data = 1:10, nrow = 2, ncol = 5)

# By default this is bycolumn but we can switch it. Numbers fill up differently if we switch this.
matrix(data = 1:10, nrow = 2, ncol = 5, byrow = TRUE)


# Creating dataframe
survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "sex" = c("m", "m", "m", "f", "f"),
                     "age" = c(99, 46, 23, 54, 23))
survey


# Show the structure of the survey dataframe with factors
str(survey)


# Create a dataframe of survey data WITHOUT factors. Factors are otherwise created by itself for character columns
survey2 <- data.frame("index" = c(1, 2, 3, 4, 5),
                      "sex" = c("m", "m", "m", "f", "f"),
                      "age" = c(99, 46, 23, 54, 23),
                      stringsAsFactors = FALSE)

survey2
# Show the structure of the survey dataframe without factors
str(survey2)


# Review the data - Head, tail and View - which opens data in a new data visulaization excel type window
head(ChickWeight)
tail(ChickWeight)
View(ChickWeight)

# get the summary of data
summary(ToothGrowth)
# show the structure of data
str(ToothGrowth)

# get column names
names(ToothGrowth)
# show all the column
ToothGrowth$len

# mean of the len of ToothGrowth
mean(ToothGrowth$len)

# Gives us frequency of values.
table(ToothGrowth$supp)

# show only top rows of dataset but only columns len and supp
head(ToothGrowth[c("len", "supp")])

# Create survey dataframe with two columns - index and age and add another column sex to it.
survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "age" = c(24, 25, 42, 56, 22))
survey
survey$sex <- c("m", "m", "f", "f", "m")
# review the dataframe to check new column added
survey


# Change name of 1st column of df to "a"
names(survey)[1] <- "a"

# Change name of 2nd column of df to "b"
names(survey)[2] <- "b"
survey
names(survey)[1] <- "participant.number"
survey

# Changing the column name of b to years
names(survey)[names(survey) == "b"] <- "years"
survey



# Some other dataframe slicing.
df = survey

# Return row 1
df[1, ]

# Return column 2
df[, 2]

# Rows 1:3 and column 2
df[1:3, 2]


# Give me the rows 1-6 and column 1 of ToothGrowth
ToothGrowth[1:6, 1]

# Give me rows 1-3 and columns 1 and 3 of ToothGrowth
ToothGrowth[1:3, c(1,3)]

# Return df row 1 and later col 2
ToothGrowth[1, ]
ToothGrowth[, 2]

# Getting only the supp == VC data to new DF
ToothGrowth.VC <- ToothGrowth[ToothGrowth$supp == "VC", ]

# Getting only the supp == OJ and Dose < 1 data to new DF
ToothGrowth.OJ.a <- ToothGrowth[ToothGrowth$supp == "OJ" &
                                ToothGrowth$dose < 1, ]

# Using subset to filter data
subset(x = ToothGrowth,
       subset = len < 20 &
       supp == "OJ" &
       dose >= 1)

# Get rows of ToothGrowth where len > 30 AND supp == "VC", but only return the len and dose columns
subset(x = ToothGrowth,
       subset = len > 30 & supp == "VC",
       select = c(len, dose))

oj <- subset(x = ToothGrowth,
             subset = supp == "OJ")
mean(oj$len)

oj <- ToothGrowth[ToothGrowth$supp == "OJ",]
mean(oj$len)


mean(ToothGrowth$len[ToothGrowth$supp == "OJ"])


# Create new datafrom health
health <- data.frame("age" = c(32, 24, 43, 19, 43),
                     "height" = c(1.75, 1.65, 1.50, 1.92, 1.80),
                     "weight" = c(70, 65, 62, 79, 85))
health

# Calculate bmi i.e. Weight/ (Height^2)
health$weight / health$height ^ 2

# Save typing by using with()
with(health, height / weight ^ 2)

# Long code
health$weight + health$height / health$age + 2 * health$height

# Short code that does the same thing
with(health, weight + height / age + 2 * height)



## Extra practice

# Combine the data into a single dataframe. Complete all the following exercises from the dataframe!
name <- c('Astrid', 'Lea', 'Sarina', 'Remon', 'Letizia', 'Babice', 'Jonas', 'Wendy', 'Niveditha', 'Gioia')
sex <- c('F', 'F', 'F', 'M', 'F', 'F', 'M',  'F', 'F', 'F')
age <- c(30, 25, 25, 29, 22, 22, 35, 19, 32, 21)
superhero <- c('Batman', 'Superman', 'Batman', 'Spiderman', 'Batman', 'Antman', 'Batman', 'Superman', 'Maggott', 'Superman')
tattoos <- c(11, 15, 12, 5, 65, 3, 9, 13, 900, 0)

hero.df <- data.frame(name = name, sex = sex, age = age, superhero = superhero, tattoos = tattoos)

# What is the median age of the 10 pirates?
mean(hero.df[,'age'])
  
# What was the mean age of female and male pirates separately?
mean(hero.df[hero.df$sex == "F", ]$age)
mean(hero.df[hero.df$sex == "M", ]$age)
  
# What was the most number of tattoos owned by a male pirate?
max(hero.df[hero.df$sex == "M", ]$tattoos)

# What percent of pirates under the age of 32 were female?
100 * nrow(hero.df[hero.df$sex == "F" & 
             hero.df$age < 32, ])/nrow(hero.df[hero.df$age < 32,])
  
# What percent of female pirates are under the age of 32?
100 * nrow(hero.df[hero.df$sex == "F" & 
                     hero.df$age < 32, ])/nrow(hero.df[hero.df$sex == "F",])

# Add a new column to the dataframe called tattoos.per.year which shows how many tattoos each pirate has for each year in their life.
hero.df$tattoos.per.year <- hero.df$tattoos / hero.df$age
hero.df

# Which pirate had the most number of tattoos per year?
hero.df[order(-hero.df$tattoos.per.year),][1,]$name

# What are the names of the female pirates whose favorite superhero is Superman?
hero.df[hero.df$sex == "F" & 
        hero.df$superhero == "Superman", ]$name

# What was the median number of tattoos of pirates over the age of 20 whose favorite superhero is Spiderman?
median(hero.df[hero.df$age > 20 & 
               hero.df$superhero == "Spiderman", ]$tattoos)
