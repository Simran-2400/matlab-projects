%% Probability calculations in N(mu, sigma^2)
% Define the parameters of the normal distribution.

mean = 3;
variance = 4;
sigma = sqrt(variance);

%% Probability P(X < 1.2)
% Compute the cumulative probability up to 1.2.

disp('--------------')
disp('P(X < 1.2) in N(3,4)')
disp(normcdf(1.2, mean, sigma))

%% Probability P(5 < X < 6)
% Compute the probability that the random variable
% lies between 5 and 6 using the CDF.

disp('--------------')
disp('P(5 < X < 6) in N(3,4)')
prob56 = normcdf(6, mean, sigma) - normcdf(5, mean, sigma);
disp(prob56)

%% Plotting P(5 < X < 6)
% Plot the density function and highlight the area
% corresponding to the probability P(5 < X < 6).

x = (-9:0.0001:9)';
ypdf = normpdf(x, mean, sigma);

plot(x, ypdf);
title(['Density: N(' num2str(mean) ',' num2str(variance) ')'])
hold('on')

% Identify indices corresponding to the interval [5, 6]
a = find(x <= 5, 1, 'last');
b = find(x >= 6, 1);

% Shade the probability area
fill(x(a:b), [0; ypdf(a+1:b-1); 0], 'g')

ylabel(['Pr(5 < X < 6) = ' num2str(prob56)])

%% Shading using normspec
% Alternative visualization using the built-in normspec function,
% which highlights probability regions automatically.

normspec([5 6], mean, sigma, 'inside')
title(['N(' num2str(mean) ',' num2str(variance) ')'])
ylabel(['Pr(5 < X < 6) = ' num2str(prob56)])

%% Shading using fill (alternative implementation)
% Manual shading of the probability area using fill.
% This section replicates the graphical result explicitly.

figure
x = (-9:0.0001:9)';
ypdf = normpdf(x, mean, sigma);

plot(x, ypdf);
title(['Density: N(' num2str(mean) ',' num2str(variance) ')'])
hold('on')

a = find(x <= 5, 1, 'last');
b = find(x >= 6, 1);

fill(x(a:b), [0; ypdf(a+1:b-1); 0], 'g')
ylabel(['Pr(5 < X < 6) = ' num2str(prob56)])

%% Quantile in N(3,4)
% Compute the 0.975 quantile of the distribution.
% This value leaves 2.5% of the probability mass to the right.
