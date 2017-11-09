# Distribution Fitting

This R code uses the R *poweRlaw* package to determine (estimate) which distribution fits best to a given data-set of a graph.
The R *poweRlaw* package is an implementation of maximum likelihood estimators as described in [1] that supports power-law, log-normal, Poisson, and exponential distributions.

## Steps

1. **Estimate xmin:** As most distributions only apply for values greater than some minimum xmin, first the lower threshold xmin (i.e. the estimated lower cutoff) is estimated using the *estimate_xmin* function, which implements a Kolmogorov-Smirnov (KS) approach. The KS statistic is a two sample test which is used to test whether two samples come from the same distribution. The KS statistic is the maximum distance between the data and the fitted model Cumulative Distribution Functions (CDFs).
2. **Uncertainty of xmin:** In order to quantify the uncertainty of the estimated thresholds xmin the *poweRlaw bootstrap function* is used.


[1] A. Clauset, C. R. Shalizi, and M. E. J. Newman. Power-Law Distributions in Empirical Data. Society for Industrial and Applied Mathematics, 51(4):661–703, 2009.
