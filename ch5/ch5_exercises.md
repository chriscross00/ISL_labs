ch5\_exercises
================
Christoper Chan
January 1, 2019

``` r
library(tidyverse)
library(ISLR)
library(boot)
```

Conceptual
----------

### 1

### 2

1.  ![(n-j)/n](https://latex.codecogs.com/png.latex?%28n-j%29%2Fn "(n-j)/n") That is the probability of not ![j](https://latex.codecogs.com/png.latex?j "j") is the total probability minus the probability of ![j](https://latex.codecogs.com/png.latex?j "j").
2.  ![(n-j)/n](https://latex.codecogs.com/png.latex?%28n-j%29%2Fn "(n-j)/n") The probabilty is the same as the 1st bootstrap observation.
3.  Bootstraping observations are independent, so the outcome of each observation does not affect the outcome of the ![n](https://latex.codecogs.com/png.latex?n "n")th observation. Using the product rule we simply raise the probability of ![j](https://latex.codecogs.com/png.latex?j "j") not appearing to the ![n](https://latex.codecogs.com/png.latex?n "n")th bootstraping observation
4.  ![Pr(in) = 1 - Pr(out) = 1 - (1-1/n)^n =](https://latex.codecogs.com/png.latex?Pr%28in%29%20%3D%201%20-%20Pr%28out%29%20%3D%201%20-%20%281-1%2Fn%29%5En%20%3D "Pr(in) = 1 - Pr(out) = 1 - (1-1/n)^n =") 0.67232
5.  0.6339677
6.  0.632139
7.  The probabilty drops off quite fast as the number of observations increase. Most are barely above zero.

``` r
pr <- function(n){
    return (1 - (1-1/n)^n)
}
x <- 1:1e5

pr_x <- tibble(x, pr(x))

ggplot(pr_x, aes(x, pr(x))) +
    geom_point()
```

![](ch5_exercises_files/figure-markdown_github/unnamed-chunk-2-1.png)

1.  

``` r
store <- rep(NA, 1000)
for (i in 1:1000){
    store[i] <- sum(sample(1:100, rep=T)==4) > 0
}

mean(store)
```

    ## [1] 0.641

### 3

1.
