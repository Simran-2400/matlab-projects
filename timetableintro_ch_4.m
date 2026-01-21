%% Loading the content of the file Firm.xlsx as timetable
% Read the Excel file directly as a timetable.
% The first column is interpreted as datetime row times.

TT = readtimetable('Firm.xlsx');
head(TT,3)

%% Loading the content of the file Firm.xlsx as table and converting to timetable
% Read the Excel file as a standard table and then
% convert it into a timetable.

Xt = readtable('Firm.xlsx');
TT = table2timetable(Xt);

%% Record extraction (first criterion)
% Extract records whose row times fall between two specific dates.

sel = timerange('1996-12-05','1998-06-01');
TT(sel,:)

%% Part not in the book
% Select all observations occurring before June 1, 1998.

sel = timerange('-inf','1998-06-01');

%% Part not in the book
% The same timerange can be defined using datetime objects
% instead of character strings.

sel = timerange(datetime(1996,12,05), datetime(1998,06,01));
TT(sel,:)

%% Record extraction (second criterion)
% Extract observations between two years, using years as time units.

sel2 = timerange('1999','2001','years');
TT(sel2,:)

%% Extracting a date interval with units of months
% Example of timerange defined using months as the time unit.

timerange(datetime(2022,15,1), datetime(2023,11,4), 'months')

%% Record extraction (Exercise 4.4)
% Extract records satisfying multiple logical conditions
% on years, months, and days.

% Boolean condition for years
anni = TT.Properties.RowTimes.Year >= 1995 & ...
       TT.Properties.RowTimes.Year <= 1999;

% Boolean condition for months
mesi = TT.Properties.RowTimes.Month >= 3 & ...
       TT.Properties.RowTimes.Month <= 4;

% Boolean condition for days
giorni = TT.Properties.RowTimes.Day >= 20;

% Combine the three conditions using logical AND
disp(TT(anni & mesi & giorni, 1:4))

%% Additional examples with timerange (NOT INCLUDED IN THE BOOK)

% Example of a date passed as a string with a recognized format
TR = timerange("2016-01-01","2022-12-31");

% Example of a date passed as a string with an unrecognized format.
% The string must be converted explicitly using datetime.

TR = timerange(datetime("01-01-2016","InputFormat","dd-MM-yyyy"), ...
               datetime("31-12-2022","InputFormat","dd-MM-yyyy"));

% Example of a string containing a non-unique (ambiguous) date.
% MATLAB issues a warning and assumes a default interpretation.

TR = timerange("02/01/2016","11/12/2022");

%% Example of ambiguous string
% Demonstrates how the same string can represent different dates
% depending on the assumed format.

stringContainingDate = "01/02/2016";
disp('Unclear date')
disp(stringContainingDate)

disp('Conversion with the format "dd/MM/yyyy"')
ini1 = datetime(stringContainingDate,'InputFormat',"dd/MM/yyyy");
disp(ini1)

disp('Conversion with the format "MM/dd/yyyy"')
ini2 = datetime(stringContainingDate,'InputFormat',"MM/dd/yyyy");
disp(ini2)

%% Remark on datetime normalization
% When using datetime(Y,M,D), MATLAB automatically adjusts
% values that fall outside conventional ranges.

% Example: month value greater than 12
Y = 2022;
M = 16;
D = 3;

disp(['Y=' num2str(Y) ' M=' num2str(M) ' D=' num2str(D)])
disp(['The syntax datetime(2022,16,3) ' ...
      'corresponds to April 3, 2023'])

disp(datetime(Y,M,D))

% Similarly, days greater than the maximum number of days in a month
% are automatically carried forward to the correct date.
