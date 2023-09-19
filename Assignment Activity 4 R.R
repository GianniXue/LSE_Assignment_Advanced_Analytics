install.packages('tidyverse')
library(tidyverse)

turtle_sales <- read.csv('/Users/giannixue/Documents/turtle_sales.csv')
typeof(turtle_sales)
class(turtle_sales)
dim(turtle_sales)

turtle_sales <- subset(turtle_sales, select = -c(Ranking, Year, Genre, Publisher))
View(turtle_sales)
turtle_sales
summary(turtle_sales)

#EU vs NA Sales by Platform
qplot(NA_Sales,
      EU_Sales,
      colour=Platform,
      data=turtle_sales)


