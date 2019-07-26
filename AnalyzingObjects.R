ls()
load(file = "myobjects.RData")
ls()
mean_leavealone = mean(club.df$leavealone)
sd_leavealone = sd(club.df$leavealone)
ls()
save(list = ls(), file = 'myobjects.RData')

# Checking if this works as we intended.
rm(list = ls())
ls() # All gone
load(file = "myobjects.RData")
ls()
