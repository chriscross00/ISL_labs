ch5\_lab
================
Christopher Chan
December 31, 2018

``` r
library(ISLR)
library(tidyverse)
library(boot)
```

5.3.1
-----

Setting up the training set. 392 is just a random number that ISL came up with and we are only taking half of it.

``` r
set.seed(1)

train <- sample(392, 196)
test <- slice(Auto, -train)
```

``` r
lm_fit <- lm(mpg~horsepower, Auto, subset=train)

summary(lm_fit)
```

    ## 
    ## Call:
    ## lm(formula = mpg ~ horsepower, data = Auto, subset = train)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -13.698  -3.085  -0.216   2.680  16.770 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) 40.340377   1.002269   40.25   <2e-16 ***
    ## horsepower  -0.161701   0.008809  -18.36   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 4.692 on 194 degrees of freedom
    ## Multiple R-squared:  0.6346, Adjusted R-squared:  0.6327 
    ## F-statistic: 336.9 on 1 and 194 DF,  p-value: < 2.2e-16

``` r
pred <- predict(lm_fit, test)

mean((test[,'mpg'] - pred)^2)
```

    ## [1] 26.14142

Polynomial fit with quadratic and cubic functions. Both fit quite a bit better, with cubic having the lowest RSS.

``` r
lm_fit_quad <- lm(mpg~poly(horsepower, 2), data=Auto, subset=train)
pred_quad <- predict(lm_fit_quad, test) 

mean((test[,'mpg'] - pred_quad)^2)
```

    ## [1] 19.82259

``` r
lm_fit_cubic <- lm(mpg~poly(horsepower, 3), data=Auto, subset=train)
pred_cubic <- predict(lm_fit_cubic, test)

mean((test[,'mpg'] - pred_cubic)^2)
```

    ## [1] 19.78252

5.3.2
-----

``` r
glm_fit <- glm(mpg~horsepower, data=Auto)

cv_err <- cv.glm(Auto, glm_fit)
cv_err$delta
```

    ## [1] 24.23151 24.23114

LOOCV for polynomial lm.

``` r
cv_error <- rep(0,5) #initializes the cv_error vector

for (i in 1:5){
    glm_fit <- glm(mpg~poly(horsepower, i), data=Auto)
    cv_error[i] <- cv.glm(Auto, glm_fit)$delta[1]
}

cv_error
```

    ## [1] 24.23151 19.24821 19.33498 19.42443 19.03321

5.3.3
-----

k-fold cv with *k* = 10

``` r
set.seed(5)

cv_error_10 <- rep(0,10)
for (i in 1:10){
    glm_fit <- glm(mpg~poly(horsepower, i), data=Auto)
    cv_error_10[i] <- cv.glm(Auto, glm_fit, K=10)$delta[1]
}

cv_error_10
```

    ##  [1] 24.14736 19.38899 19.26022 19.57029 19.10580 18.66693 18.57784
    ##  [8] 18.70916 19.26092 19.64803

5.3.4
-----

Creating function on how we invest the money.

``` r
alpha_fn <- function(data, index){
    x <- data[,1][index]
    y <- data[,2][index]
    
    return ((var(y) - cov(x,y))/(var(x) + var(y) - 2*cov(x,y)))
}
```

``` r
alpha_fn(Portfolio, 1:100)
```

    ## [1] 0.5758321

Running a weird bootstrap with the sample().

``` r
set.seed(1)

alpha_fn(Portfolio, sample(100, 100, replace=T))
```

    ## [1] 0.5963833

Bootstraping using the built in boot(). Much more intuitive.

``` r
boot(Portfolio, alpha_fn, R=1000)
```

    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = Portfolio, statistic = alpha_fn, R = 1000)
    ## 
    ## 
    ## Bootstrap Statistics :
    ##      original        bias    std. error
    ## t1* 0.5758321 -7.315422e-05  0.08861826

``` r
boot_fn <- function(data, index){
    return (coef(lm(mpg~horsepower, data, subset=index)))
}

boot_fn(Auto, 1:392)
```

    ## (Intercept)  horsepower 
    ##  39.9358610  -0.1578447

``` r
boot(Auto, boot_fn, 1000)
```

    ## 
    ## ORDINARY NONPARAMETRIC BOOTSTRAP
    ## 
    ## 
    ## Call:
    ## boot(data = Auto, statistic = boot_fn, R = 1000)
    ## 
    ## 
    ## Bootstrap Statistics :
    ##       original        bias    std. error
    ## t1* 39.9358610  0.0126152644 0.871267432
    ## t2* -0.1578447 -0.0002691801 0.007540188
