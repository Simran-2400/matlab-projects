%% Random data generation
% Set the random seed to ensure reproducibility of the results.

rng(100)

% Number of random observations to generate
n = 1000;

% Generate n observations from a standard normal distribution
x = randn(n,1);

% Define the class boundaries (bin edges) for discretization
% The first and last classes are open-ended using -Inf and Inf
bins = [-Inf; -2; 0; 1.5; Inf];

%% Frequencies via the histogram function
% Compute the frequency distribution using the histogram function.
% The histogram object stores the frequencies in the property "Values".

h = histogram(x, bins);

%% Frequencies via the histcounts function
% Compute the same frequency distribution using histcounts.
% This function directly returns the frequencies.

freqWithHistCounts = histcounts(x, bins);

% Verify that both approaches produce identical frequencies
assert(isequal(freqWithHistCounts, h.Values), ...
    "Frequencies via histogram differ from frequencies via histcounts");

%% Creation of the frequency table
% Create a table that reports the frequencies together with
% meaningful class labels as row names.

rowNames = {'<=-2', '(-2, 0]', '(0, 1.5]', '>1.5'};

FreqTable = array2table(h.Values', ...
    'VariableNames', {'Frequencies'}, ...
    'RowNames', rowNames);

disp(FreqTable)

%% Call to function discretize with 2, 3, and 4 input arguments
% The discretize function assigns each observation to a class
% based on the specified bin edges.

%% Discretize with two input arguments
% Returns a numeric vector indicating the class membership
% of each observation.

class_membership = discretize(x, bins);

disp("First 5 elements of class_membership (2 inputs)")
disp(class_membership(1:5)')

% Display absolute and percentage frequencies
disp('Absolute and percentage frequency distribution')
tabulate(class_membership);

%% Discretize with three input arguments
% Specify the output as a categorical variable instead of numeric.

class_membership = discretize(x, bins, 'categorical');

disp("First 5 elements of class_membership (3 inputs)")
disp(class_membership(1:5)')

disp('Absolute and percentage frequency distribution')
tabulate(class_membership);

%% Discretize with four input arguments
% Assign custom labels to the categorical classes.

rowNames = {'Less than -2', ...
            'Between -2 and 0', ...
            'Between 0 and 1.5', ...
            'Greater than 1.5'};

class_membership = discretize(x, bins, 'categorical', rowNames);

disp("First 5 elements of class_membership (4 inputs)")
disp(class_membership(1:5))

disp('discretize with 4 inputs: custom labels')
disp('Absolute and percentage frequency distribution')
tabulate(class_membership);
