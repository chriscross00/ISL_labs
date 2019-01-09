ch8\_exercises
================
Christoper Chan
January 6, 2019

``` r
library(tidyverse)
library(gbm)
library(tree)
library(randomForest)
library(ISLR)
library(MASS)
```

MSE function

``` r
MSE <- function(x,y){
    mean((x - y)^2)
}
```

Applied
-------

### 7

``` r
rf_bos <- randomForest(medv~., Boston, ntree=500, mtry=13, importance=T)
plot(rf_bos)
```

![](ch8_exercises_files/figure-markdown_github/unnamed-chunk-3-1.png)

So I tried for a good 45 minutes to do this in a for loop and as a function but no luck. The output of randomForest can't be stored in a data.frame.

TO DO: Create training and test dataset. Create different mtry, m=p, m=p/2, m=sqrt(p)

FINALLY! I did it with a for loop. My mistake before was i was putting the mse df in the for loop so the df was being reset each time.

``` r
tries <- 500

mse <- data.frame(matrix(NA, nrow=tries, ncol=13))
for (i in 1:13){
    a <- randomForest(medv~., Boston, ntree=tries, mtry=i, importance=T)
    mse[i] <- a$mse
}

mse$ntree <- 1:tries
head(mse)
```

    ##         X1       X2       X3       X4       X5       X6       X7       X8
    ## 1 31.80872 52.42473 18.28603 24.63975 34.02078 20.82501 20.17224 18.95064
    ## 2 34.04987 34.21041 25.00775 27.40268 28.23370 16.13734 23.61439 25.68817
    ## 3 29.75503 30.18289 25.98576 22.67575 26.81627 15.80643 23.87533 24.22175
    ## 4 27.75409 26.00290 23.14605 20.54429 26.63956 18.48176 24.00164 19.34626
    ## 5 24.88952 24.34133 21.63823 18.32254 22.09555 17.41297 24.85599 17.26936
    ## 6 24.20768 24.24671 21.86109 15.38011 25.61217 17.75042 21.37371 16.42574
    ##         X9      X10      X11      X12      X13 ntree
    ## 1 21.27642 28.41122 20.69694 27.62397 23.07290     1
    ## 2 19.46439 29.64176 18.47396 20.20069 23.29881     2
    ## 3 19.63887 23.15113 24.18391 22.26955 23.33454     3
    ## 4 17.95513 23.11587 19.66064 18.61263 21.92456     4
    ## 5 15.27002 21.50509 19.29295 18.50928 18.82777     5
    ## 6 14.47486 18.76671 18.32341 17.65219 18.09505     6

Creates a graph of MSE for each mtry.

``` r
long <- gather(mse, mtry, value, -ntree)
head(long)
```

    ##   ntree mtry    value
    ## 1     1   X1 31.80872
    ## 2     2   X1 34.04987
    ## 3     3   X1 29.75503
    ## 4     4   X1 27.75409
    ## 5     5   X1 24.88952
    ## 6     6   X1 24.20768

``` r
ggplot(long, aes(ntree, value, color=mtry)) +
    geom_line() +
    ylab('MSE')
```

![](ch8_exercises_files/figure-markdown_github/unnamed-chunk-5-1.png) MSE seems lo level off after 150 trees. X1 has the highest MSE of the mtry while X9 has the lowest minimum MSE.

df conversion done with the reshape2 package.

``` r
library(reshape2)
```

    ## 
    ## Attaching package: 'reshape2'

    ## The following object is masked from 'package:tidyr':
    ## 
    ##     smiths

``` r
df <- melt(mse, id.vars='ntree', variable.names='mtry')

View(df)

ggplot(df, aes(ntree, value)) +
    geom_line(aes(color=variable))
```

![](ch8_exercises_files/figure-markdown_github/unnamed-chunk-6-1.png)

### 8

1.  Training data is 3/4 of the Carseats data.

``` r
set.seed(5)

train <- sample(1:nrow(Carseats), (3/4)*nrow(Carseats))
test <- slice(Carseats, -train)
train <- Carseats[train,]
```

1.  

``` r
reg_tree <- tree(Sales~., train)
summary(reg_tree)
```

    ## 
    ## Regression tree:
    ## tree(formula = Sales ~ ., data = train)
    ## Variables actually used in tree construction:
    ## [1] "ShelveLoc"   "Price"       "Age"         "Advertising" "CompPrice"  
    ## [6] "Population"  "Income"     
    ## Number of terminal nodes:  20 
    ## Residual mean deviance:  2.524 = 706.6 / 280 
    ## Distribution of residuals:
    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ## -3.9850 -0.9850 -0.0560  0.0000  0.9744  5.0090

Plot of tree

``` r
plot(reg_tree)
text(reg_tree, cex=0.8, pretty=0)
```

![](ch8_exercises_files/figure-markdown_github/unnamed-chunk-9-1.png)

MSE is around 4.57.

``` r
pred_carseats <- predict(reg_tree, test)
MSE(pred_carseats, test$Sales)
```

    ## [1] 4.573537

1.  Looks like the best tree size is 9.

``` r
set.seed(10)

cv_tree <- cv.tree(reg_tree, FUN=prune.tree)
cv_tree
```

    ## $size
    ##  [1] 20 19 18 17 16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1
    ## 
    ## $dev
    ##  [1] 1449.207 1483.818 1474.311 1501.462 1504.789 1510.086 1509.923
    ##  [8] 1519.623 1514.920 1523.643 1518.617 1551.506 1657.301 1708.545
    ## [15] 1718.140 1676.093 1845.327 1832.987 1936.100 2455.037
    ## 
    ## $k
    ##  [1]      -Inf  24.97477  26.02050  29.80899  30.42954  30.46967  30.78367
    ##  [8]  33.22207  39.05502  42.75892  45.93394  49.27407  61.42385  69.35358
    ## [15]  71.05762  84.24680 120.97760 125.57046 272.16709 528.71924
    ## 
    ## $method
    ## [1] "deviance"
    ## 
    ## attr(,"class")
    ## [1] "prune"         "tree.sequence"

``` r
par(mfrow=c(1,2))
plot(cv_tree$size, cv_tree$dev, type='b')
plot(cv_tree$k, cv_tree$dev, type='b')
```

![](ch8_exercises_files/figure-markdown_github/unnamed-chunk-11-1.png)

Running prune.tree with best=9

``` r
pruned <- prune.tree(reg_tree, best=9)

plot(pruned)
text(pruned, pretty=0)
```

![](ch8_exercises_files/figure-markdown_github/unnamed-chunk-12-1.png)

Calculating MSE of pruned tree. We get a MSE of 3.74, which is roughly 0.8 lower than a reg tree. Pruning the tree does decrease the MSE.

``` r
pred_pruned <- predict(pruned, test)
MSE(pred_pruned, test$Sales)
```

    ## [1] 3.740164

1.  So I just need to remeber that I need to use the randomForest() where mtry = *p* in order to only do bagging.

``` r
set.seed(1)

bag_car <- randomForest(Sales~., train, mtry=10, importance=TRUE)
bag_car
```

    ## 
    ## Call:
    ##  randomForest(formula = Sales ~ ., data = train, mtry = 10, importance = TRUE) 
    ##                Type of random forest: regression
    ##                      Number of trees: 500
    ## No. of variables tried at each split: 10
    ## 
    ##           Mean of squared residuals: 2.651691
    ##                     % Var explained: 67.17

``` r
importance(bag_car)
```

    ##                %IncMSE IncNodePurity
    ## CompPrice   31.5102047    258.198822
    ## Income       5.7282685    111.437402
    ## Advertising 23.1289063    215.273668
    ## Population   0.1408167     85.478719
    ## Price       61.3567059    720.401178
    ## ShelveLoc   73.1567053    626.649235
    ## Age         24.5676254    247.593006
    ## Education    4.3458187     66.635900
    ## Urban       -1.4207142      9.113515
    ## US           4.4489013     19.060855

We get a test MSE of 1.93. Which is lower than the training MSE of 2.65. Price, ShelveLoc & CompPrice are the most importance variables.

``` r
pred_bag <- predict(bag_car, test)

MSE(pred_bag, test$Sales)
```

    ## [1] 1.932099

1.  

``` r
set.seed(2)

rf_car2 <- randomForest(Sales~., train, mtry=5, importance=T)
rf_car2
```

    ## 
    ## Call:
    ##  randomForest(formula = Sales ~ ., data = train, mtry = 5, importance = T) 
    ##                Type of random forest: regression
    ##                      Number of trees: 500
    ## No. of variables tried at each split: 5
    ## 
    ##           Mean of squared residuals: 2.77816
    ##                     % Var explained: 65.6

``` r
importance(rf_car2)
```

    ##                %IncMSE IncNodePurity
    ## CompPrice   18.4376338     226.57808
    ## Income       4.6196814     149.26851
    ## Advertising 19.3707023     236.91850
    ## Population  -0.2817878     121.65108
    ## Price       52.2657149     625.61383
    ## ShelveLoc   52.0158350     579.80128
    ## Age         18.0713290     265.59039
    ## Education    2.4538607      88.34015
    ## Urban       -1.4711313      13.41200
    ## US           5.6914764      30.39115

``` r
pred_rf2 <- predict(rf_car2, test)
MSE(pred_rf2, test$Sales)
```

    ## [1] 2.045975

``` r
rf_carsqrt <- randomForest(Sales~., train, mtry=sqrt(10), importance=T)

rf_carsqrt
```

    ## 
    ## Call:
    ##  randomForest(formula = Sales ~ ., data = train, mtry = sqrt(10),      importance = T) 
    ##                Type of random forest: regression
    ##                      Number of trees: 500
    ## No. of variables tried at each split: 3
    ## 
    ##           Mean of squared residuals: 3.143607
    ##                     % Var explained: 61.08

``` r
importance(rf_carsqrt)
```

    ##               %IncMSE IncNodePurity
    ## CompPrice   13.183026     212.86668
    ## Income       3.344561     176.86179
    ## Advertising 15.045662     227.23708
    ## Population  -1.460400     159.40722
    ## Price       41.936327     546.49453
    ## ShelveLoc   46.626280     499.43002
    ## Age         16.641022     291.16673
    ## Education    2.783632     108.93297
    ## Urban       -3.153515      19.12951
    ## US           5.871049      43.48906

Random forest was run twice, once with mtry=*p*/2 and again with mtry=$\\sqrt{p}$. The MSE of *p*/2 is 2.05 and the MSE of $\\sqrt{p}$ is 2.46. Both are a increase in MSE over bagging. Both rf show very similar importance, with Price and Shelveloc being the most importance predictors for both, but then *p*/2 chooses CompPrice as the third most important predictor while *s**q**r**t**p* chooses Age.

``` r
pred_rfsqrt <- predict(rf_carsqrt, test)
MSE(pred_rfsqrt, test$Sales)
```

    ## [1] 2.455962
