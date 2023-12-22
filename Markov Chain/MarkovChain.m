% % The present code was developed to obtain the main results and graphs of
% a markov chain model for inmigration of population in some countries of
% Latinamerica, using a discrete absorbant-transient chain with
% probabilities similar to the real transition of persons between borders.  

% ----------------------------------------------------------------------------------------------------------------------------------------------------------
 
% Definition of probabilities

Pvc = 0.8;
Pcg = 0.35; 
Pcm = 0.05;
Pgm = 0.95;
Pmu = 0.05;

% ----------------------------------------------------------------------------------------------------------------------------------------------------------
 
% Building transition matrix

M = [1-Pvc 0 0 0 0; Pvc 1-Pcg-Pcm 0 0 0; 
    0 Pcg 1-Pgm 0 0; 0 Pcm Pgm 1-Pmu 0; 0 0 0 Pmu 1];

% To verify that transition matrix is correct, uncomment the following line to check summation of columns  
%sum(M)






























