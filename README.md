# Distribution Fitting

This R code uses the R *poweRlaw* package to determine (estimate) which distribution fits best to a given data-set of a graph.
The R *poweRlaw* package is an implementation of maximum likelihood estimators as described in that supports power-law, log-normal, Poisson, and exponential distributions.

## Steps

1. **Estimate xmin:** As most distributions only apply for values greater than some minimum xmin, first the lower threshold xmin (i.e. the estimated lower cutoff) is estimated using the *estimate_xmin* function, which implements a Kolmogorov-Smirnov (KS) approach. The KS statistic is a two sample test which is used to test whether two samples come from the same distribution. The KS statistic is the maximum distance between the data and the fitted model Cumulative Distribution Functions (CDFs).
2. **Uncertainty of xmin:** In order to quantify the uncertainty of the estimated thresholds xmin the *poweRlaw bootstrap function* is used.
3. **Estimate parameters:** After updating the xmin values with the respective estimates, the parameters of the distributions
are estimated using the *estimate_pars* function. This function estimates the parameters by using their maximum likelihood estimator.
4. **Standard deviations of parameters:** The standard deviations for the parameters are derived using again the *bootstrap* and the *sd* functions.
5. **Goodness of fit:** A goodness-of-fit test is performed, which generates a p-value that quantifies the plausibility of the hypothesis that the graph follows a certain distribution. Therefore, the poweRlaw *bootstrap_p* function was used. This function is based on the measurement of the distance between the distribution of the data-set and the hypothesized model, which is then compared with the distance measurements for comparable synthetic data-sets. Large p-values (i.e. p-values close to 1) mean that the difference between the observed
data and the respective model can be attributed to statistical fluctuations alone and imply hence, that the model is a plausible fit. A small p-value, on the other hand, means that the model is not a plausible fit for the data.
6. **Likelihood-ratio test:**


[1] A. Clauset, C. R. Shalizi, and M. E. J. Newman. Power-Law Distributions in Empirical Data. Society for Industrial and Applied Mathematics, 51(4):661–703, 2009.
