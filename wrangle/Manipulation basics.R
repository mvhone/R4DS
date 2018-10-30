# https://r4ds.had.co.nz/transform.html#filter-rows-with-filter

library(tidyverse)
library(nycflights13)

filter(flights, month == 1, day == 1)

jan1 <- filter(flights, month == 1, day == 1)

(dec25 <- filter(flights, month == 12, day == 25))

filter(flights, month == 11 | month == 12)

nov_dec <- filter(flights, month %in% c(11, 12))

filter(flights, !(arr_delay > 120 | dep_delay > 120))

filter(flights, arr_delay <= 120, dep_delay <= 120) # same as previous

x <- NA

is.na(x)

df <- tibble(x = c(1, NA, 3))

filter(df, x > 1)
filter(df, is.na(x) | x > 1)

# Exercises
# 5.2.4.1

one <- filter(flights, arr_delay >= 120)
one$arr_delay

two <- filter(flights, dest %in% c("IAH", "HOU"))
two$dest

airlines
three <- filter(flights, carrier %in% c("UA", "AA", "DL"))
three$carrier

four <- filter(flights, month %in% c(7, 8, 9))
four$month

five <- filter(flights, arr_delay > 120 & dep_delay < 120)
five

six <- filter(flights, dep_delay >= 60 & (dep_delay - arr_delay) > 30)
six

summary(flights$dep_time)
seven <- filter(flights, dep_time == 2400 | dep_time <= 600)
seven$dep_time

eight <- filter(flights, between(dep_time, 0, 600))
eight$dep_time

nine <- filter(flights, is.na(dep_time))
nine
