function [y] = func4(x)
    y = zeros(1, length(x));
    for i = 1:length(x)
        y(i) = exp(1i*x(i));
    end
end
