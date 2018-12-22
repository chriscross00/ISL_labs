ch6\_lab2
================
Christoper Chan
December 22, 2018

``` r
library(tidyverse)
library(forecast)
library(ISLR)
library(leaps)
library(glmnet)
```

Lab 2: Ridge and Lasso Regression
=================================

6.6.1
-----

Creating a model.matrix of our Hitters data. Because rows with NA are dropped in the model.matrix function the y variable must also drop rows with NA.

``` r
x <- model.matrix(Salary~., Hitters)[,-1]
y <- Hitters$Salary %>%
    na.omit()
```

Creating an array of length 100 equally spaced distances between 10^-2 and 10^10. This will be our ![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda "\lambda") values that we'll use for the section. We then run ridge regression on our grid.

``` r
grid <- 10^seq(10,-2, length=100)
ridge_mod <- glmnet(x, y, alpha=0, lambda=grid)
```

This is messing around with different lambda values, showing that high ![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda "\lambda") values yield low coef and low ![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda "\lambda") values give high coef.

``` r
ridge_mod$lambda[70]
```

    ## [1] 43.28761

``` r
coef(ridge_mod)[,70]
```

    ##   (Intercept)         AtBat          Hits         HmRun          Runs 
    ##   54.97384215   -0.41480601    2.10530493   -1.34828331    1.13281252 
    ##           RBI         Walks         Years        CAtBat         CHits 
    ##    0.79219405    2.83508432   -6.85814163    0.00438123    0.11187771 
    ##        CHmRun         CRuns          CRBI        CWalks       LeagueN 
    ##    0.64020753    0.23468562    0.22724180   -0.17405551   47.59278798 
    ##     DivisionW       PutOuts       Assists        Errors    NewLeagueN 
    ## -119.52546741    0.25369445    0.13095051   -3.38369142  -11.36670636

Running our ridge regression model on a set ![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda "\lambda"), in this case 50.

``` r
predict(ridge_mod, s=50, type='coefficients')[1:20,]
```

    ##   (Intercept)         AtBat          Hits         HmRun          Runs 
    ##  4.876610e+01 -3.580999e-01  1.969359e+00 -1.278248e+00  1.145892e+00 
    ##           RBI         Walks         Years        CAtBat         CHits 
    ##  8.038292e-01  2.716186e+00 -6.218319e+00  5.447837e-03  1.064895e-01 
    ##        CHmRun         CRuns          CRBI        CWalks       LeagueN 
    ##  6.244860e-01  2.214985e-01  2.186914e-01 -1.500245e-01  4.592589e+01 
    ##     DivisionW       PutOuts       Assists        Errors    NewLeagueN 
    ## -1.182011e+02  2.502322e-01  1.215665e-01 -3.278600e+00 -9.496680e+00
