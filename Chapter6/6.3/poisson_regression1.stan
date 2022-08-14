data {
  int<lower=0> n;
  int<lower=0> y[n];
  vector[n] x;
  vector[n] e;
}

parameters {
  real alpha;
  real beta;
}

model {
    y ~ poisson(exp(e+alpha+beta*x));
}

generated quantities {
  int n_ppc[n];
  real log_lik[n];

  // Draw posterior predictive data set
  for (i in 1:n) {
    n_ppc[i] = poisson_rng(exp(e[i] + alpha + beta * x[i]));
  }
  
  // Compute pointwise log likelihood
  for (i in 1:n) {
    log_lik[i] = poisson_log_lpmf(y[i] | (e[i] + alpha + beta * x[i]));
    //log_lik[i] = poisson_lpmf(y[i] | exp(e[i] + alpha + beta * x[i]));
  }
}
