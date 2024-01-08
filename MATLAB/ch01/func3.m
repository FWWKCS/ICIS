function [y] = func3(x)
    y = zeros(1, length(x)/2);
    for i = 1:length(x)/2
        y(i) = x(2*i-1) + x(2*i);
    end
end