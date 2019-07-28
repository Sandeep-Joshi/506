library(tidyverse)
table1
table2
table4a
table4b

# Add rate per 10k column where rate = 10k * cases/ population
table1 %>% 
  mutate(rate = 10000 *cases / population )

# Cases per year
table1 %>% 
  count(year, wt = cases)

# Visualise changes over time
library(ggplot2)
ggplot(table1, aes(year, cases)) + 
  geom_line(aes(group = country), colour = "grey50") + 
  geom_point(aes(colour = country))

# Exercises 12.2.1

# Using prose, describe how the variables and observations are organised in each of the sample tables.
# Table1: Country and case in rows shows values for Cases and population in columns
# Table2: Country, year and type (cases and population) in row and respective number in column.
# Table3: Country and year in row shows rate (as cases/population) in column.
# Table4a: Country in row shows case in columns for two different years. 
#          Here column names have values.
# Table4b: Country in row shows population in columns for two different years. 
#          Here column names have values.

# Compute the rate for table2, and table4a + table4b. You will need to perform four operations:
# Extract the number of TB cases per country per year.
# Extract the matching population per country per year.
# Divide cases by population, and multiply by 10000.
# Store back in the appropriate place.

# Table2:
require(dplyr)
cases <- table2 %>% filter(type == "cases") %>% rename(cases = count) 
pops <- table2 %>% filter(type == "population") %>% rename(population = count) 

table2_df <- data.frame(country = cases$country,
                        year = cases$year,
                        cases = cases$cases,
                        population = pops$population) %>% mutate(rate = (cases / population) * 10000)
table2_df

# Table 4. A contains cases and b populations. This is what we had after we made first filter step above.
# so it should take atleast one lesser step
table4_df <- data.frame(country = table4b$country,
                        `1999` = table4a[["1999"]] / table4b[["1999"]] * 10000,
                        `2000` = table4a[["2000"]] / table4b[["2000"]] * 10000)
table4_df

# Which representation is easiest to work with? Which is hardest? Why?
# Table4 seemed easier as explained above.

# Recreate the plot showing change in cases over time using table2 instead of table1. 
table2 %>%
  filter(type == "cases") %>%
  ggplot(aes(year, count)) +
  geom_line(aes(group = country), colour = "grey50") +
  geom_point(aes(colour = country)) +
  ylab("cases")

# What do you need to do first?
# We need to filter for only cases rows as opposed to using table1


# Gather converts values in columns to rows.
tidy4a <- table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")

tidy4b <- table4b %>% 
  gather(`1999`, `2000`, key = "year", value = "population")

# We get same as table1
left_join(tidy4a, tidy4b)


# Spreading does the opposite of gathering, so we spread the column type i.e. case and population with
# value from count.
table2 %>%
  spread(key = type, value = count)

# 12.3.3 Exercises
# Why are gather() and spread() not perfectly symmetrical?
#  Carefully consider the following example:
  
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  spread(year, return) %>% 
  gather("year", "return", `2015`:`2016`)

# We can see that from output year has converted from double to character as it was used in gather function
# so we may lose some information.

# Why does this code fail?
  
table4a %>% 
gather(1999, 2000, key = "year", value = "cases")

# The fixed code.
table4a %>% 
gather(`1999`, `2000`, key = "year", value = "cases")

# Earlier attempt fails as gather tries to interpret the column names as numeric values as access it by index
# we need to anotate our intention of making R not read it as numeric by using `

#Why does spreading this tibble fail? How could you add a new column to fix the problem?
  
people <- tribble(
  ~name,             ~key,    ~value,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)
spread(people, key, value)
# this fails with error "Do you need to create unique ID with tibble::rowid_to_column()?" as there're
# two Phillip Woods age combination. We can add another id count to make a unique combination to fix it

people <- people %>%
  group_by(name, key) %>%
  mutate(obs = row_number())
spread(people, key, value)
# now it works with NA in height for second Phillips wood.

# Tidy the simple tibble below. Do you need to spread or gather it? What are the variables?
  
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)
# we need to gather it so..
preg2 <- preg %>% gather(male, female, key = "gender", value = "count")
preg2

# Separate
table3 %>% 
  separate(rate, into = c("cases", "population"))
table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/")
table3 %>% 
  separate(rate, into = c("cases", "population"), convert = TRUE)
table3 %>% 
  separate(year, into = c("century", "year"), sep = 2)

# unite
table5 %>% 
  unite(new, century, year)
table5 %>% 
  unite(new, century, year, sep = "")

# 12.4.3 Exercises
# What do the extra and fill arguments do in separate()? 
# Extra: If sep is a character vector, this controls what happens when there are too many pieces. 
# There are three valid options: warn (warns and drops), drop (drops w/o warn), merge.
# Experiment with the various options for the following two toy datasets.

# Fill: If sep is a character vector, this controls what happens when there are not enough pieces. 
# There are three valid options: warn (warm and fill from right), right (fill from right), 
#                                left (fill from left)

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

tibble(x = c("a,b,c", "d,e", "f,g,i")) %>% 
  separate(x, c("one", "two", "three"))


# Both unite() and separate() have a remove argument. What does it do? Why would you set it to FALSE?
# The `remove` argument removes input columns from the output data frame.
# We would set it to `FALSE` if we want to create a new variable, but keep the old one.
  
# Compare and contrast separate() and extract(). Why are there three variations of separation 
# (by position, by separator, and with groups), but only one unite?

# The function `separate()`, splits a column into multiple columns by a separator, 
# if `sep` argument can be character vector, or character positions.

# The function `extract()` uses a regular expression to specify groups in character vector and 
# split that single character vector into multiple columns using those regexes.

# This is more flexible than `separate()` because it does not require a common
# separator or specific column positions.

# unite converts many columns to one, with a choice of a separator to include between column values so
# we do not need as many options there.

  

# Missing values
stocks <- tibble(
  year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr    = c(   1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
)
stocks %>% 
  spread(year, return)
stocks %>% 
  spread(year, return) %>% 
  gather(year, return, `2015`:`2016`, na.rm = TRUE)
stocks %>% 
  complete(year, qtr)


treatment <- tribble(
  ~ person,           ~ treatment, ~response,
  "Derrick Whitmore", 1,           7,
  NA,                 2,           10,
  NA,                 3,           9,
  "Katherine Burke",  1,           4
)

treatment %>% 
  fill(person)

# 12.5.1 Exercises
# Compare and contrast the fill arguments to spread() and complete().

# spread: the fill argument explicitly sets the value to replace `NA`s.
# complete: the fill argument also sets a value to replace `NA`s but it is named list, 
# allowing for different values for different variables.
# both cases replace both implicit and explicit missing values.

# What does the direction argument to fill() do?
# direction determines whether `NA` values should be replaced by the non-missing values from down (prev)
# or non-missing value from up (next).

# Tiding WHO dataset
who
who1 <- who %>% 
  gather(new_sp_m014:newrel_f65, key = "key", value = "cases", na.rm = TRUE)
who1
who1 %>% 
  count(key)

who2 <- who1 %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))
who2

who3 <- who2 %>% 
  separate(key, c("new", "type", "sexage"), sep = "_")
who3

who3 %>% 
  count(new)
who4 <- who3 %>% 
  select(-new, -iso2, -iso3)

who5 <- who4 %>% 
  separate(sexage, c("sex", "age"), sep = 1)
who5

who %>%
  gather(key, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel")) %>%
  separate(key, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)


# 12.6.1 Exercises
# In this case study I set na.rm = TRUE just to make it easier to check that we had the correct values. 
# Is this reasonable? Think about how missing values are represented in this dataset. 
# Are there implicit missing values? What’s the difference between an NA and zero?

# We need to understand the distinction between lack of data or where cases were genuinely 0. We can see
# if data indeed shows other countries with verifiable 0 cases or not.
# We need to know if NA is implicit as country with no population wouldn't have it or explicit.
  

# What happens if you neglect the mutate() step? (mutate(key = stringr::str_replace(key, "newrel", "new_rel")))

# The next step gives warning for too few values. Some values are missing in the dataset if we omit that.


# I claimed that iso2 and iso3 were redundant with country. Confirm this claim.

# The following code will give us non distinct combination for country and iso2 and iso3. And we get 0
# so this is valid.
select(who, country, iso2, iso3) %>%
  distinct() %>%
  group_by(country) %>%
  filter(n() > 1)

# For each country, year, and sex compute the total number of cases of TB. 
# Make an informative visualisation of the data.
who5 %>%
  group_by(country, year, sex) %>%
  summarise(cases = sum(cases)) %>%
  unite(country_sex, country, sex, remove = FALSE) %>%
  ggplot(aes(x = year, y = cases, group = country_sex, colour = sex)) +
  geom_line()

