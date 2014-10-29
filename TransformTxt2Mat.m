clear;

A = load('TensorData\Noise_InWeekDay.txt');
% only use value>=2(tunable)
A = (A >= 2) .* A;
A = A ./ 168 .* 68;
MAX = max(max(A));
save('TensorMat\MAX_weekday.mat', 'MAX');
A = A ./ MAX;
A = tensor(reshape(A,862,14,24));
save('TensorMat\A_weekday.mat','A');

A = load('TensorData\Noise_InWeekEnd.txt');
% only use value>=2(tunable)
A = (A >= 2) .* A;
MAX = max(max(A));
save('TensorMat\MAX_weekend.mat', 'MAX');
A = A ./ MAX;
A  = tensor(reshape(A ,862,14,24));
save('TensorMat\A_weekend.mat','A');


POI = load('TensorData\POI.txt');
MAX = max(max(POI));
POI = POI ./ MAX;
RN = load('TensorData\RoadNetworks.txt');
MAX = max(RN(:,1));
MIN = min(RN(:,1));
RN(:,1) = (RN(:,1) - MIN) ./ (MAX-MIN);
MAX = max(max(RN(:,2:7)));
MIN = min(min(RN(:,2:7)));
for i = 2:size(RN,2)
    RN(:,i) = (RN(:,i) - MIN) ./ (MAX-MIN);
end

B = [POI RN];
save('TensorMat\B.mat','B');


C = load('TensorData\Category_InWeekDay.txt');
SUM1 = sum(C,1);
SUM2 = sum(C,2);
for i = 1:size(C,1)
    for j = 1:size(C,2)
        temp(i,j) = (C(i,j) / SUM1(j)) / SUM2(i);
    end
end
MIN = min(min(temp));
MAX = max(max(temp));
temp = (temp - MIN) ./ (MAX - MIN);
C = temp;
save('TensorMat\C_weekday.mat','C');

C = load('TensorData\Category_InWeekEnd.txt');
SUM1 = sum(C,1);
SUM2 = sum(C,2);
for i = 1:size(C,1)
    for j = 1:size(C,2)
        temp(i,j) = (C(i,j) / SUM1(j)) / SUM2(i);
    end
end
MIN = min(min(temp));
MAX = max(max(temp));
temp = (temp - MIN) ./ (MAX - MIN);
C = temp;
save('TensorMat\C_weekend.mat','C');


D = load('TensorData\Checkin_InWeekDay.txt');
MIN = min(min(D));
MAX = max(max(D));
D = (D - MIN) ./ (MAX - MIN);
D = D';
save('TensorMat\D_weekday.mat','D');

D = load('TensorData\Checkin_InWeekEnd.txt');
MIN = min(min(D));
MAX = max(max(D));
D = (D - MIN) ./ (MAX - MIN);
D = D';
save('TensorMat\D_weekend.mat','D');