using LinearAlgebra
for i in 1:10
    C=rand(600,4000);
    d=rand(600);
    @time C\d
end
# A = randn(10, 100)
# b = randn(10)

# x1 = A' * inv(A * A') * b
# x2 = pinv(A) * b
# x3 = A \ b
# x4 = llsq(A, b; trans=true, bias=false).coef
# norm(x1 - x2)
# norm(x1 - x3)
# norm(x1-x4)
# tolerance = 1e-10
# if norm(x1 - x2) < tolerance && norm(x1 - x3) < tolerance && norm(x1 - x4) < tolerance
#     println("All solutions are close to each other.")
# else
#     println("Solutions are not close to each other.")
# end


# A = randn(10, 100)
# b = randn(10)
# x̂ = llsq(A, b; trans=true, bias=false).coef
# println("x̂")


# include("price_elasticity.jl")
# delta_p=(Prices .-p_nom) ./ p_nom;
# delta_d=(Demands .-d_nom) ./ d_nom;
# delta_p_train=delta_p[:,1:50];
# delta_d_train=delta_d[:,1:50];
# delta_p_test=delta_p[:,51:N];
# delta_d_test=delta_d[:,51:N];
# E_hat=delta_d_train*pinv(delta_p_train)

# using Plots
# using VMLS
# using Statistics
# import Random
# Random.seed!(1);
# n = 50
# N = 300
# w_true = randn(n)
# v_true = 5
# X = randn(n, N)
# y = sign.(X'w_true .+ v_true + 10*randn(N))
# N_test = 100
# X_test = randn(n, N_test)
# y_test = sign.(X_test'w_true .+ v_true + 10*randn(N_test))
# A = [ones(size(X)[2]) X'];
# Theta = A\y;
# v = Theta[1,:]
# beta = Theta[2:51];
# y_hat = X' * beta .+ v;
# test_y_hat = X_test' * beta .+ v;
# println("The error rate on training data is ",(sum(((y_hat).>0) .!=(y.==1)) + sum(((y_hat).<0) .!=(y.==-1)))/size(y)[1]/2);
# println("The error rate on testing data is ",(sum(((test_y_hat).>0) .!=(y_test.==1)) + sum(((test_y_hat).<0) .!=(y_test.==-1)))/size(y_test)[1]/2);
# #b
# regularization_factor =  10 .^ range(-1,4,length = 100);
# test_values = []
# train_values = []
# logvalues = []
# for i in regularization_factor
#     Theta = inv(transpose(A)*A + i*Matrix{Float64}(I,51,51)) * transpose(A) * y;
#     v = Theta[1,:]
#     beta = Theta[2:51];
#     y_hat = X' * beta .+ v;
#     test_y_hat = X_test' * beta .+ v;
#     append!(train_values,(sum(((y_hat).>0) .!=(y.==1)) + sum(((y_hat).<0) .!=(y.==-1)))/size(y)[1]/2);
#     append!(test_values,(sum(((test_y_hat).>0) .!=(y_test.==1)) + sum(((test_y_hat).<0) .!=(y_test.==-1)))/size(y_test)[1]/2);
#     append!(logvalues,log10(i));
# end
# plot(logvalues, xlabel = "Log Scaled Lambdas", ylabel = "RMS Error", train_values, label = "Train Data")
# plot(logvalues, xlabel = "Log Scaled Lambdas", ylabel = "RMS Error", test_values, label = "Test Data")
# println("Reasonable lambda for train data is ", regularization_factor[findmin(train_values)[2]]);

# n = 100
# u = rand(n)
# m = 7
# h = [0.3, 0.5, 0.6, 0.4, 0.3, 0.2, 0.1]
# y_des = zeros(n + m - 1)
# y_des[10:39] .= 10
# y_des[40:79] .= -5
# A = toeplitz(h, n)
# λ_range = 10 .^(range(-10, stop=10, length=100))
# u_values = Array{Vector{Float64}, 1}(undef, 3)
# y_values = Array{Vector{Float64}, 1}(undef, 3)
# for (i, λ) in enumerate([1e-5, 1e5, 1e-2])
#     u_optimal = inv(A' * A + λ * I) * A' * y_des
#     u_values[i] = u_optimal
#     y_values[i] = A * u_optimal
# end
# plot(u_values[1], label="λ = 10^-5")
# plot!(u_values[2], label="λ = 10^5")
# plot!(u_values[3], label="λ = 10^-2", xlabel="Sample index", ylabel="Input signal", legend=:bottomright)

# plot!(y_values[1], label="λ = 10^-5")
# plot!(y_values[2], label="λ = 10^5")
# plot!(y_values[3], label="λ = 10^-2")
# plot!(y_des, label="y^des", xlabel="Sample index", ylabel="Output signal", legend=:bottomright)

# n = 100
# u = rand(n)
# m = 7
# h = [0.3, 0.5, 0.6, 0.4, 0.3, 0.2, 0.1]
# y_des = zeros(n + m - 1)
# y_des[10:39] .= 10
# y_des[40:79] .= -5
# A = toeplitz(h, n)
# λ_range = 10 .^(range(-10, stop=10, length=100))
# rms_error = zeros(length(λ_range))
# rms_input = zeros(length(λ_range))
# for (i, λ) in enumerate(λ_range)
#     u_optimal = inv(A' * A + λ * I) * A' * y_des
    
    
#     rms_error[i] = sqrt(mean((A * u_optimal - y_des).^2))
#     rms_input[i] = sqrt(mean(u_optimal.^2))
# end
# plot(rms_input, rms_error, xaxis=:log10, xlabel="Input RMS Value", ylabel="RMS Tracking Error", label="", legend=:bottomright)