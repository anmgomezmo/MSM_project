% The present code was developed to obtain the main results and graphs of
% principal component analysis (PCA) technique over a dataset of bird 
% strike accidents with airplanes, reported in the United States from 1996
% to 2023. The file "STRIKE_REPORTS.xlsx" contains different parameters of
% event in each column. For description about the meaning of variables, 
% look at "Column_names_explanation".



% Don't forget modify dataset file (remove original columns and set two sheets) 
dataset = readmatrix("STRIKE_REPORTS.xlsx",Sheet="Useful_data");           % Use of readmatrix function to read data file into a numerical matrix.
dataset(1,:) = [];                                                         % Remove the column names from matrix.           
dataset = fillmissing(dataset,'constant',0);                               % Fill missing cells with zero.







