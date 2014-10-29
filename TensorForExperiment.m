clear;
load('TensorMat\A_weekend.mat');
load('TensorMat\B.mat');
load('TensorMat\C_weekend.mat');
load('TensorMat\D_weekend.mat');

epsilon = 0.02;
D = D';

m = 862; % number of regions
r = 24;   % number of time spans
n = 14;   % number of categories of nosie

RMSE = zeros(4,1);
MAE = zeros(4,1);

for expNum = 1:1   % number of expriments
    %% initial
    rand('twister',expNum)
    expNum
    percent = 0.7;  % percents of training
    IndTrain = zeros(m,n,r); 
    for i = 1:r     
        for j = 1:n
            for k = 1:m
                if (A(k,j,i) > 0) && (rand()<percent)
                    IndTrain(k,j,i) = 1;
                end
            end
        end
    end
    IndTrain = tensor(IndTrain);
    IndTest = (A > 0) - IndTrain;
    
    ATest = A.*IndTest;
    ATrain = A.*IndTrain;
    
    %% TD
    lambda1 = 0;
    lambda2 = 0;
    lambda3 = 0;
    lambda4 = 0.0001;
    [S,X,Y,Z] = catd1(ATrain, B, C, D, epsilon, lambda1, lambda2, lambda3, lambda4);

    P = ttensor(S,{X,Y,Z});
    P = tensor(P);

    PTest = P.*IndTest;
    PTest = PTest.*(PTest > 0);
    
    RMSE(1) = RMSE(1) + sqrt(sum(sum(sum(double(ATest - PTest).^2))) / nnz(IndTest));
    MAE(1) = MAE(1) + sum(sum(sum(abs(double(ATest - PTest))))) / nnz(IndTest);

    %% TD + B
    lambda1 = 0.0001;
    lambda2 = 0;
    lambda3 = 0;
    lambda4 = 0.0001;
    [S,X,Y,Z] = catd1(ATrain, B, C, D, epsilon, lambda1, lambda2, lambda3, lambda4);

    P = ttensor(S,{X,Y,Z});
    P = tensor(P);

    PTest = P.*IndTest;
    PTest = PTest.*(PTest > 0);
    
    RMSE(2) = RMSE(2) + sqrt(sum(sum(sum(double(ATest - PTest).^2))) / nnz(IndTest));
    MAE(2) = MAE(2) + sum(sum(sum(abs(double(ATest - PTest))))) / nnz(IndTest);

    %% TD + B + D
    lambda1 = 0.0001;
    lambda2 = 0;
    lambda3 = 0.0001;
    lambda4 = 0.0001;
    [S,X,Y,Z] = catd1(ATrain, B, C, D, epsilon, lambda1, lambda2, lambda3, lambda4);

    P = ttensor(S,{X,Y,Z});
    P = tensor(P);

    PTest = P.*IndTest;
    PTest = PTest.*(PTest > 0);
    
    RMSE(3) = RMSE(3) + sqrt(sum(sum(sum(double(ATest - PTest).^2))) / nnz(IndTest));
    MAE(3) = MAE(3) + sum(sum(sum(abs(double(ATest - PTest))))) / nnz(IndTest);

    %% TD + B + C + D
    lambda1 = 0.0001;
    lambda2 = 0.0001;
    lambda3 = 0.0001;
    lambda4 = 0.0001;
    [S,X,Y,Z] = catd1(ATrain, B, C, D, epsilon, lambda1, lambda2, lambda3, lambda4);

    P = ttensor(S,{X,Y,Z});
    P = tensor(P);

    PTest = P.*IndTest;
    PTest = PTest.*(PTest > 0);
    
    RMSE(4) = RMSE(4) + sqrt(sum(sum(sum(double(ATest - PTest).^2))) / nnz(IndTest));
    MAE(4) = MAE(4) + sum(sum(sum(abs(double(ATest - PTest))))) / nnz(IndTest);
end

RMSE = RMSE ./ expNum
MAE = MAE ./ expNum