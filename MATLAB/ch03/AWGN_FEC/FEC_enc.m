function y = FEC_enc(x, R)
% Repetition Encode
    L = length(x);
    y = 0:(L*(1/R))-1;
    
    for i = 1:L
        for j = 1:1/R
            y(L*j-(L-i)) = x(i);
        end
    end
end