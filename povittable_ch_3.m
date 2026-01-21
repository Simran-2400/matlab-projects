%% Data loading
% Load the dataset from the Excel file into a table.
% Row names are read from the file.

myfile = "Firm.xlsx";
X = readtable(myfile, "ReadRowNames", true);

%% Construction of pivot tables using the pivot function
% This section illustrates different ways of constructing pivot tables
% using qualitative and quantitative variables.

%% Pivot with one grouping variable on rows
% Variable Gender is placed on the rows, counting frequencies.

pivot(X, 'Rows', 'Gender')

% Place the row categories directly as row names
pivot(X, 'Rows', 'Gender', 'RowLabelPlacement', 'rownames')

%% Pivot with two qualitative variables
% Gender on rows and Education on columns.
% Frequencies are shown in the table cells.

pivot(X, 'Rows', 'Gender', 'Columns', 'Education')

% Same table, including totals for rows and columns
pivot(X, 'Rows', 'Gender', 'Columns', 'Education', 'IncludeTotals', true)

% Same table with row labels stored as row names
pivot(X, 'Rows', 'Gender', 'Columns', 'Education', ...
    'IncludeTotals', true, 'RowLabelPlacement', 'rownames')

%% Pivot table with a quantitative variable inside
% Average Wage is computed for each Gender–Education combination.

pivot(X, 'Rows', 'Gender', 'Columns', 'Education', ...
    'DataVariable', 'Wage', 'Method', 'mean')

% Same pivot table with overall averages added
pivot(X, 'Rows', 'Gender', 'Columns', 'Education', ...
    'DataVariable', 'Wage', 'Method', 'mean', 'IncludeTotals', true)

%% Pivot table with multiple statistics
% Compute both minimum and maximum Wage within each group.

method = @(x) [min(x) max(x)];
pv3 = pivot(X, 'Rows', 'Gender', 'Columns', 'Education', ...
    'DataVariable', 'Wage', 'Method', method);
disp(pv3)

%% Pivot table with quantitative variable on rows
% Wage is discretized into 5 classes before creating the pivot table.

pivot(X, 'Rows', 'Wage', 'Columns', 'Education', 'RowsBinMethod', 5)

%% Beginning of Exercise 3.12
% Modify the dataset slightly to illustrate the effect of binning.

X1 = X;
X1.Wage(1) = 2000;

%% Pivot with predefined class intervals (left-closed)
disp('Pivot table point 1)')
pv1 = pivot(X1, 'Rows', 'Wage', 'Columns', 'Education', ...
    'RowsBinMethod', 1500:500:4500);
disp(pv1)

%% Pivot with right-closed classes
disp('Pivot table point 2)')
pv2 = pivot(X1, 'Rows', 'Wage', 'Columns', 'Education', ...
    'RowsBinMethod', 1500:500:4500, 'IncludedEdge', 'right');
disp(pv2)

%% Pivot with multiple grouping variables on rows
% Gender and Education are used jointly on the rows.
% Seniority is discretized into classes on the columns.

disp('Pivot table point 3)')
pv3 = pivot(X1, 'Rows', {'Gender', 'Education'}, 'Columns', 'Seniority', ...
    'ColumnsBinMethod', 0:15:45);
disp(pv3)

%% Pivot with two quantitative variables grouped on rows
% Wage and Seniority are both discretized into classes.

disp('Pivot table point 4)')
pv4 = pivot(X1, 'Rows', {'Wage', 'Seniority'}, 'Columns', 'Education', ...
    'RowsBinMethod', {1500:1000:4500, 0:15:45});
disp(pv4)

%% Alternative syntax using string arrays (not in the book)
% Demonstrates that grouping variables can also be specified
% using string arrays instead of cell arrays.

pv4chk = pivot(X1, 'Rows', ["Wage", "Seniority"], 'Columns', 'Education', ...
    'RowsBinMethod', {1500:1000:4500, 0:15:45});

assert(isequal(pv4, pv4chk), ...
    "Cell array or string array specification is not equivalent")

%% Row names with combined grouping criteria
% When multiple row variables are used, row names can be generated
% by combining the grouping criteria.

pv4WithRowNames = pivot(X1, 'Rows', {'Gender', 'Education'}, ...
    'Columns', 'Seniority', 'ColumnsBinMethod', 0:15:45, ...
    'RowLabelPlacement', 'rownames');
disp(pv4WithRowNames)

%% Pivot with mixed grouping rules
% Gender is treated as qualitative ('none'), while Seniority
% is discretized into classes.
% Median Wage is computed within each group.

disp('Pivot table point 5)')
pv5 = pivot(X1, 'Rows', {'Gender', 'Seniority'}, 'Columns', 'Education', ...
    'RowsBinMethod', {'none', [0 20 30 45]}, ...
    'DataVariable', 'Wage', 'Method', 'median');
disp(pv5)

%% Beginning of Exercise 3.13
% Multiple variables are placed on the columns.
% By default, MATLAB creates nested tables.

disp('Pivot table pv6')
pv6 = pivot(X1, 'Columns', {'Gender', 'Seniority'}, 'Rows', 'Education', ...
    'ColumnsBinMethod', {'none', [0 20 45]}, ...
    'DataVariable', 'Wage', 'Method', 'min');
disp(pv6)

% Display the variable names of the nested output
disp('Variable names of pv6')
disp(pv6.Properties.VariableNames)

%% Flat output format
% Using 'OutputFormat','flat' concatenates category names
% and avoids nested tables.

disp('Pivot table pv7')
pv7 = pivot(X1, 'Columns', {'Gender', 'Seniority'}, 'Rows', 'Education', ...
    'ColumnsBinMethod', {'none', [0 20 45]}, ...
    'DataVariable', 'Wage', 'Method', 'min', ...
    'OutputFormat', 'flat');
disp(pv7)

disp('Variable names of pv7')
disp(pv7.Properties.VariableNames)

%% Flat output with row names
pv8 = pivot(X1, 'Columns', {'Gender', 'Seniority'}, 'Rows', 'Education', ...
    'ColumnsBinMethod', {'none', [0 20 45]}, ...
    'DataVariable', 'Wage', 'Method', 'min', ...
    'OutputFormat', 'flat', 'RowLabelPlacement', 'rownames');
disp(pv8)

%% Pivot tables using Method 'none' (MATLAB version ≥ 2025a)
% This section demonstrates how to build a pivot table starting
% from an already summarized table.

close all

myfile = "Firm.xlsx";
X = readtable(myfile, "ReadRowNames", true);

groupingVARS = {'Gender', 'Education'};
statOfInterest = "mean";
varOfInterest = "Wage";

% Compute grouped statistics using grpstats
Xtab = grpstats(X, groupingVARS, statOfInterest, ...
    "DataVars", varOfInterest);
disp('Input table to be reorganized')
disp(Xtab)

%% Pivot table after reorganization
% Reorganize the grouped table using pivot with Method 'none'.

TBL = pivot(Xtab, 'Rows', 'Gender', 'Columns', 'Education', ...
    'Method', 'none', 'DataVariable', 'mean_Wage', ...
    'RowLabelPlacement', 'rownames');
disp('Output table')
disp(TBL)
