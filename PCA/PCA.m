% The present code was developed to obtain the main results and graphs of
% principal component analysis (PCA) technique over a dataset of bird 
% strike accidents with airplanes, reported in the United States from 1996
% to 2023. The file "STRIKE_REPORTS.xlsx" contains different parameters of
% event in each column. For description about the meaning of variables, 
% look at "Column_names_explanation".

% ----------------------------------------------------------------------------------------------------------------------------------------------------------

% Don't forget modify dataset file (remove original columns and set two sheets) 
% Read and clean of dataset

dataset = readmatrix("STRIKE_REPORTS.xlsx",Sheet="Useful_data");           % Use of readmatrix function to read data file into a numerical matrix.
dataset(1,:) = [];                                                         % Remove the column names from matrix.           
dataset = fillmissing(dataset,'constant',0);                               % Fill missing cells with zero.

% ----------------------------------------------------------------------------------------------------------------------------------------------------------

% Centered and Standarized data

n = size(dataset,1);                                                       % Number of strike reports. 
m = size(dataset,2);                                                       % Number of variables per strike.

x_var = zeros(1,m);                                                        % Determination of mean values for the whole variables. 
for i = 1:m
    x_var(i) = sum(dataset(:,i))/n;
end

x_std = zeros(1,m);                                                        % Determination of standard deviations for each variable. 
for i = 1:m
    aux = (dataset(:,i)-x_var(i)).^2;
    x_std(i) = sqrt(sum(aux)/(n-1));
end

X_c = (dataset-x_var)./x_std;                                              % Definition of data centered and normalized. 

% ----------------------------------------------------------------------------------------------------------------------------------------------------------

% Covariance matrix and eigenvalue problem 

Cov = (X_c'*X_c)/(n-1);                                                    % Determination of covariant matrix. 

[E, D] = eig(Cov);                                                         % Use of function eig to find the m eigenvalues (diagonal values in D matrix) and 
                                                                           % m eigenvectors (columns of matrix E). 

% ----------------------------------------------------------------------------------------------------------------------------------------------------------














