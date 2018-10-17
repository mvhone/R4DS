# http://r4ds.had.co.nz/data-visualisation.html#aesthetic-mappings

library(tidyverse)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = class)) # not advised

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class)) # not advised

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# Exercises
# 3.3.1.1
# The manual color aesthetic should be outside aes()

# 3.3.1.2
?mpg
mpg
# Categorical variables: manufacturer, model, trans, drv, fl, and class
# Continuous variables: displ, year, cyl, cty, and hwy

# 3.3.1.3
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy, color = hwy, size = cyl))
  # continuous variables get a continuous scale of color or size, doesn't work 
  # with shape

# 3.3.1.4
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy, color = displ, alpha = hwy)) 
  # produces redundant visuals

# 3.3.1.5
# `stroke` controls the size of the outline for some shapes

# 3.3.1.6
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy, color = displ < 5)) # the expression tells
  # ggplot how to symbolize the aesthetic, less than 5 are blue

--------------------------------------------------------------------------------
  
# http://r4ds.had.co.nz/data-visualisation.html#facets
  
library(tidyverse)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)


