data {
  int<lower=0> n;
  int<lower=0> y[n];
  vector[n] e;
}

parameters {
  real alpha;
}

model {
    y ~ poisson(exp(e+alpha));
}
generated quantities {
  int n_ppc[n];
  real log_lik[n];

  // Draw posterior predictive data set
  for (i in 1:n) {
    n_ppc[i] = poisson_rng(exp(e[i]+alpha));
  }
  
  // Compute pointwise log likelihood
  for (i in 1:n) {
    log_lik[i] = poisson_log_lpmf(y[i] | (e[i] + alpha));
    //log_lik[i] = poisson_lpmf(y[i] | exp(e[i] + alpha));
  }
}
