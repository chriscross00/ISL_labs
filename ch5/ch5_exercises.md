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

    ## [1] 0.637

### 3

1.  Divides the dataset into ![k](https://latex.codecogs.com/png.latex?k "k") blocks and validates the data on the ![k](https://latex.codecogs.com/png.latex?k "k")th block for that iteration. The blocks rotate until all ![k](https://latex.codecogs.com/png.latex?k "k") blocks have been used as the validation block. The test error is averaged over all iterations.
2.  -   More groups give a better representation of the true test error because of the larger sample size. It also has a lower variance. It will also have lower bias as it tends not to overfit to the training data.
    -   Computationally it is more efficient as it does not have to iterate ![n](https://latex.codecogs.com/png.latex?n "n") times. Also ![k](https://latex.codecogs.com/png.latex?k "k")-fold cv will have a lower bias.

### 4

Applied
-------

### 5

1.  

``` r
set.seed(1)


summary(Default)
```

    ##  default    student       balance           income     
    ##  No :9667   No :7056   Min.   :   0.0   Min.   :  772  
    ##  Yes: 333   Yes:2944   1st Qu.: 481.7   1st Qu.:21340  
    ##                        Median : 823.6   Median :34553  
    ##                        Mean   : 835.4   Mean   :33517  
    ##                        3rd Qu.:1166.3   3rd Qu.:43808  
    ##                        Max.   :2654.3   Max.   :73554

``` r
lg <- glm(default~balance + income, Default, family='binomial')
summary(lg)
```

    ## 
    ## Call:
    ## glm(formula = default ~ balance + income, family = "binomial", 
    ##     data = Default)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -2.4725  -0.1444  -0.0574  -0.0211   3.7245  
    ## 
    ## Coefficients:
    ##               Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept) -1.154e+01  4.348e-01 -26.545  < 2e-16 ***
    ## balance      5.647e-03  2.274e-04  24.836  < 2e-16 ***
    ## income       2.081e-05  4.985e-06   4.174 2.99e-05 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 2920.6  on 9999  degrees of freedom
    ## Residual deviance: 1579.0  on 9997  degrees of freedom
    ## AIC: 1585
    ## 
    ## Number of Fisher Scoring iterations: 8

1.  

``` r
val <- function() {
    train <- sample(1:nrow(Default), nrow(Default)/2)
    test <- slice(Default, -train)

    glm_fit <- glm(default~balance + income, Default, family='binomial', subset=train)

    t <- predict(glm_fit, test, type='response')
    glm_pred <- rep('No', nrow(test))
    glm_pred[t >0.5] = 'Yes'

    return (mean(glm_pred != test$default))
}


val()
```

    ## Warning: package 'bindrcpp' was built under R version 3.4.4

    ## [1] 0.0286

1.  They all have low errors that are relatively similar.

``` r
map(seq_len(3), ~val())
```

    ## [[1]]
    ## [1] 0.0236
    ## 
    ## [[2]]
    ## [1] 0.028
    ## 
    ## [[3]]
    ## [1] 0.0268

1.
