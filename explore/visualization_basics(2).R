# https://r4ds.had.co.nz/data-visualisation.html#statistical-transformations

library(tidyverse)

d <- ggplot(diamonds)

ggplot(diamonds) +
  geom_bar(aes(cut))

ggplot(diamonds) +
  stat_count(aes(cut))

demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)

ggplot(demo) +
  geom_bar(aes(cut, freq), stat = "identity")

d + geom_bar(aes(cut, ..prop.., group = 1))

d + stat_summary(
  aes(cut, depth),
  fun.ymin = min,
  fun.ymax = max,
  fun.y = median
)

d + geom_pointrange(aes(cut, depth), stat = "summary")
