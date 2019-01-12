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
    ## 1 40.25659 37.53364 31.34677 19.04895 18.92248 29.06987 27.09567 25.31862
    ## 2 42.91880 32.01584 27.91756 23.06041 15.10780 18.32848 26.20818 16.66498
    ## 3 40.22094 31.75520 24.45328 21.28010 17.49281 19.13680 22.50150 14.42005
    ## 4 35.82456 28.07986 22.76588 24.54485 16.50395 18.27380 20.23924 16.78379
    ## 5 30.65077 25.00437 19.64147 21.36417 14.72028 15.78223 17.53195 14.00004
    ## 6 27.84786 23.07398 19.93624 21.37960 13.06178 15.75764 16.64126 14.32521
    ##         X9      X10      X11      X12      X13 ntree
    ## 1 23.99808 33.74869 16.87151 12.78223 16.55269     1
    ## 2 23.20995 20.55119 17.12689 16.57276 15.30443     2
    ## 3 23.11085 17.11369 21.30122 17.07469 16.48651     3
    ## 4 20.01313 14.35064 19.83679 15.31666 15.78064     4
    ## 5 19.06888 14.25736 19.53127 21.32152 14.03301     5
    ## 6 18.38785 13.88151 18.73056 20.65127 12.54583     6

Creates a graph of MSE for each mtry.

``` r
long <- gather(mse, mtry, value, -ntree)
head(long)
```

    ##   ntree mtry    value
    ## 1     1   X1 40.25659
    ## 2     2   X1 42.91880
    ## 3     3   X1 40.22094
    ## 4     4   X1 35.82456
    ## 5     5   X1 30.65077
    ## 6     6   X1 27.84786

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

### 9

1.  Training dataset of 800 observations

``` r
set.seed(20)

train <- sample(nrow(OJ), 800)
test <- slice(OJ, -train)
train <- OJ[train,]
```

1.  We get 9 terminal nodes. The tree is built from only 4 varibles: LoyalCH, PriceDiff, DiscMM, Store7. The training error rate is 0.1588.

``` r
oj_tree <- tree(Purchase~., train)
summary(oj_tree)
```

    ## 
    ## Classification tree:
    ## tree(formula = Purchase ~ ., data = train)
    ## Variables actually used in tree construction:
    ## [1] "LoyalCH"   "PriceDiff" "DiscMM"    "Store7"   
    ## Number of terminal nodes:  9 
    ## Residual mean deviance:  0.7368 = 582.8 / 791 
    ## Misclassification error rate: 0.1588 = 127 / 800

``` r
plot(oj_tree)
text(oj_tree, pretty=0)
```

![](ch8_exercises_files/figure-markdown_github/unnamed-chunk-22-1.png)

1.  Node 10, which is a terminal node, classifies a MM. If the price difference is less than $0.17 than customer will pick MM over CH. In this case, 56 customers are in this terminal node with a deviance of 58.19. 21.43% of Purchase have CH as the value while remaining 78.57% of Purchase have the value MM.

``` r
oj_tree
```

    ## node), split, n, deviance, yval, (yprob)
    ##       * denotes terminal node
    ## 
    ##  1) root 800 1063.00 CH ( 0.61875 0.38125 )  
    ##    2) LoyalCH < 0.5036 338  401.50 MM ( 0.28107 0.71893 )  
    ##      4) LoyalCH < 0.32192 190  158.90 MM ( 0.14737 0.85263 )  
    ##        8) LoyalCH < 0.051325 61   10.21 MM ( 0.01639 0.98361 ) *
    ##        9) LoyalCH > 0.051325 129  132.40 MM ( 0.20930 0.79070 ) *
    ##      5) LoyalCH > 0.32192 148  203.80 MM ( 0.45270 0.54730 )  
    ##       10) PriceDiff < 0.17 56   58.19 MM ( 0.21429 0.78571 ) *
    ##       11) PriceDiff > 0.17 92  124.00 CH ( 0.59783 0.40217 ) *
    ##    3) LoyalCH > 0.5036 462  364.30 CH ( 0.86580 0.13420 )  
    ##      6) LoyalCH < 0.764572 197  227.40 CH ( 0.73604 0.26396 )  
    ##       12) PriceDiff < 0.05 72   99.81 MM ( 0.50000 0.50000 )  
    ##         24) DiscMM < 0.47 54   72.17 CH ( 0.61111 0.38889 ) *
    ##         25) DiscMM > 0.47 18   16.22 MM ( 0.16667 0.83333 ) *
    ##       13) PriceDiff > 0.05 125   95.64 CH ( 0.87200 0.12800 ) *
    ##      7) LoyalCH > 0.764572 265   85.16 CH ( 0.96226 0.03774 )  
    ##       14) Store7: No 154   74.02 CH ( 0.93506 0.06494 ) *
    ##       15) Store7: Yes 111    0.00 CH ( 1.00000 0.00000 ) *

1.  See (a)
2.  The test error is `{r}(132+85)/(132+27+26+85)`

``` r
oj_tpred <- predict(oj_tree, test, type='class')

table(oj_tpred, test$Purchase)
```

    ##         
    ## oj_tpred  CH  MM
    ##       CH 132  27
    ##       MM  26  85

1.  

``` r
oj_cv_tree <- cv.tree(oj_tree, FUN=prune.tree)
oj_cv_tree
```

    ## $size
    ## [1] 9 8 7 6 5 4 3 2 1
    ## 
    ## $dev
    ## [1]  688.7810  688.8420  688.8420  678.4876  699.9952  737.1975  741.3148
    ## [8]  771.7294 1063.7042
    ## 
    ## $k
    ## [1]      -Inf  11.13723  11.42215  16.31726  21.65779  31.94519  38.78481
    ## [8]  51.76482 297.63618
    ## 
    ## $method
    ## [1] "deviance"
    ## 
    ## attr(,"class")
    ## [1] "prune"         "tree.sequence"

1.  Tree with size 6 has the lowest deviation

``` r
attach(oj_cv_tree)

plot(size, dev, type='b')
```

![](ch8_exercises_files/figure-markdown_github/unnamed-chunk-26-1.png)

1.  See (g)
2.  

``` r
oj_prune <- prune.tree(oj_tree, best=6)

summary(oj_prune)
```

    ## 
    ## Classification tree:
    ## snip.tree(tree = oj_tree, nodes = c(7L, 12L, 4L))
    ## Variables actually used in tree construction:
    ## [1] "LoyalCH"   "PriceDiff"
    ## Number of terminal nodes:  6 
    ## Residual mean deviance:  0.783 = 621.7 / 794 
    ## Misclassification error rate: 0.1737 = 139 / 800

``` r
plot(oj_prune)
text(oj_prune, pretty=0)
```

![](ch8_exercises_files/figure-markdown_github/unnamed-chunk-27-1.png)

1.  The training error for the unpruned tree is: 0.1588. The training error for the pruned tree is: 0.1737. Based on the training error the unpruned tree preforms better.

2.  The test error for unpruned is: 0.197, while the test error for pruned tree is 0.222. The pruned tree has a higher test error.

``` r
oj_ppred <- predict(oj_prune, test, type='class')

table(oj_ppred, test$Purchase)
```

    ##         
    ## oj_ppred  CH  MM
    ##       CH 126  28
    ##       MM  32  84

### 10

1.  

``` r
df <- na.omit(Hitters)

df <- df %>% mutate(log_sal = log(Salary))
head(df)
```

    ##   AtBat Hits HmRun Runs RBI Walks Years CAtBat CHits CHmRun CRuns CRBI
    ## 1   315   81     7   24  38    39    14   3449   835     69   321  414
    ## 2   479  130    18   66  72    76     3   1624   457     63   224  266
    ## 3   496  141    20   65  78    37    11   5628  1575    225   828  838
    ## 4   321   87    10   39  42    30     2    396   101     12    48   46
    ## 5   594  169     4   74  51    35    11   4408  1133     19   501  336
    ## 6   185   37     1   23   8    21     2    214    42      1    30    9
    ##   CWalks League Division PutOuts Assists Errors Salary NewLeague  log_sal
    ## 1    375      N        W     632      43     10  475.0         N 6.163315
    ## 2    263      A        W     880      82     14  480.0         A 6.173786
    ## 3    354      N        E     200      11      3  500.0         N 6.214608
    ## 4     33      N        E     805      40      4   91.5         N 4.516339
    ## 5    194      A        W     282     421     25  750.0         A 6.620073
    ## 6     24      N        E      76     127      7   70.0         A 4.248495

1.  

``` r
train <- df[1:200,]
test <- df[201:nrow(df),]
```

1.  

``` r
hit_boost <- gbm(log_sal~., train, distribution='gaussian', n.trees=1000)
summary(hit_boost)
```

![](ch8_exercises_files/figure-markdown_github/unnamed-chunk-31-1.png)

    ##                 var      rel.inf
    ## Salary       Salary 98.162714006
    ## CHmRun       CHmRun  0.277687828
    ## PutOuts     PutOuts  0.163366333
    ## Hits           Hits  0.154205075
    ## Walks         Walks  0.131597939
    ## CRBI           CRBI  0.128191207
    ## CAtBat       CAtBat  0.123647623
    ## HmRun         HmRun  0.116277999
    ## AtBat         AtBat  0.108738733
    ## Assists     Assists  0.108287604
    ## RBI             RBI  0.098060058
    ## CWalks       CWalks  0.095521669
    ## CHits         CHits  0.085281420
    ## Runs           Runs  0.075344791
    ## CRuns         CRuns  0.068250774
    ## Errors       Errors  0.041464443
    ## Years         Years  0.028888789
    ## NewLeague NewLeague  0.018243887
    ## League       League  0.013080265
    ## Division   Division  0.001149557

``` r
hit_boost
```

    ## gbm(formula = log_sal ~ ., distribution = "gaussian", data = train, 
    ##     n.trees = 1000)
    ## A gradient boosted model with gaussian loss function.
    ## 1000 iterations were performed.
    ## There were 20 predictors of which 20 had non-zero influence.

``` r
set.seed(5)

power <- seq(-10, -0.2, 0.1)
lambda <- 10^power

train_error <- rep(NA, length(lambda))
test_error <- rep(NA, length(lambda))

for (i in 1:length(lambda)){
    model <- gbm(log_sal~., train, distribution='gaussian', n.trees=1000, shrinkage=lambda[i])
    
    train_pred <- predict(model, train, n.trees=1000)
    test_pred <- predict(model, test, n.trees=1000)
    train_error[i] <- MSE(train$log_sal, train_pred)
    test_error[i] <- MSE(test$log_sal, test_pred)
} 
```

``` r
plot_data <- tibble(lambda, train_error)

ggplot(plot_data, aes(lambda, train_error)) +
    geom_point() +
    geom_line() +
    xlab('Shrinkage') +
    ylab('Train MSE')
```

![](ch8_exercises_files/figure-markdown_github/unnamed-chunk-33-1.png)

``` r
tibble(lambda, test_error) %>%
    ggplot(aes(lambda, test_error)) +
    geom_point() +
    geom_line() +
    xlab('Shrinkage') +
    ylab('Test MSE')
```

![](ch8_exercises_files/figure-markdown_github/unnamed-chunk-34-1.png)
