%% Generation of random numbers from a normal distribution
% Set the random seed to ensure reproducibility of the results.

seed = 12345;
rng(seed)

% Number of random observations and dimensionality
n = 10000;      % sample size
p = 1;          % number of variables

% Parameters of the normal distribution
sigma = 10;     % standard deviation
mu = 6;         % mean

%% Random sample generation using randn
% Generate random numbers from the standard normal distribution
% and then scale and shift them to obtain N(mu, sigma^2).

X = sigma * randn(n, p) + mu;

%% Random sample generation using normrnd
% Reinitialize the random seed so that the same random sequence is used.

rng(seed)

% Generate random numbers directly from the normal distribution
X1 = normrnd(mu, sigma, n, p);

% Verify that the two generation methods produce identical samples
assert(isequal(X, X1), "Random samples differ")

%% Visualization
% Plot a histogram of the generated random sample to visualize
% its empirical distribution.

histogram(X)
title(['Histogram of ' num2str(n) ...
       ' random numbers from N(' ...
       num2str(mu) ',' num2str(sigma^2) ')'])
disp('Done')

