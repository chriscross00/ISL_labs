---
title: "ML Algorithms"
author: "Christopher Chan"
date: "January 23, 2019"
output:
  html_document:
    keep_md: yes
  rmarkdown::github_document:
    pandoc: --webtex
---


Algorithms

* [Linear Regression](#lin_reg)
* [Logistic Regression](#log_reg)
* [Naive Bayes](#nb)
* [Trees](#trees)
* [SVM](#svm)

## Linear Regression {#linear_regression}
Assumptions:

1. Observations $y_i$ are uncorrelated
2. Observations $y_i$ have constant variance
3. $x_i$ are fixed

$$f(X) = \beta_0 + \sum^p_{j=1}X_j\beta_j + \varepsilon$$

Cost function
$$RSS(\beta) = \sum^N_{i=1}(y_i-\beta_0-\sum^p_{j=1}x_{ij}\beta_j)^2$$

$$X = N * (p+1)$$

Normal equation
$$\hat{\beta} = (X^TX)^{-1}X^Ty$$

* With 

$$\hat{y} = X\hat{\beta} = X(X^{T}X)^{-1}X^{T}y$$


Gradient descent
$$\beta_{j} := \beta_{j} -\alpha\frac{\partial}{\partial \beta_j}(\beta_0 ... \beta_p)$$

Implement a gradient descent algorithm
Gradient descent for $\beta_j$
$$\beta_{j} := \beta_{j} -\alpha\frac{1}{p}\sum^{p}_{i=1}(\sum x_{j}\beta_j)$$

Hat (Matrix) - predicts y
$$H = X(X^TX)^{-1}X^T$$

Variance - unbiased 
$$\hat{\sigma} = \frac{1}{N-p-1}\sum^N_{i=1}(y_i-\hat{y_i})^2$$

### Ridge Regression

$$\hat{\beta}^{ridge} = argmin_\beta [\sum_{i=1}^N(y_i - \beta_0 -\sum^p_{j=1}x_{ij}\beta_j)^2 + \lambda\sum^p_{j=1}\beta^2_j]$$

### Lasso Regression

$$\hat{\beta}^{lasso} = argmin_\beta [\frac{1}{2}\sum_{i=1}^N(y_i - \beta_0 -\sum^p_{j=1}x_{ij}\beta_j)^2 + \lambda\sum^p_{j=1}|\beta_j|]$$


## Logistic Regresion {#logistic_regression}

In general modeling:
$$p(X) = p(Y=y|X)$$

log-odds
$$log\frac{p(X)}{1-p(X)} = \beta_0 + \beta_1X_1 + ... + \beta_pX_p$$
$$p(X) = \frac{e^{\beta_0 + \beta_1X_1 + ... + \beta_pX_p}}{1 + e^{\beta_0 + \beta_1X_1 + ... + \beta_pX_p}}$$

Estimating regression coefficients with likelihood function:
$$\ell(\beta_0, \beta_1 ... \beta_p) = \prod_{i:y_i=1}p(x_i) \prod_{i^{'}:y_i^{'}=0} (1-p(x_{i^{'}}))$$

Cost function:
$$J(\theta) = -\frac{1}{m}\sum_{i=1}^m[y^{(i)}log(h_{\theta}(x^{(i)})) + (1-y^{(i)})log(1-h_{\theta}(x^{(i)}))]$$

## K Nearest Neighbor




## Naive Bayes {#nb}

$$p(y|x_1, ..., x_n)\propto p(y)\prod_{i}^{n}P(x_i|y)$$
$$y = argmax_yP(y)\prod_{i}^{n}P(x_i|y)$$

## Trees {#trees}

### Regression
General cost function
$$\sum^{J}_{j=1}\sum_{i\in{R_j}}(y_i-\hat{y}_{R_j})^2$$

Cost function at each split
$$\sum_{i: x_i\in{R_1}(j,s)}(y_i-\hat{y}_{R_1})^2 + \sum_{i: x_i\in{R_2}(j,s)}(y_i-\hat{y}_{R_2})^2$$

Pruned tree with $\alpha$ cost function
Number of elements in each split
$$N_m = \#{x_i\in{R_m}}$$
Average $y_i$ for each split
$$\hat{c}_m = \frac{1}{N_m}\sum_{x_i\in{R_m}}y_i$$
MSE at $R_m$
$$Q_m(T) = \frac{1}{N_m}\sum_{x_i\in{R_m}}(y_i - \hat{c}_m)^2$$
Cost complexity with $\alpha$
$$\mathcal{C}_{\alpha}(T) = \sum^{|T|}_{m=1}N_{m}Q_{m}(T) + \alpha\left|T\right|$$

### Classification
Gini index
$$G = \sum^{K}_{k=1}\hat{p}_{mk}(1 - \hat{p}_{mk})$$

Entropy
$$D = -\sum^{K}_{k=1}\hat{p}_{mk}log\hat{p}_{mk}$$

Information gain
$$IG(T,a) = H(T) - H(T|a) = -\sum^{K}_{k=1}\hat{p}_{mk}log\hat{p}_{mk} - \sum_{a}p(a)\sum^J_{i=1}-Pr(i|a)log_2Pr(i|a)$$


### Bagging
Regression
$$\hat{f}_{bag}(x) = \frac{1}{B}\sum^{B}_{b=1}\hat{f}^{*b}(x)$$
Classification
$$\hat{C^B_{\text{rf}}}(x) = \text{majority vote } \hat{C_b}(x)^B_1$$

### Notes
$J$ = Divides
$s$ = cutoff point
Divide $X_1, X_2, ... X_p$ into $J$ distinct non-overlapping regions, $R_1, R_2, ..., R_J$


## Support Vector Machines {#svm}

Maximal Marigin classifier
$$\max_{\beta_{0}, \beta_{1},...,\beta_{p},M}M$$
subject to $\sum^{p}_{j=1}\beta^{2}_{j}=1$, $y_{i}(\beta_{0} + \beta_{1}x_{i1} + ... + \beta_{p}x_{ip} \geq M \forall i = 1, ..., n$

Support vector classifier
$$\max_{\beta_{0}, \beta_{1},...,\beta_{p},\epsilon_{1},..., \epsilon_{n}, M}M$$
$$\text{subject to} \sum^{p}_{j=1}\beta^{2}_{j}=1,\\ 
y_{i}(\beta_{0} + \beta_{1}x_{i1} + ... + \beta_{p}x_{ip} \geq M(1-\epsilon_{i}),\\ 
\epsilon_{i} \geq0,\\  
\sum^{n}_{i=1}\epsilon_{i}\leq C$$

Alternative formula:

$$\text{min}||\beta|| \text{subject to}
\begin{cases} 
y_i(x^T_i\beta + \beta_0) \geq 1 - \epsilon_i \forall,\\
\epsilon_i \geq 0 , \sum\epsilon_i < \text{constant}
\end{cases}$$


* C is a nonnegative tuning parameter
* $\epsilon_{1}, ..., \epsilon_{n}$ are slack variables
    + If $\epsilon_{i} > 0$, then $i$th observation on wrong side of margin
    + If $\epsilon_{i} > 1$, then $i$th observation on wrong side of hyperplane

Who is who:

Symbol          | Meaning
----------------|-----------------------------
$N$             | Number of observations
$p$             | Number of parameters
$\beta$         | GLM coefficient
$p()$           | Probability
$J$             | Distinct, non-overlapping regions in a tree model
$s$             | Cutoff point between regions in tree model
$\hat{C_b}(x)$  | Class prediction of *b*th rf

## Notes
$x$ parameterized by $\theta$: $$x;\theta$$
