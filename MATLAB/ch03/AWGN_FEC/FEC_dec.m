function y = FEC_dec(x, R)
% Repetition Decode
    avg = (1/R) / 2;
    L = length(x)*R;
    
    y = zeros(1, L);

    for i = 1:L
        for j = 1:1/R
           y(i) =  y(i) + x(L*j-(L-i));
        end

        if y(i) > avg
            y(i) = 1;
        else
            y(i) = 0;
        end
    end
end

