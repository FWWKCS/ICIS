clear; clc;

a = rand(20, 1);
b = zeros(5, 1);

for n = 1:5
    b(n) = sum(a(4*n-3:4*n));
end

b