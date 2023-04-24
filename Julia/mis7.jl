# include("time_series_data.jl")
# using LinearAlgebra
# using Distances
# for M in 2:12
#     T1=toeplitz(x_train,M)
#     T=zeros(100-M,M)
#     for i in 1:100-M
#         for j in 1:M
#             T[i,j]=T1[i+M-1,j]
#         end
#     end
#     b=x_train[M+1:100]
#     btrim=T\b
#     # display(btrim)
#     println("M is ",M)
#     println("J-train")
#     dist=sqrt(euclidean(T*btrim,b))
#     J=dist/(100-M)
#     println(J)
#     T2=toeplitz(x_test,M)
#     Test=zeros(100-M,M)
#     for i in 1:100-M
#         for j in 1:M
#             Test[i,j]=T2[i+M-1,j]
#         end
#     end
#     b_test=x_test[M+1:100]
#     println("J-test")
#     distest=sqrt(euclidean(Test*btrim,b_test))
#     Jtest=distest/(100-M)
#     println(Jtest)
# end
using LinearAlgebra
include("iris_flower_data.jl")
include("iris_multiclass_helpers.jl")
function get_regression_classifiers(X,y,k)
    S=size(X)[2]
    one=ones(S)
    A=[X' one]
    y1=2(y .==k) .-1
    theta=pinv(A)*y1    
    return theta,errorRate(X,y,k,theta,S)
end
function errorRate(X,y,k,theta,S)
    one=ones(S)
    A=[X' one]
    y_hat=sign.(A*theta)
    y1=2(y .==k) .-1
    correct=sum(y_hat.==y1)
    return 1-correct/S
end
X_train = X[:,1:100];
Y_train = y[1:100];
X_test = X[:,101:150];
Y_test = y[101:150];


theta1, train1=get_regression_classifiers(X_train,Y_train,1);
theta2, train2=get_regression_classifiers(X_train,Y_train,2);
theta3, train3=get_regression_classifiers(X_train,Y_train,3);
test1=errorRate(X_test,Y_test,1,theta1,50);
test2=errorRate(X_test,Y_test,2,theta2,50);
test3=errorRate(X_test,Y_test,3,theta3,50);

println("error rate of train1:",train1)
println("error rate of train2:",train2)
println("error rate of train3:",train3)
println("error rate of test1:",test1)
println("error rate of test2:",test2)
println("error rate of test3:",test3)

one_train=ones(size(X_train)[2]);
one_test=ones(size(X_test)[2]);
theta=[theta1 theta2 theta3];
A_train=[X_train' one_train];
A_test=[X_test' one_test];
twoy_train=argmax_by_row(A_train*theta);
twoy_test=argmax_by_row(A_test*theta);
println("We can get the confusion matrix C on train set is :")
C_train=confusion_matrix(twoy_train,Y_train)
display(C_train)
println("We can get the confusion matrix C on test set is :")
C_test=confusion_matrix(twoy_test,Y_test)
display(C_test)
# function get_iris_data()
#     Random.seed!(5)
#     iris=dataset("datasets","iris")
#     data=Matrix(iris)
#     X=transpose(1.0*data[:,1:4]);
#     perm=randperm(150);
#     X=X[:,perm];
#     y=[ones(50);2*ones(50);3*ones(50)];
#     y=y[perm];
#     return(X,y)
# end
# D = get_iris_data();
# X_train = D[1][:,1:100]'
# Y_train = D[2][1:100];


# # A =  [ones(100) X_train];

# Theta1 = X_train\((2*(Y_train.==1)).-1); 
# Theta2 = X_train\((2*(Y_train.==2)).-1);
# Theta3 = X_train\((2*(Y_train.==3)).-1);
# X_test = D[1][:,101:150]';
# Y_test = D[2][101:150];


# # v1 = Theta1[1,:]
# # beta1= Theta1[2:end]
# # v2 = Theta2[1,:]
# # beta2 = Theta2[2:end]
# # v3 = Theta3[1,:]
# # beta3 = Theta2[2:end]
# #display(beta2)
# #a
# #Train errors
# display(mean(((X_train * Theta1).>0) .!=(Y_train.==1)));
# display(mean(((X_train * Theta2).>0) .!=(Y_train.==2)));
# display(mean(((X_train * Theta3).>0) .!=(Y_train.==3)));

# #Test errors
# display(mean((((X_test * Theta1)).>0) .!=(Y_test.==1)));
# display(mean((((X_test * Theta2)).>0) .!=(Y_test.==2)));
# display(mean((((X_test * Theta3).>0) .!=(Y_test.==3))));

# #confusion_matrix for train and test
# display(confusion_matrix(argmax_by_row((X_train*[Theta1 Theta2 Theta3])), Y_train));
# display(confusion_matrix(argmax_by_row(([ones(50) X_test]*[Theta1 Theta2 Theta3])), Y_test));

