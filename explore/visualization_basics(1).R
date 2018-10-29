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

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

# Exercises
# 3.5.1.1
ggplot(mpg) +
  geom_point(aes(displ, hwy)) +
  facet_grid(. ~ cty) # when you facet on a continuous variable it creates a
  # facet for each of the unique values

# 3.5.1.2
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))
  # the missing cells represent combinations that aren't present in the data

# 3.5.1.3
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .) # facet rows only

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl) # facet columns only

# 3.5.1.4
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
  # advantage are that is faster to understand the mpg of 2seaters
  # disadvantage is that comparison is slightly more difficult than a color aes

# 3.5.1.5
?facet_wrap
  # `nrow` and `ncol` control the number of rows and columns 
  # facet_grid() doesn't need nrow or ncol because the number of cells is
  # determined by the data

# 3.5.1.6
  # there is typically more room for columns

--------------------------------------------------------------------------------

# https://r4ds.had.co.nz/data-visualisation.html#geometric-objects

library(tidyverse)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

ggplot(mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv, linetype = drv))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y =  hwy)) # inefficient

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)

# Exercises
# 3.6.1.1
# geom_line(), geom_boxplot(), geom_histogram(), geom_area()

# 3.6.1.2
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE) # missed that the smooth lines would change color

# 3.6.1.3
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv))
# show.legend = FALSE hides the legend, used to simplify the plot

# 3.6.1.4
# se control whether or not the standard error shading is include with the line

# 3.6.1.5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# the same, first code block is the efficent method

# 3.6.1.6
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(aes(group = drv), se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(aes(group = drv), se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth(se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth(aes(linetype = drv), se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(size = 4, color = "white") +
  geom_point(aes( color = drv))
  