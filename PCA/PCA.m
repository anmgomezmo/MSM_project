% The present code was developed to obtain the main results and graphs of
% principal component analysis (PCA) technique over a dataset of bird 
% strike accidents with airplanes, reported in the United States from 1996
% to 2023. The file "STRIKE_REPORTS.xlsx" contains different parameters of
% event in each column. For description about the meaning of variables, 
% look at "Column_names_explanation".

% ----------------------------------------------------------------------------------------------------------------------------------------------------------
 
% Read and clean of dataset

dataset = readmatrix("STRIKE_REPORTS.xlsx",Sheet="STRIKE_REPORTS");        % Use of readmatrix function to read data file into a numerical matrix.
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

Cov = (X_c'*X_c)/(n-1);                                                    % Determination of covariance matrix. 

[E, D] = eig(Cov);                                                         % Use of function eig to find the m eigenvalues (diagonal values in D matrix) and 
                                                                           % m eigenvectors (columns of matrix E). 

I_tot = trace(D);                                                          % Information of principal components from eigenvalues.
I = 100*diag(D)/I_tot;                                          

% ----------------------------------------------------------------------------------------------------------------------------------------------------------

% Normalization in P space

D_half = D^(-1/2);                                                         % Definition of inverse square root matrix of eigenvalues. 
E_norm = E*D_half;                                                         % New eigenvectors in P space normalized. 
P = X_c*E_norm;                                                            % Calculation of data in the new space.

% ----------------------------------------------------------------------------------------------------------------------------------------------------------

% Building of correlation circle graph   

lx = 1.3;                                                                  % Horizontal limits of plot. 
ly = 1.3;                                                                  % Vertical limits of plot.  
E_norm_t = E_norm';                                                        


% Plot of correlation circle in the first two main components

P1 = m;
P2 = m-1;
figure;

hold on;

grid
set(gcf,'position',[10,10,810,800]);
plot([-lx lx],[0 0],Color="black");
plot([0 0],[-ly ly],Color="black");
xlabel("P1");
ylabel("P2");
text(1.08,0.05,append(sprintf('%.1f',I(P1)),' %'));
text(-0.05,1.08,append(sprintf('%.1f',I(P2)),' %'),"Rotation",90);
xlim([-lx lx]);
ylim([-ly ly]);
viscircles([0 0],1);
biplot(E_norm_t(:,1:2),'VarLabels', ...
    {'Month','','Latitude','Longitude','Engines','Height','Speed', ...
    'Distance','Strucks','Mass'});

hold off;

% For export the graph to a png file, uncomment the next line   
%print('Correrlation_circle_P1-P2','-dpng');


% Plot of correlation circle in the first two main components

P3 = m-2;
P4 = m-3;
figure;

hold on;

grid
set(gcf,'position',[10,10,810,800]);
plot([-lx lx],[0 0],Color="black");
plot([0 0],[-ly ly],Color="black");
xlabel("P3");
ylabel("P4");
text(1.08,0.05,append(sprintf('%.1f',I(P3)),' %'));
text(-0.05,1.08,append(sprintf('%.1f',I(P4)),' %'),"Rotation",90);
xlim([-lx lx]);
ylim([-ly ly]);
viscircles([0 0],1);
biplot(E_norm_t(:,3:4),'VarLabels', ...
    {'','','','Longitude','Engines','Height','Speed', ...
    'Distance','',''});

hold off;

% For export the graph to a png file, uncomment the next line   
%print('Correrlation_circle_P3-P4','-dpng');

% ----------------------------------------------------------------------------------------------------------------------------------------------------------

% Plot of some variables in the P space 

figure;
set(gcf,'position',[10,10,800,1000]);
tiledlayout(3,2);

nexttile;
scatter(P(:,9),P(:,2));
xlim([-10 25]);
xlabel("Num\_Strucks");
ylabel("Inc\_Month");
grid;

nexttile;
scatter(P(:,9),P(:,4),MarkerEdgeColor='green');
ylim([-10 15]);
xlabel("Num\_Strucks");
ylabel("Longitude");
grid;

nexttile;
scatter(P(:,9),P(:,3),MarkerEdgeColor='red');
xlim([-10 20]);
xlabel("Num\_Strucks");
ylabel("Latitude");
grid;

nexttile;
scatter(P(:,9),P(:,10),MarkerEdgeColor='magenta');
xlim([-10 25]);
xlabel("Num\_Strucks");
ylabel("Ac\_Mass");
grid;

nexttile;
scatter(P(:,9),P(:,5),MarkerEdgeColor='cyan');
ylim([-15 10]);
xlabel("Num\_Strucks");
ylabel("Num\_Engines");
grid;

nexttile;
scatter(P(:,9),P(:,6),MarkerEdgeColor='yellow');
ylim([-5 5]);
xlabel("Num\_Strucks");
ylabel("Height");
grid;

% For export the graph to a png file, uncomment the next line   
%print('2D_strikes-variables','-dpng');



figure;
set(gcf,'position',[10,10,800,1000]);
tiledlayout(3,2);

nexttile;
scatter(P(:,3),P(:,4),MarkerEdgeColor='green');
ylim([-10 15]);
xlabel("Latitude");
ylabel("Longitude");
grid;

nexttile;
scatter(P(:,6),P(:,7),MarkerEdgeColor='red');
xlim([-5 5]);
ylim([-5 5]);
xlabel("Height");
ylabel("Speed");
grid;

nexttile;
scatter(P(:,8),P(:,6),MarkerEdgeColor='magenta');
xlim([-15 10]);
xlabel("Distance");
ylabel("Height");
grid;

nexttile;
scatter(P(:,5),P(:,6),MarkerEdgeColor='cyan');
xlim([-15 10]);
xlabel("Num\_Engines");
ylabel("Height");
grid;

nexttile;
scatter(P(:,1),P(:,3),MarkerEdgeColor='yellow');
xlim([-10 5]);
xlabel("Inc\_Month");
ylabel("Latitude");
grid;

nexttile;
scatter(P(:,1),P(:,4));
ylim([-10 15]);
xlabel("Inc\_Month");
ylabel("Longitude");
grid;

% For export the graph to a png file, uncomment the next line   
%print('2D_variables','-dpng');

% ----------------------------------------------------------------------------------------------------------------------------------------------------------







