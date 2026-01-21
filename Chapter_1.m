%% CHAPTER 1 – INTRODUCTION TO MATLAB
% Course: Data Science for Management
% Description:
% This script contains commented solutions for Exercises 1.1–1.8.
% The objective is to understand basic MATLAB data structures,
% tables, indexing, logical subsetting, and saving results.

%% Exercise 1.1 – Creation of basic MATLAB arrays
% Objective:
% Demonstrate the creation of vectors and matrices using
% different orientations and indexing rules.

% Row vector
on = [0 1 2];

% Column vector
vn = [0; 1; 2];

% Matrix with two rows and three columns
mn = [0 1 2; 3 4 5];

% Vector created using start:step:end syntax
nd = 1:2:15;

%% Exercise 1.2 – String arrays: row vs column
% Objective:
% Illustrate the difference between a row string array
% and a column string array in MATLAB.

% Row string array (1 × 2)
ot = ["John" "Doe"];

% Column string array (2 × 1)
vt = ["John"; "Doe"];

%% Exercise 1.3 – Cell arrays with heterogeneous data
% Objective:
% Show how cell arrays can store different data types
% such as numbers, strings, matrices, and vectors.

cm = { ...
    1, 2, 3; ...
    "Buongiorno a tutti", rand(3,2), [11; 22; 33] ...
};

%% Exercise 1.4 – Structures
% Objective:
% Demonstrate how to create a structure and assign fields
% containing heterogeneous data.

st = struct;
st.a = 1;
st.b = 2;
st.c = 3;
st.d = "Buongiorno a tutti";
st.e = rand(3,2);
st.f = [11; 22; 33];

%% Exercise 1.5.1 – Creation of a table
% Objective:
% Create a table combining numeric, string, and logical data,
% and assign variable names and row names.

% Define the data
numericData = (1:10)'; 

stringData = repmat(["LTD"; "LLC"; "PLC"], 4, 1);
stringData = stringData(1:10);

booleanData = logical([true; false; true; false; true; ...
                       false; true; false; true; false]);

% Create the table
T = table(numericData, stringData, booleanData, ...
    'VariableNames', {'NumericColumn','StringColumn','BooleanColumn'}, ...
    'RowNames', {'CompanyA','CompanyB','CompanyC','CompanyD', ...
                 'CompanyE','CompanyF','CompanyG','CompanyH', ...
                 'CompanyI','CompanyJ'});

disp(T);

%% Exercise 1.5 – From array to table
% Objective:
% Convert a numeric matrix into a table with meaningful
% variable names and row names.

data = [110.63, 3.7;
        736871, 12157];

Summary = array2table( ...
    data, ...
    "VariableNames", ["Acquisti in euro","Numero visite"], ...
    "RowNames", ["Media mensile","Totale mensile"] ...
);

%% Exercise 1.6 – Importing data from Excel
% Objective:
% Read data from an Excel file into a MATLAB table.

Firm = readtable('Firm.xlsx', ...
    'Sheet','data', ...
    'Range','A1:J108', ...
    'ReadRowNames',0);

%% Exercise 1.7 – Indexing tables
% Objective:
% Extract rows and columns from a table using indices,
% variable names, and row names.

% Extract first 5 rows of column 7 as a table
solarray1 = Firm(1:5,7);

% Extract first 5 observations of Wage as an array
soltable1 = Firm.Wage(1:5);

% Extract multiple columns using column indices
solarray2 = Firm(1:5,[7 10]);

% Extract multiple variables using variable names
soltable2 = [Firm.Wage(1:5), Firm.Seniority(1:5)];

% Reload table with row names
Firm = readtable('Firm.xlsx', ...
    'Sheet','data', ...
    'Range','A1:J108', ...
    'ReadRowNames',1);

% Select rows by row name
rowP0219 = Firm('P0219',:);
rowP0219P0476 = Firm({'P0219','P0476'},:);

%% Exercise 1.8 – Logical subsetting of tables
% Objective:
% Filter table rows using logical conditions on variables.

subset1 = Firm(Firm.Gender == "F", :);

subset2 = Firm(Firm.Gender == "F" & Firm.Education == "B", :);

subset3 = Firm( ...
    (Firm.Gender == "F" & Firm.Education == "B") | ...
    (Firm.Gender == "M" & Firm.Wage > 4000), :);

subset4 = Firm(Firm.Wage >= 3000 & Firm.Wage < 3500, :);

%% Saving results (related to Chapter 1)
% Objective:
% Save variables, matrices, and tables in different file formats.

% Save cell array to MAT-file
save('myCell.mat','cm');

% Save matrix to text and Excel files
writematrix(data,'data.txt','Delimiter','tab');
writematrix(data,'data.xlsx');

% Save table to text and Excel files
writetable(Summary,'Summary.txt','Delimiter','tab','WriteRowNames',true);
writetable(Summary,'Summary.xlsx','WriteRowNames',true);

