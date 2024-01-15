function ratio = BER(be, af)
% BER
    N = length(be);
    Q = 0;
    for i = 1:N
        if be(i) ~= af(i)
            Q = Q + 1;
        end
    end
    ratio = Q / N;
end