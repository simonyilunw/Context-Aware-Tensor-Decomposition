clear;
load('TensorMat\A_weekend.mat');
load('TensorMat\B.mat');
load('TensorMat\C_weekend.mat');
load('TensorMat\D_weekend.mat');
load('TensorMat\MAX_weekend.mat');

epsilon = 0.001;
D = D';

m = 862; % number of regions
r = 24;   % number of time spans
n = 14;   % number of categories of nosie

lambda1 = 0.0001;
lambda2 = 0.0001;
lambda3 = 0.0001;
lambda4 = 0.0001;
[S,X,Y,Z] = catd1(A, B, C, D, epsilon, lambda1, lambda2, lambda3, lambda4);

P = ttensor(S,{X,Y,Z});
P = tensor(P);

P = P .* (P>0);
P = P .* (A==0) + A;
P = P .* MAX;
save('TensorResult\P_weekend.mat', 'P');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
load('TensorMat\A_weekday.mat');
load('TensorMat\B.mat');
load('TensorMat\C_weekday.mat');
load('TensorMat\D_weekday.mat');
load('TensorMat\MAX_weekday.mat');
epsilon = 0.001;
D = D';

m = 862;  % number of regions
r = 24;   % number of time spans
n = 14;   % number of categories of nosie

lambda1 = 0.0001;
lambda2 = 0.0001;
lambda3 = 0.0001;
lambda4 = 0.0001;
[S,X,Y,Z] = catd1(A, B, C, D, epsilon, lambda1, lambda2, lambda3, lambda4);

P = ttensor(S,{X,Y,Z});
P = tensor(P);

P = P .* (P>0);
P = P .* (A==0) + A;
P = P .* MAX;
save('TensorResult\P_weekday.mat', 'P');