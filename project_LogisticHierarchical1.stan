data {
  int<lower=0> N; // Total number of regimens
  int y[N]; // Number of response in the regimen
  //int<lower=0> D; // i=j
  //int<lower=4, upper=18> M; // i!=j
  int D[4];
  int M[14];
  row_vector[6] X[N]; // Design matrix(without intercept)
  int S[N]; // Number of trials for each regimen
}
parameters {
  real alpha;
  vector[N] theta;
  vector[6] beta;
}
model {
    alpha ~ normal(-0.405,4);
    beta ~ normal(0,1);
    theta ~ normal(0,0.04);
    for (i in D) 
    	y[i] ~ binomial(S[i], inv_logit(alpha + X[i] * beta));
    for (i in M) 
    	y[i] ~ binomial(S[i], inv_logit(alpha + X[i] * beta+ theta));
}
