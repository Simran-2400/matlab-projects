%% Personalized import
% This section demonstrates how to customize the import process
% when reading data from an Excel file into a timetable.

filename = "FTSeMibTitoliSel.xlsx";

% Automatically detect import options from the file
opts = detectImportOptions(filename);

% Display the detected variable types
disp(opts.VariableTypes)

% Preview the data using the detected options
preview(filename, opts)

% Modify the variable types of selected columns
% (for example, forcing numeric interpretation)
opts.VariableTypes([4 7]) = {'double'};

% Read the data as a timetable using the customized options
Y = readtimetable(filename, opts);

% Display the first rows of the timetable
head(Y)

%% Change periodicity: retime and convert2annual
% This section shows two equivalent ways of aggregating time-series data
% from a higher frequency to an annual frequency.

% Specify the aggregation function to be applied
funzioneRichiesta = "max";

%% Aggregation using retime
% Aggregate the timetable to yearly frequency using the selected function.

Y1 = retime(Y, "yearly", funzioneRichiesta);

% Adjust the row times so that each observation is associated
% with the end of the corresponding year
newDates = dateshift(Y1.Properties.RowTimes, 'end', 'year');
Y1.Properties.RowTimes = newDates;

%% Aggregation using convert2annual
% Perform the same annual aggregation using convert2annual.

Y2 = convert2annual(Y, 'Aggregation', funzioneRichiesta);

% Verify that the two aggregation methods produce identical results
assert(isequaln(Y1, Y2), "Different results from retime and convert2annual")
