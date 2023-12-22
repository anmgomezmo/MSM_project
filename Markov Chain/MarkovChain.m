% % The present code was developed to obtain the main results and graphs of
% a markov chain model for inmigration of population in some countries of
% Latinamerica, using a discrete absorbant-transient chain with
% probabilities similar to the real transition of persons between borders.
% The states of chain are defined as V (Venezuela), C (Colombia), G (Guatemala)
% M (Mexico) and U (United States). 

% ----------------------------------------------------------------------------------------------------------------------------------------------------------
 
% Definition of probabilities

Pvc = 0.65;                                                                % Probability of a person to go from Venezuela to Colombia. 
Pcg = 0.05;                                                                % Probability of a person to go from Colombia to Guatemala.     
Pcm = 0.05;                                                                % Probability of a person to go from Colombia to Mexico.
Pgm = 0.98;                                                                % Probability of a person to go from Guatemala to Mexico. 
Pmu = 0.08;                                                                % Probability of a person to go from Mexico to United States.

% Last probabilities was defined taking into account the migration
% bureaucracy in border lines of each country. 

% ----------------------------------------------------------------------------------------------------------------------------------------------------------
 
% Building transition matrix

M = [1-Pvc 0 0 0 0; 
    Pvc 1-Pcg-Pcm 0 0 0; 
    0 Pcg 1-Pgm 0 0; 
    0 Pcm Pgm 1-Pmu 0; 
    0 0 0 Pmu 1];

% To verify that transition matrix is correct, uncomment the following line 
% to check summation of columns  
%sum(M)

% ----------------------------------------------------------------------------------------------------------------------------------------------------------
 
% Definition of population vector (V,C,G,M,U)

n_0 = [8000000; 100000; 1000; 5000; 250000];                                       
  
% Initial inmigrant population of venezuelans in each country in 2016. 
% That values are closed to real inmigration data from diferent
% countries resources. 

% ----------------------------------------------------------------------------------------------------------------------------------------------------------
 
% Evolution of vector population in time from 2016 (economic crisis) to 2022 in steps of 1 year 

n = n_0;
H = [n];                                                                   % History matrix with each column the new population state from left to right.
T = [2016];                                                                % History of time steps.
for i=2017:2022
    nt = M*n;
    n = nt;
    H = [H nt];
    T = [T i];
end

% ----------------------------------------------------------------------------------------------------------------------------------------------------------
 
% Graphs of states for las 6 years

figure;
set(gcf,'position',[10,10,1200,800]);

hold on;

plot(T,H(1,:));
plot(T,H(2,:));
plot(T,H(3,:));
plot(T,H(4,:));
plot(T,H(5,:));
xlabel('Time (years)');
ylabel('Population (millions)');
grid;

hold off;

legend({'Venezuela','Colombia','Guatemala','Mexico','United States'},Location="north");

% For export the graph to a png file, uncomment the next line   
%print('Migration_evolution','-dpng');

% For 2022, population obtained for United States, Guatemala and Colombia 
% through Markov chain model is closed to oficial statistic of those
% countries. 

% ----------------------------------------------------------------------------------------------------------------------------------------------------------
 
% Forecast of migrating population for the next decades  

n = n_0;
Hf = [n];                                                                   % History matrix with each column the new population state from left to right.
Tf = [2016];                                                                % History of time steps.
for i=2017:2030
    nt = M*n;
    n = nt;
    Hf = [Hf nt];
    Tf = [Tf i];
end

% ----------------------------------------------------------------------------------------------------------------------------------------------------------
 
% Graphs of states for coming years

figure;
set(gcf,'position',[10,10,1200,800]);

hold on;

plot(Tf,Hf(1,:));
plot(Tf,Hf(2,:));
plot(Tf,Hf(3,:));
plot(Tf,Hf(4,:));
plot(Tf,Hf(5,:));
xline(2022);
xlabel('Time (years)');
ylabel('Population (millions)');
grid;

hold off;

legend({'Venezuela','Colombia','Guatemala','Mexico','United States'},Location="north");

% For export the graph to a png file, uncomment the next line   
%print('Migration_evolution_2030','-dpng');

% Forecast of migration until 2030 may don't be accurate, due to diverse 
% variables or unexpected events in migration politics of countries.
% However, model stabilizes closed to the year 2120, something impossible
% to be agree with the real problem.

% ----------------------------------------------------------------------------------------------------------------------------------------------------------
 
% Fundamental matrix and Absortion matrix

Q = M(1:4,1:4);
R = M(5,1:4);

F = inv(eye(4)-Q);                                                         % Fundamental matrix defined from Q. 
A = R*F;                                                                   % Absortion matrix with all entries equal to 1.

% For this case, time matrix T is the same fundamental matrix F, because by
% definition T=F*dt and dt=1 year.

% ----------------------------------------------------------------------------------------------------------------------------------------------------------
 
% Regular process 

D = sort(eig(M),2);                                                        % Determination of eigenvalues (D) and eigenvectors (E) of matrix M.

dt = 1;                                                                    % in years.

T_half = -log(2)/log(abs(D(2)))*dt;                                        % Time after which the distance is divided by two, in years.

% ----------------------------------------------------------------------------------------------------------------------------------------------------------










