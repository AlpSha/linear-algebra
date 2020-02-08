function result = findInverse(A)
%% This function takes a matrix and returns its inverse

[m, n] = size(A);

if m ~= n
    disp("Matrix is not invertible");
end

result = solveLinearEquation([A eye(m)]);
result = result(:, m+1:end);
