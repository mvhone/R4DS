# http://r4ds.had.co.nz/data-visualisation.html#first-steps

library(tidyverse)

mpg

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

# A graphing template
# ggplot(data = <DATA>) +
#   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

# Exercises

# 3.2.4.1
ggplot(data = mpg) # An empty plot

# 3.2.4.2
mpg # 234 rows and 11 columns

# 3.2.4.3
?mpg # `drv` categorizes cars by which wheels the engine can power

# 3.2.4.4
ggplot(data = mpg) +
  geom_point(mapping = aes(x = hwy, y = cyl))

# 3.2.4.5
ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = drv)) # Both variables are categorical
  # and you can't tell how many points are overlapping from the scatterplot

--------------------------------------------------------------------------------

# http://r4ds.had.co.nz/transform.html#introduction-2

library(nycflights13)
library(tidyverse)

flights
?flights
View(flights)


