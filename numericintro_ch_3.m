%% Data loading
% Load the dataset from an Excel file and store it as a table.
% Row names are read from the file.

miofile = "Firm.xlsx";
Xt = readtable(miofile, "ReadRowNames", true);

% Convert qualitative variables to categorical type
Xt.Gender = categorical(Xt.Gender);

% Education is defined as an ordinal categorical variable
Xt.Education = categorical(Xt.Education, {'A','B','C'}, 'Ordinal', true);

%% Extraction of quantitative variables
% Select the quantitative variables of interest and store them:
% - Xdq as a numeric matrix
% - Xtq as a table, preserving variable names

namesq = ["Wage" "CommutingTime" "SmartWorkHours" "Seniority"];
Xdq = Xt{:, namesq};      % Numeric matrix (observations × variables)
Xtq = Xt(:, namesq);      % Table with quantitative variables only

% Format numeric output with two decimal digits
format bank

%% Sample means
% Compute sample means by applying the mean function directly to the table.

means = mean(Xtq);
disp('Sample means (mean applied directly to the table)')
disp(means)

%% Sample medians
% Compute sample medians for the quantitative variables.

disp('Sample medians')
medians = median(Xtq);
disp(medians)

%% Sample standard deviations and coefficients of variation
% Compute standard deviations and the coefficient of variation (CV),
% defined as the ratio between the standard deviation and the mean.

scorr = std(Xtq);
disp('Coefficients of variation (CV)')
cvt = scorr ./ abs(means);
disp(cvt)

%% Skewness indices
% Measure the asymmetry of the distributions.
% The second argument set to 0 requests the unbiased estimator.

disp('Skewness indices (calculated via skewness)')
sk = skewness(Xdq, 0);
skT = array2table(sk, "VariableNames", namesq);
disp(skT)

%% Kurtosis indices
% Measure the tail heaviness of the distributions.
% The second argument set to 0 requests the unbiased estimator.

disp('Kurtosis indices (calculated via kurtosis)')
kur = kurtosis(Xdq, 0);
kurT = array2table(kur, "VariableNames", namesq);
disp(kurT)

%% Histogram plot of a quantitative variable
% Different ways to construct histograms for a numeric variable.

close all

% Default histogram
histogram(Xt.Wage)

% Histogram with a fixed number of bins
histogram(Xt.Wage, 10)

% Histogram with custom bin edges
histogram(Xt.Wage, 2000:500:4500)

% Histogram defined directly by bin edges and bin counts
histogram('BinEdges', 2000:500:3500, 'BinCounts', [20 10 12])

%% Histogram plot of a categorical variable
% Histograms can also be used to visualize categorical data.

% Default categorical histogram
histogram(Xt.Education)

% Histogram restricted to selected categories
histogram(Xt.Education, 'Categories', {'B','C'})

% Histogram with manually specified category counts
histogram('Categories', {'Si','No','Forse'}, 'BinCounts', [22 18 3])

% Histogram with modified bar width (Name,Value syntax)
histogram(Xt.Education, 'BarWidth', 0.99)

% Histogram with Name=Value syntax
histogram(Xt.Education, BarWidth=0.99)

% Histogram with output handle
NoName = histogram(Xt.Education, 'BarWidth', 0.5);

% Modify graphical properties using the object handle
NoName.FaceColor = 'r';          % Change bar color
NoName.Orientation = "horizontal";  % Change orientation
