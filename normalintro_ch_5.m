%% Input data
% Define a grid of values over which the normal distribution
% will be evaluated.

x = (-9:0.1:9)';

% Set the parameters of the normal distribution
mean = 3;
variance = 4;
sigma = sqrt(variance);

%% Density function
% Compute the probability density function (PDF) using MATLAB's
% built-in function normpdf.

ypdf = normpdf(x, mean, sigma);

% Manual implementation of the normal density function.
% This is used to verify the correctness of the built-in function.

ypdfCHK = exp(-0.5 * ((x - mean)./sigma).^2) ./ (sqrt(2*pi) .* sigma);

disp('Checking equality of implementations')

% Check that the two implementations give the same result
assert(max(abs(ypdf - ypdfCHK)) < 1e-10, ...
    'Error in manual implementation of the density')

%% Plotting PDF and CDF
% Plot both the density function and the cumulative distribution
% function (CDF) of the normal distribution.

subplot(2,1,1)
plot(x, ypdf);

% Convert parameters to strings for display in titles
meanStr = num2str(mean);
varStr  = num2str(variance);

title(['Density function: N(' meanStr ',' varStr ')'])
ylabel('f(x)')

subplot(2,1,2)

% Compute and plot the cumulative distribution function
ycdf = normcdf(x, mean, sigma);
plot(x, ycdf);

title(['CDF: N(' meanStr ',' varStr ')'])
ylabel('F(x)=Pr(X<x)')

%% Plot using comet
% This section illustrates an alternative dynamic visualization
% of the PDF and CDF using the comet function.

close all

subplot(2,1,1)
comet(x, ypdf);
title(['Density function: N(' meanStr ',' varStr ')'])
ylabel('f(x)')

subplot(2,1,2)
comet(x, ycdf);
title(['CDF: N(' meanStr ',' varStr ')'])
ylabel('F(x)=Pr(X<x)')
