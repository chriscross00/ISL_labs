library(tidyverse)
library(tree)
library(ISLR)


head(Carseats)
dim(Carseats)

High <- ifelse(Sales<=8, 'No', 'Yes')

Carseats %>%
    mutate(High) %>%
    head
