ch6\_exercises
================
Christopher Chan
December 23, 2018

``` r
library(tidyverse)
library(glmnet)
library(leaps)
```

Conceptual
----------

### 1

1.  Best subset should have the lowest RSS because it compares all possible models, while stepwise regression only compares paraments based on the past parameters.
2.  It depends, but most likely best subset should have the lowest RSS.
3.  1.  True
    2.  True
    3.  False
    4.  False
    5.  False

### 2

1.  1.  Lasso greatly decreases variance at the cost of increased biases when compared to LSR.

2.  1.  Same as lasso

3.  1.  Answer

### 3

1.  1.  Increasing s from 0 will cause *β* to increase from 0 to their least squares estimate value.

2.  1.  While lasso provides a decreased variance, it increases bias. once *β* reaches their LR values they overfit the test data.

3.  1.  Variance increases you include more data into the model.

4.  1.  Lasso insures that LR estimate values are reached.

5.  1.  By definition irreducible error is model independent.

### 4

1.  1.  Increasing *θ* will increase the RSS because when *θ* = 0 the *β* coefficients are at their OSL estimated values, so increasing *θ* will decrease the *β* coefficients, increasing the RSS.

2.  1.  With *θ* = 0 *β* coefficients are at their OSL estimated values, meaning they are overfitted to the training data. They have a bias towards the training data, so the test RSS will be high. As *θ* increases the bias decreases, so test RSS decreases. However, as some *β* reach zero the model becomes too simple and test RSS increases.

3.  1.  High variance at *θ* = 0 and decreases as parameters are removed.

4.  1.  Very low bias at *θ* = 0 and as *β*s are removed the model fits the training data less, so bias increases.

5.  1.  By definition irreducible error is model independent.

Applied
-------

### 8

1.  

``` r
set.seed(1)

x <- rnorm(100)
noise <- rnorm(100)
```

1.  

``` r
b_0 <- 17
b_1 <- 2
b_2 <- 0.5
b_3 <- 3

y = b_0 + b_1*x + b_2*x^2 + b_3*x^3 + noise
```

1.  

``` r
df <- tibble(x, y)

poly_x <- regsubsets(y~poly(x, 10, raw = T), df)
summary_poly_x <- summary(poly_x)
```
