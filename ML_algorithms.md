ML Algorithms
================
Christopher Chan
January 23, 2019

### Logistic Regresion

In general modeling:

![p(X) = p(Y=y|X)](https://latex.codecogs.com/png.latex?p%28X%29%20%3D%20p%28Y%3Dy%7CX%29 "p(X) = p(Y=y|X)")

![log\\frac{p(X)}{1-p(X)} = \\beta\_0 + \\beta\_1X\_1 + ... + \\beta\_pX\_p](https://latex.codecogs.com/png.latex?log%5Cfrac%7Bp%28X%29%7D%7B1-p%28X%29%7D%20%3D%20%5Cbeta_0%20%2B%20%5Cbeta_1X_1%20%2B%20...%20%2B%20%5Cbeta_pX_p "log\frac{p(X)}{1-p(X)} = \beta_0 + \beta_1X_1 + ... + \beta_pX_p")

![p(X) = \\frac{e^{\\beta\_0 + \\beta\_1X\_1 + ... + \\beta\_pX\_p}}{1 + e^{\\beta\_0 + \\beta\_1X\_1 + ... + \\beta\_pX\_p}}](https://latex.codecogs.com/png.latex?p%28X%29%20%3D%20%5Cfrac%7Be%5E%7B%5Cbeta_0%20%2B%20%5Cbeta_1X_1%20%2B%20...%20%2B%20%5Cbeta_pX_p%7D%7D%7B1%20%2B%20e%5E%7B%5Cbeta_0%20%2B%20%5Cbeta_1X_1%20%2B%20...%20%2B%20%5Cbeta_pX_p%7D%7D "p(X) = \frac{e^{\beta_0 + \beta_1X_1 + ... + \beta_pX_p}}{1 + e^{\beta_0 + \beta_1X_1 + ... + \beta_pX_p}}")

Estimating regression coefficients:

![\\ell(\\beta\_0, \\beta\_1 ... \\beta\_p) = \\prod\_{i:y\_i=1}p(x\_i) \\prod\_{i^{'}:y\_i^{'}=0} (1-p(x\_{i^{'}}))](https://latex.codecogs.com/png.latex?%5Cell%28%5Cbeta_0%2C%20%5Cbeta_1%20...%20%5Cbeta_p%29%20%3D%20%5Cprod_%7Bi%3Ay_i%3D1%7Dp%28x_i%29%20%5Cprod_%7Bi%5E%7B%27%7D%3Ay_i%5E%7B%27%7D%3D0%7D%20%281-p%28x_%7Bi%5E%7B%27%7D%7D%29%29 "\ell(\beta_0, \beta_1 ... \beta_p) = \prod_{i:y_i=1}p(x_i) \prod_{i^{'}:y_i^{'}=0} (1-p(x_{i^{'}}))")

### Naive Bayes

![p(y|x\_1, ..., x\_n)\\propto p(y)\\prod\_{i}^{n}P(x\_i|y)](https://latex.codecogs.com/png.latex?p%28y%7Cx_1%2C%20...%2C%20x_n%29%5Cpropto%20p%28y%29%5Cprod_%7Bi%7D%5E%7Bn%7DP%28x_i%7Cy%29 "p(y|x_1, ..., x_n)\propto p(y)\prod_{i}^{n}P(x_i|y)")

![y = argmax\_yP(y)\\prod\_{i}^{n}P(x\_i|y)](https://latex.codecogs.com/png.latex?y%20%3D%20argmax_yP%28y%29%5Cprod_%7Bi%7D%5E%7Bn%7DP%28x_i%7Cy%29 "y = argmax_yP(y)\prod_{i}^{n}P(x_i|y)")

### Notes

![x](https://latex.codecogs.com/png.latex?x "x") parameterized by ![\\theta](https://latex.codecogs.com/png.latex?%5Ctheta "\theta"):

![x;\\theta](https://latex.codecogs.com/png.latex?x%3B%5Ctheta "x;\theta")