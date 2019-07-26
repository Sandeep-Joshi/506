# install.packages("readr")
library(readr)

# 
data <- read_csv("US EPA data 2017.csv")

# Removing spaces from column names
names(data) <- make.names(names(data))
# We can see that spaces have been replaced by .
names(data)

# Total rows
nrow(data)

# Total columns
ncol(data)

# This gives the structure of all the data (columns)
str(data)

# head and tail are like in bash to peak at the top and bottom rows.

# here we dissect data to get 6th, 7th and 10th columns and show top rows
head(data[, c(6:7, 10)])

# here we dissect data to get 6th, 7th and 10th columns and show bottom rows
tail(data[, c(6:7, 10)])

table(data$Sample.Duration)


# Manipulations using DPLYR
library(dplyr)

# Using Filter and Select operations of Dplyr
filter(data, Arithmetic.Mean >= 0.0401) %>% 
  select(State.Name, County.Name, CBSA.Name, Sample.Duration)

# Using Conjugated Filters and Select operations of Dplyr and finally convert it to a dataframe
filter(data, State.Code == "36" & 
         County.Code == "033" & 
         Date.Local == "2014-09-30") %>%
  select(Date.Local, Time.Local, Sample.Measurement) %>% 
  as.data.frame

# Select single column State.Name and find the number of uniques
select(data, State.Name) %>% unique %>% nrow

# Listing all the uniques state.names without dplyr
unique(data$State.Name)

# Finding 5 point summary for any numeric column
summary(data$Observation.Percent)

# Finding all quantiles at separation of .1 i.e. 10%
quantile(data$Observation.Percent, seq(0, 1, 0.1))

# To find the highest average Observation.Percent by State and county.
ranking <- group_by(data, State.Name, County.Name) %>%
  summarize(data = mean(Observation.Percent)) %>%
  as.data.frame %>%
  arrange(desc(data))
ranking

# Top 10 counties with Observation.Percent 
head(ranking, 10)

# Bottom 10 counties with Observation.Percent 
tail(ranking, 10)

# count observations from County Mariposa in California
filter(data, State.Name == "California" & County.Name == "Mariposa") %>% nrow

# Some more Dplyr Flex: Mutation
data <- mutate(data, Date.of.Last.Change = as.Date(Date.of.Last.Change))

# Find monthly mean of Observation.Percent of all observations from County Mariposa in California
filter(data, State.Name == "California" & County.Name == "Mariposa") %>%
  mutate(month = factor(months(Date.of.Last.Change), levels = month.name)) %>%
  group_by(month) %>%
  summarize(data = mean(Observation.Percent))

# Set is seed to make sure we get same data sets for sample
set.seed(10234)
N <- nrow(data)
# we make a random index for the dataset
idx <- sample(N, N, replace = TRUE)
# dataset randomly picked out of earlier dataset
data2 <- data[idx, ]

# In effect we randomized the earlier dataset and re ranked them based on Observation.Percent by counties
ranking2 <- group_by(data2, State.Name, County.Name) %>%
  summarize(data2 = mean(Observation.Percent)) %>%
  as.data.frame %>%
  arrange(desc(data2))


# We compare the top and the bottom 10 rows of two datasets which are same.
# Cbind is used to column bind and make new DF
cbind(head(ranking, 10), head(ranking2, 10))
cbind(tail(ranking, 10), tail(ranking2, 10))