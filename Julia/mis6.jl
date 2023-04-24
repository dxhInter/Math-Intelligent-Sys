using LinearAlgebra
function verify(A, b, x, delta)
    return norm(A*(x+delta)-b).^2 > norm(A*x-b).^2
end
delta1 = rand(10);
println(verify(A, b, x, delta1));
delta2 = rand(10);
println(verify(A, b, x, delta2));
delta3 = rand(10);
println(verify(A, b, x, delta3));
delta4 = rand(10);
scaled_delta4 = (delta4.-minimum(delta4))./(maximum(delta4)-minimum(delta4));
println(verify(A, b, x, scaled_delta4));