%% Matrix multiplication
% This section demonstrates standard matrix multiplication.
% The number of columns of A must match the number of rows of B.

A = [3 -3 9; 
     10 0 4; 
     0 2 -1];

B = [-1 5; 
      7 3; 
      0 6];

% Matrix multiplication
C = A * B;
disp(C)

%% Diagonal matrices
% Creation of a square diagonal matrix using a vector.
% The elements of the vector are placed on the main diagonal.

D = diag([2 5 7]);
disp(D)

%% Superdiagonal matrix
% Creation of a matrix with values on the first superdiagonal
% (one diagonal above the main diagonal).

E = diag([2 5 7], 1);
disp(E)

%% Extract elements on the main diagonal
% Generate a random integer matrix and extract the main diagonal.

rng(10);                % Set random seed for reproducibility
A = randi(15, 5);       % Create a 5x5 matrix with values between 1 and 15

% Extract main diagonal elements
a = diag(A);
disp(a)

%% Extract elements two diagonals below the main one
% Extract elements from the diagonal located two positions below
% the main diagonal.

b = diag(A, -2);
disp(b)

%% Identity matrix
% Creation of an identity matrix of size 3x3.
% Identity matrices have ones on the main diagonal and zeros elsewhere.

I = eye(3);
disp(I)

%% Rectangular matrix with 1s on the main diagonal
% Creation of a non-square identity-like matrix.
% Ones are placed on the main diagonal until possible.

A = eye(4, 6);

%% Identity matrix created with a double for loop
% Manual construction of an identity matrix using nested loops.
% This illustrates how logical conditions can be used in matrix creation.

p = 5;
ID = zeros(p, p);       % Initialize a square matrix of zeros

for i = 1:p
    for j = 1:p
        if i == j
            % When row index equals column index,
            % assign value 1 on the diagonal
            ID(i, i) = 1;
        end
    end
end

% Verify that the manually created matrix
% is identical to MATLAB's built-in identity matrix
IDchk = eye(p);

assert(isequal(ID, IDchk), "Programming error in " + ...
    "creating the identity matrix using a double for loop")

%% Matrix of ones
% Create a matrix where all elements are equal to one.

disp(ones(2, 3))

%% Matrix of zeros
% Create a matrix where all elements are equal to zero.

disp(zeros(3, 4))

%% Matrix with all elements equal to 5
% Create a constant matrix by scaling a matrix of ones.

disp(5 * ones(3, 4))

%% Magic matrix of dimension kxk
% Generate a magic square where the sum of each row,
% column, and diagonal is the same.

k = 3;
magic(k)
