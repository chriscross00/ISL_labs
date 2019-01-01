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
