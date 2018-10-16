# One time setup

# install.packages('installr')
library(installr)

updateR()

require2(c("tidyverse", "nycflights13", "gapminder", "Lahman"))

tidyverse_update()

installr