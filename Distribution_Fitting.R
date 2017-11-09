#Load the required libraries
library(igraph)
library(poweRlaw)

# Import the dataset (.csv)
dat=read.csv(file.choose(),header=TRUE)
el=as.matrix(dat)
el[,1]=as.character(el[,1])
el[,2]=as.character(el[,2])
n=graph.edgelist(el,directed=FALSE) 

# The degrees of the graph
d = degree(n)

############################# Power Law ################################

# Create a discrete power law object
m_pl = displ$new(d)

# Estimate the lower threshold
est_pl = estimate_xmin(m_pl)
est_pl

# Update the power law object with xmin
m_pl$setXmin(est_pl)

# Estimate the Parameters
estp_pl = estimate_pars(m_pl)
estp_pl

############################# Log-Normal ################################

# Create a log-normal object
m_ln = dislnorm$new(d)

# Estimate the lower threshold
est_ln = estimate_xmin(m_ln)
est_ln

# Update the log-normal object with xmin
m_ln$setXmin(est_ln)

# Estimate the Parameters
estp_ln = estimate_pars(m_ln)
estp_ln

############################# Poisson ################################

# Create a Poisson object
m_pois = dispois$new(d)

# Estimate the lower threshold
est_pois = estimate_xmin(m_pois)
est_pois

# Update the log-normal object with xmin
m_pois$setXmin(est_pois)

# Estimate the Parameters
estp_pois = estimate_pars(m_pois)
estp_pois

############################# Exponential ################################

# Create an exponential object
m_exp = disexp$new(d)

# Estimate the lower threshold
est_exp = estimate_xmin(m_exp)
est_exp

# Update the log-normal object with xmin
m_exp$setXmin(est_exp)

# Estimate the Parameters
estp_exp = estimate_pars(m_exp)
estp_exp

############################# Plotting ################################

# Plot the lines
cols = c(2,3,4,6)
plot(m_pl, ylab="CDF", xlab="")
lines(m_pl, col=2, lwd=2)
lines(m_ln, col=3, lwd=2)
lines(m_pois, col=4, lwd=2)
lines(m_exp, col=6, lwd=2)
legend(x = "bottomleft", inset=0.05, box.lty = 0, col = cols, lwd = 4,
       legend = c("power-law", "log-normal", "Poisson", "exponential"))

############################# Bootstrap ################################

b_pl = bootstrap(m_pl, no_of_sims = 5000, threads = parallel::detectCores())
b_pl

sd(b_pl$bootstraps[,2])
sd(b_pl$bootstraps[,3])

plot(b_pl)

b_ln = bootstrap(m_ln, no_of_sims = 5000, threads = parallel::detectCores())
b_ln

sd(b_ln$bootstraps[,2])
sd(b_ln$bootstraps[,3])
sd(b_ln$bootstraps[,4])

plot(b_ln)

b_poi = bootstrap(m_pois, no_of_sims = 5000, threads = parallel::detectCores())
b_poi

sd(b_poi$bootstraps[,2])
sd(b_poi$bootstraps[,3])

plot(b_poi)

b_exp = bootstrap(m_exp, no_of_sims = 5000, threads = parallel::detectCores())
b_exp

sd(b_exp$bootstraps[,2])
sd(b_exp$bootstraps[,3])

plot(b_exp)


############################# Bootstrap_p ################################

bs_pl = bootstrap_p(m_pl, no_of_sims = 5000, threads = parallel::detectCores())
bs_pl

bs_ln = bootstrap_p(m_ln, no_of_sims = 5000, threads = parallel::detectCores())
bs_ln

bs_pois = bootstrap_p(m_pois, no_of_sims = 5000, threads = parallel::detectCores())
bs_pois

bs_exp = bootstrap_p(m_exp, no_of_sims = 5000, threads = parallel::detectCores())
bs_exp

############################# Vuong Test ################################

# For this test the two distributions must have the same Xmin

m_pl$setXmin(m_ln$getXmin())
m_pl$setXmin(m_pois$getXmin())
m_pl$setXmin(m_exp$getXmin())

pl_ln = compare_distributions(m_pl,m_ln)
pl_ln

pl_pois = compare_distributions(m_pl,m_pois)
pl_pois

pl_exp = compare_distributions(m_pl,m_exp)
pl_exp

m_pois$setXmin(m_ln$getXmin())
m_ln$setXmin(m_exp$getXmin())

ln_pois = compare_distributions(m_ln,m_pois)
ln_pois

ln_exp = compare_distributions(m_ln,m_exp)
ln_exp

m_pois$setXmin(m_exp$getXmin())

pois_exp = compare_distributions(m_pois,m_exp)
pois_exp

