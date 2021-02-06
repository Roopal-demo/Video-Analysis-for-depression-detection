function class = evaluatekSOM(feature,features,emotions)

TrainSet = features;
TestSet = feature;
Targets = emotions;

Regularization_coefficient = 0.01;
C = Regularization_coefficient;
n = length(Targets);
Kernel_type = 'SOM';
Kernel_para = 100;

Omega_train = kernel_matrix(TrainSet,Kernel_type, Kernel_para);
OutputWeight=((Omega_train+speye(n)/C)\(Targets')); 
Omega_test = kernel_matrix(TrainSet,Kernel_type, Kernel_para,TestSet);
TY=(Omega_test .* OutputWeight);

[max_val,max_index] = max(TY);

class = Targets(max_index);