ML Algorithms
================
Christopher Chan
January 23, 2019

### Linear Regression

Assumptions:

1.  Observations ![y\_i](https://latex.codecogs.com/png.latex?y_i "y_i") are uncorrelated
2.  Observations ![y\_i](https://latex.codecogs.com/png.latex?y_i "y_i") have constant variance
3.  ![x\_i](https://latex.codecogs.com/png.latex?x_i "x_i") are fixed

![f(X) = \\beta\_0 + \\sum^p\_{j=1}X\_j\\beta\_j + \\varepsilon](https://latex.codecogs.com/png.latex?f%28X%29%20%3D%20%5Cbeta_0%20%2B%20%5Csum%5Ep_%7Bj%3D1%7DX_j%5Cbeta_j%20%2B%20%5Cvarepsilon "f(X) = \beta_0 + \sum^p_{j=1}X_j\beta_j + \varepsilon")

Cost function

![RSS(\\beta) = \\sum^N\_{i=1}(y\_i-\\beta\_0-\\sum^p\_{j=1}x\_{ij}\\beta\_j)^2](https://latex.codecogs.com/png.latex?RSS%28%5Cbeta%29%20%3D%20%5Csum%5EN_%7Bi%3D1%7D%28y_i-%5Cbeta_0-%5Csum%5Ep_%7Bj%3D1%7Dx_%7Bij%7D%5Cbeta_j%29%5E2 "RSS(\beta) = \sum^N_{i=1}(y_i-\beta_0-\sum^p_{j=1}x_{ij}\beta_j)^2")

 Cost function matrix formula

![\\hat{\\beta} = (X^TX)^{-1}X^Ty](https://latex.codecogs.com/png.latex?%5Chat%7B%5Cbeta%7D%20%3D%20%28X%5ETX%29%5E%7B-1%7DX%5ETy "\hat{\beta} = (X^TX)^{-1}X^Ty")

Hat (Matrix) - predicts y

![H = X(X^TX)^{-1}X^T](https://latex.codecogs.com/png.latex?H%20%3D%20X%28X%5ETX%29%5E%7B-1%7DX%5ET "H = X(X^TX)^{-1}X^T")

Variance - unbiased

![\\hat{\\sigma} = \\frac{1}{N-p-1}\\sum^N\_{i=1}(y\_i-\\hat{y\_i})^2](https://latex.codecogs.com/png.latex?%5Chat%7B%5Csigma%7D%20%3D%20%5Cfrac%7B1%7D%7BN-p-1%7D%5Csum%5EN_%7Bi%3D1%7D%28y_i-%5Chat%7By_i%7D%29%5E2 "\hat{\sigma} = \frac{1}{N-p-1}\sum^N_{i=1}(y_i-\hat{y_i})^2")

#### Ridge Regression

![\\hat{\\beta}^{ridge} = argmin\_\\beta \[\\sum\_{i=1}^N(y\_i - \\beta\_0 -\\sum^p\_{j=1}x\_{ij}\\beta\_j)^2 + \\lambda\\sum^p\_{j=1}\\beta^2\_j\]](https://latex.codecogs.com/png.latex?%5Chat%7B%5Cbeta%7D%5E%7Bridge%7D%20%3D%20argmin_%5Cbeta%20%5B%5Csum_%7Bi%3D1%7D%5EN%28y_i%20-%20%5Cbeta_0%20-%5Csum%5Ep_%7Bj%3D1%7Dx_%7Bij%7D%5Cbeta_j%29%5E2%20%2B%20%5Clambda%5Csum%5Ep_%7Bj%3D1%7D%5Cbeta%5E2_j%5D "\hat{\beta}^{ridge} = argmin_\beta [\sum_{i=1}^N(y_i - \beta_0 -\sum^p_{j=1}x_{ij}\beta_j)^2 + \lambda\sum^p_{j=1}\beta^2_j]")

#### Lasso Regression

![\\hat{\\beta}^{lasso} = argmin\_\\beta \[\\frac{1}{2}\\sum\_{i=1}^N(y\_i - \\beta\_0 -\\sum^p\_{j=1}x\_{ij}\\beta\_j)^2 + \\lambda\\sum^p\_{j=1}|\\beta\_j|\]](https://latex.codecogs.com/png.latex?%5Chat%7B%5Cbeta%7D%5E%7Blasso%7D%20%3D%20argmin_%5Cbeta%20%5B%5Cfrac%7B1%7D%7B2%7D%5Csum_%7Bi%3D1%7D%5EN%28y_i%20-%20%5Cbeta_0%20-%5Csum%5Ep_%7Bj%3D1%7Dx_%7Bij%7D%5Cbeta_j%29%5E2%20%2B%20%5Clambda%5Csum%5Ep_%7Bj%3D1%7D%7C%5Cbeta_j%7C%5D "\hat{\beta}^{lasso} = argmin_\beta [\frac{1}{2}\sum_{i=1}^N(y_i - \beta_0 -\sum^p_{j=1}x_{ij}\beta_j)^2 + \lambda\sum^p_{j=1}|\beta_j|]")

### Logistic Regresion

In general modeling:

![p(X) = p(Y=y|X)](https://latex.codecogs.com/png.latex?p%28X%29%20%3D%20p%28Y%3Dy%7CX%29 "p(X) = p(Y=y|X)")

![log\\frac{p(X)}{1-p(X)} = \\beta\_0 + \\beta\_1X\_1 + ... + \\beta\_pX\_p](https://latex.codecogs.com/png.latex?log%5Cfrac%7Bp%28X%29%7D%7B1-p%28X%29%7D%20%3D%20%5Cbeta_0%20%2B%20%5Cbeta_1X_1%20%2B%20...%20%2B%20%5Cbeta_pX_p "log\frac{p(X)}{1-p(X)} = \beta_0 + \beta_1X_1 + ... + \beta_pX_p")

![p(X) = \\frac{e^{\\beta\_0 + \\beta\_1X\_1 + ... + \\beta\_pX\_p}}{1 + e^{\\beta\_0 + \\beta\_1X\_1 + ... + \\beta\_pX\_p}}](https://latex.codecogs.com/png.latex?p%28X%29%20%3D%20%5Cfrac%7Be%5E%7B%5Cbeta_0%20%2B%20%5Cbeta_1X_1%20%2B%20...%20%2B%20%5Cbeta_pX_p%7D%7D%7B1%20%2B%20e%5E%7B%5Cbeta_0%20%2B%20%5Cbeta_1X_1%20%2B%20...%20%2B%20%5Cbeta_pX_p%7D%7D "p(X) = \frac{e^{\beta_0 + \beta_1X_1 + ... + \beta_pX_p}}{1 + e^{\beta_0 + \beta_1X_1 + ... + \beta_pX_p}}")

Estimating regression coefficients:

![\\ell(\\beta\_0, \\beta\_1 ... \\beta\_p) = \\prod\_{i:y\_i=1}p(x\_i) \\prod\_{i^{'}:y\_i^{'}=0} (1-p(x\_{i^{'}}))](https://latex.codecogs.com/png.latex?%5Cell%28%5Cbeta_0%2C%20%5Cbeta_1%20...%20%5Cbeta_p%29%20%3D%20%5Cprod_%7Bi%3Ay_i%3D1%7Dp%28x_i%29%20%5Cprod_%7Bi%5E%7B%27%7D%3Ay_i%5E%7B%27%7D%3D0%7D%20%281-p%28x_%7Bi%5E%7B%27%7D%7D%29%29 "\ell(\beta_0, \beta_1 ... \beta_p) = \prod_{i:y_i=1}p(x_i) \prod_{i^{'}:y_i^{'}=0} (1-p(x_{i^{'}}))")

Cost function:

![J(\\theta) = -\\frac{1}{m}\\sum\_{i=1}^m\[y^{(i)}log(h\_{\\theta}(x^{(i)})) + (1-y^{(i)})log(1-h\_{\\theta}(x^{(i)}))\]](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29%20%3D%20-%5Cfrac%7B1%7D%7Bm%7D%5Csum_%7Bi%3D1%7D%5Em%5By%5E%7B%28i%29%7Dlog%28h_%7B%5Ctheta%7D%28x%5E%7B%28i%29%7D%29%29%20%2B%20%281-y%5E%7B%28i%29%7D%29log%281-h_%7B%5Ctheta%7D%28x%5E%7B%28i%29%7D%29%29%5D "J(\theta) = -\frac{1}{m}\sum_{i=1}^m[y^{(i)}log(h_{\theta}(x^{(i)})) + (1-y^{(i)})log(1-h_{\theta}(x^{(i)}))]")

### Naive Bayes

![p(y|x\_1, ..., x\_n)\\propto p(y)\\prod\_{i}^{n}P(x\_i|y)](https://latex.codecogs.com/png.latex?p%28y%7Cx_1%2C%20...%2C%20x_n%29%5Cpropto%20p%28y%29%5Cprod_%7Bi%7D%5E%7Bn%7DP%28x_i%7Cy%29 "p(y|x_1, ..., x_n)\propto p(y)\prod_{i}^{n}P(x_i|y)")

![y = argmax\_yP(y)\\prod\_{i}^{n}P(x\_i|y)](https://latex.codecogs.com/png.latex?y%20%3D%20argmax_yP%28y%29%5Cprod_%7Bi%7D%5E%7Bn%7DP%28x_i%7Cy%29 "y = argmax_yP(y)\prod_{i}^{n}P(x_i|y)")

Tree
----

### Regression

General cost function

![\\sum^{J}\_{j=1}\\sum\_{i\\in{R\_j}}(y\_i-\\hat{y}\_{R\_j})^2](https://latex.codecogs.com/png.latex?%5Csum%5E%7BJ%7D_%7Bj%3D1%7D%5Csum_%7Bi%5Cin%7BR_j%7D%7D%28y_i-%5Chat%7By%7D_%7BR_j%7D%29%5E2 "\sum^{J}_{j=1}\sum_{i\in{R_j}}(y_i-\hat{y}_{R_j})^2")

Cost function at each split

![\\sum\_{i: x\_i\\in{R\_1}(j,s)}(y\_i-\\hat{y}\_{R\_1})^2 + \\sum\_{i: x\_i\\in{R\_2}(j,s)}(y\_i-\\hat{y}\_{R\_2})^2](https://latex.codecogs.com/png.latex?%5Csum_%7Bi%3A%20x_i%5Cin%7BR_1%7D%28j%2Cs%29%7D%28y_i-%5Chat%7By%7D_%7BR_1%7D%29%5E2%20%2B%20%5Csum_%7Bi%3A%20x_i%5Cin%7BR_2%7D%28j%2Cs%29%7D%28y_i-%5Chat%7By%7D_%7BR_2%7D%29%5E2 "\sum_{i: x_i\in{R_1}(j,s)}(y_i-\hat{y}_{R_1})^2 + \sum_{i: x_i\in{R_2}(j,s)}(y_i-\hat{y}_{R_2})^2")

Pruned tree with ![\\alpha](https://latex.codecogs.com/png.latex?%5Calpha "\alpha") cost function

![N\_m = \\\#{x\_i\\in{R\_m}}](https://latex.codecogs.com/png.latex?N_m%20%3D%20%5C%23%7Bx_i%5Cin%7BR_m%7D%7D "N_m = \#{x_i\in{R_m}}")

![\\hat{c}\_m = \\frac{1}{N\_m}\\sum\_{x\_i\\in{R\_m}}y\_i](https://latex.codecogs.com/png.latex?%5Chat%7Bc%7D_m%20%3D%20%5Cfrac%7B1%7D%7BN_m%7D%5Csum_%7Bx_i%5Cin%7BR_m%7D%7Dy_i "\hat{c}_m = \frac{1}{N_m}\sum_{x_i\in{R_m}}y_i")

![Q\_m(T) = \\frac{1}{N\_m}\\sum\_{x\_i\\in{R\_m}}(y\_i - \\hat{c}\_m)^2](https://latex.codecogs.com/png.latex?Q_m%28T%29%20%3D%20%5Cfrac%7B1%7D%7BN_m%7D%5Csum_%7Bx_i%5Cin%7BR_m%7D%7D%28y_i%20-%20%5Chat%7Bc%7D_m%29%5E2 "Q_m(T) = \frac{1}{N_m}\sum_{x_i\in{R_m}}(y_i - \hat{c}_m)^2")

![\\mathcal{C}\_{\\alpha}(T) = \\sum^{|T|}\_{m=1}N\_{m}Q\_{m}(T) + \\alpha\\left|T\\right|](https://latex.codecogs.com/png.latex?%5Cmathcal%7BC%7D_%7B%5Calpha%7D%28T%29%20%3D%20%5Csum%5E%7B%7CT%7C%7D_%7Bm%3D1%7DN_%7Bm%7DQ_%7Bm%7D%28T%29%20%2B%20%5Calpha%5Cleft%7CT%5Cright%7C "\mathcal{C}_{\alpha}(T) = \sum^{|T|}_{m=1}N_{m}Q_{m}(T) + \alpha\left|T\right|")

### Classification

Gini index

![G = \\sum^{K}\_{k=1}\\hat{p}\_{mk}(1 - \\hat{p}\_{mk})](https://latex.codecogs.com/png.latex?G%20%3D%20%5Csum%5E%7BK%7D_%7Bk%3D1%7D%5Chat%7Bp%7D_%7Bmk%7D%281%20-%20%5Chat%7Bp%7D_%7Bmk%7D%29 "G = \sum^{K}_{k=1}\hat{p}_{mk}(1 - \hat{p}_{mk})")

Entropy

![D = -\\sum^{K}\_{k=1}\\hat{p}\_{mk}log\\hat{p}\_{mk}](https://latex.codecogs.com/png.latex?D%20%3D%20-%5Csum%5E%7BK%7D_%7Bk%3D1%7D%5Chat%7Bp%7D_%7Bmk%7Dlog%5Chat%7Bp%7D_%7Bmk%7D "D = -\sum^{K}_{k=1}\hat{p}_{mk}log\hat{p}_{mk}")

Information gain

![IG(T,a) = H(T) - H(T|a) = -\\sum^{K}\_{k=1}\\hat{p}\_{mk}log\\hat{p}\_{mk} - \\sum\_{a}p(a)\\sum^J\_{i=1}-Pr(i|a)log\_2Pr(i|a)](https://latex.codecogs.com/png.latex?IG%28T%2Ca%29%20%3D%20H%28T%29%20-%20H%28T%7Ca%29%20%3D%20-%5Csum%5E%7BK%7D_%7Bk%3D1%7D%5Chat%7Bp%7D_%7Bmk%7Dlog%5Chat%7Bp%7D_%7Bmk%7D%20-%20%5Csum_%7Ba%7Dp%28a%29%5Csum%5EJ_%7Bi%3D1%7D-Pr%28i%7Ca%29log_2Pr%28i%7Ca%29 "IG(T,a) = H(T) - H(T|a) = -\sum^{K}_{k=1}\hat{p}_{mk}log\hat{p}_{mk} - \sum_{a}p(a)\sum^J_{i=1}-Pr(i|a)log_2Pr(i|a)")

### Bagging

![\\hat{f}\_{bag}(x) = \\frac{1}{B}\\sum^{B}\_{b=1}\\hat{f}^{\*b}(x)](https://latex.codecogs.com/png.latex?%5Chat%7Bf%7D_%7Bbag%7D%28x%29%20%3D%20%5Cfrac%7B1%7D%7BB%7D%5Csum%5E%7BB%7D_%7Bb%3D1%7D%5Chat%7Bf%7D%5E%7B%2Ab%7D%28x%29 "\hat{f}_{bag}(x) = \frac{1}{B}\sum^{B}_{b=1}\hat{f}^{*b}(x)")

### Notes

![J](https://latex.codecogs.com/png.latex?J "J") = Divides ![s](https://latex.codecogs.com/png.latex?s "s") = cutoff point Divide ![X\_1, X\_2, ... X\_p](https://latex.codecogs.com/png.latex?X_1%2C%20X_2%2C%20...%20X_p "X_1, X_2, ... X_p") into ![J](https://latex.codecogs.com/png.latex?J "J") distinct non-overlapping regions, ![R\_1, R\_2, ..., R\_J](https://latex.codecogs.com/png.latex?R_1%2C%20R_2%2C%20...%2C%20R_J "R_1, R_2, ..., R_J")

Support Vector Machines
=======================

Maximal Marigin classifier

![\\max\_{\\beta\_{0}, \\beta\_{1},...,\\beta\_{p},M}M](https://latex.codecogs.com/png.latex?%5Cmax_%7B%5Cbeta_%7B0%7D%2C%20%5Cbeta_%7B1%7D%2C...%2C%5Cbeta_%7Bp%7D%2CM%7DM "\max_{\beta_{0}, \beta_{1},...,\beta_{p},M}M")

 subject to ![\\sum^{p}\_{j=1}\\beta^{2}\_{j}=1](https://latex.codecogs.com/png.latex?%5Csum%5E%7Bp%7D_%7Bj%3D1%7D%5Cbeta%5E%7B2%7D_%7Bj%7D%3D1 "\sum^{p}_{j=1}\beta^{2}_{j}=1"),

![y\_{i}(\\beta\_{0} + \\beta\_{1}x\_{i1} + ... + \\beta\_{p}x\_{ip} \\geq M \\forall i = 1, ..., n](https://latex.codecogs.com/png.latex?y_%7Bi%7D%28%5Cbeta_%7B0%7D%20%2B%20%5Cbeta_%7B1%7Dx_%7Bi1%7D%20%2B%20...%20%2B%20%5Cbeta_%7Bp%7Dx_%7Bip%7D%20%5Cgeq%20M%20%5Cforall%20i%20%3D%201%2C%20...%2C%20n "y_{i}(\beta_{0} + \beta_{1}x_{i1} + ... + \beta_{p}x_{ip} \geq M \forall i = 1, ..., n")

Notes
-----

![x](https://latex.codecogs.com/png.latex?x "x") parameterized by ![\\theta](https://latex.codecogs.com/png.latex?%5Ctheta "\theta"):

![x;\\theta](https://latex.codecogs.com/png.latex?x%3B%5Ctheta "x;\theta")
