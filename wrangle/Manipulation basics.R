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

--------------------------------------------------------------------------------
# https://r4ds.had.co.nz/transform.html#add-new-variables-with-mutate

library(tidyverse)
library(nycflights13)
  
flights_sml <- select(
  flights,
  year:day,
  ends_with("delay"),
  distance,
  air_time
)
mutate(flights_sml,
  gain = dep_delay - arr_delay,
  speed = distance / air_time * 60
)

mutate(flights_sml,
       gain = dep_delay - arr_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours
       ) 

transmute(flights,
          gain = dep_delay - arr_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
          )

transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100
) # breaks integers into pieces

# log2() interpretation - difference of 1 corresponds to doubling, -1 halving

#Exercises
# 5.5.2.1
transmute(flights,
  dep_time,
  sched_dep_time,
  mam_dep_time = ((dep_time %/% 100) * 60) + (dep_time %% 100),
  mam_sched_dep_time = ((sched_dep_time %/% 100) * 60) + (sched_dep_time %% 100)
)

#5.5.2.2
transmute(flights,
  air_time,
  dep_time,
  arr_time,
  calc_air_time = arr_time - dep_time
)

#5.5.3.3
select(flights, dep_time, sched_dep_time, dep_delay)

#5.5.3.4
flights_delayed <- mutate(flights, dep_delay_rank = min_rank(-dep_delay))
flights_delayed <- filter(flights_delayed, dep_delay_rank <= 20)
arrange(flights_delayed, dep_delay_rank)

--------------------------------------------------------------------------------
# https://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarise

library(tidyverse)
library(nycflights13)

summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

by_day <- group_by(flights, year, month, day)
by_day_mean <- summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))
arrange(by_day_mean, desc(delay))

by_dest <- group_by(flights, dest)
delay <- summarise(by_dest,
  count = n(),
  dist = mean(distance, na.rm = TRUE),
  delay = mean(arr_delay, na.rm = TRUE)
)
delay <- filter(delay, count > 20, dest != "HNL")

ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

# pipe method
delays <- flights %>%
  group_by(dest) %>%
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
  filter(count > 20, dest != "HNL")

not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>%
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay))

delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarise(
    delay = mean(arr_delay)
  )

ggplot(data = delays, mapping = aes(x = delay)) +
  geom_freqpoly(binwidth = 10)

delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarise(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )

ggplot(data = delays, mapping = aes(x = n, y = delay)) +
  geom_point(alpha = 1/10)

# dplyr and ggplot2
delays %>%
  filter(n > 100) %>%
  ggplot(mapping = aes(x = n, y = delay)) +
    geom_point(alpha = 1/10)

batting <- as_tibble(Lahman::Batting)

batters <- batting %>%
  group_by(playerID) %>%
  summarise(
    ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    ab = sum(AB, na.rm = TRUE)
  )

batters %>%
  filter(ab > 100) %>%
  ggplot(mapping = aes(x = ab, y = ba)) +
    geom_point() +
    geom_smooth(se = FALSE)

batters %>%
  arrange(desc(ba))

not_cancelled %>%
  group_by(year, month, day) %>%
  summarise(
    avg_delay1 = mean(arr_delay),
    avg_delay2 = mean(arr_delay[arr_delay > 0])
  )

daily <- group_by(flights, year, month, day)
(per_day <- summarise(daily, flights = n()))
(per_month <- summarise(per_day, flights = sum(flights)))
(per_year <- summarise(per_month, flights = sum(flights)))
