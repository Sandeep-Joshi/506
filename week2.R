# Setting working directory
setwd("/Users/sandeep.joshi/Desktop/MS ANLY/506/506")
# Verifying working directory
getwd()

# Print objects in current environment
ls()

# Clearing environment
rm(list=ls())

# check a variable which isn't there anymore
study1.df

# Create few dataframes
study1.df <- data.frame(id = 1:5, sex = c("m", "m", "f", "f", "m"), score = c(51, 20, 67, 52, 42))
study1.df

score.by.sex <- aggregate(score ~ sex, FUN = mean, data = study1.df)
score.by.sex

study1.htest <- t.test(score ~ sex, data = study1.df)
study1.htest

# Saving the data created above
save(study1.df, score.by.sex, study1.htest, file = "data/study1.RData")

# Save all the environment
save.image(file = "data/projectimage.RData")

# Deleting the data
rm(list=ls())
ls()

# Load objects in study1.RData into my workspace
load(file = "data/study1.RData")

# Load objects in projectimage.RData into my workspace
load(file = "data/projectimage.RData")

# Write the data as tab separated file
write.table(x = pirates, file = "study_tab_separated.txt", sep = "\t")            # Make the columns tab-delimited

# read the file just created
mydata <- read.table(file = 'data/mydata.txt',    # file is in a data folder in my working directory
                     sep = '\t',                  # file is tab--delimited
                     header = TRUE,               # the first row of the data is a header row
                     stringsAsFactors = FALSE)    # do NOT convert strings to factors!!

# Reading file directly from URL
fromweb <- read.table(file = 'http://goo.gl/jTNf6P',
                      sep = '\t',
                      header = TRUE)
# Show the data
fromweb


install.packages("foreign")
install.packages("xlsx")


# Extra practice from https://bookdown.org/ndphillips/YaRrr/test-your-r-might-3.html
a <- data.frame("sex" = c("m", "f", "m"),
                "age" = c(19, 43, 25),
                "favorite.movie" = c("Moon", "The Goonies", "Spice World"))
b <- mean(a$age)
c <- table(a$sex)
ls()
club.df <- read.table(file = 'http://nathanieldphillips.com/wp-content/uploads/2015/12/club.txt',
                      sep = '\t',
                      header = TRUE)

write.table(x = club.df, file = "club.txt", sep = "\t")
save(a, b, c, club.df, file = 'myobjects.RData')
rm(list = ls())
ls() # All gone

