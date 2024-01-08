function [y] = func2(x)
% practice 8
    y = zeros(1, length(x));
    for i = 1:3
        y(2*i-1) = x(i);
        y(2*i) = 2*x(i);
    end
end