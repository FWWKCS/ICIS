function received = AWGN(y, SNR)
% AWGN 잡음 삽입
    L = length(y);
    z = sqrt(0.5*10^(-SNR/10))*(randn(1, L) + 1i*randn(1, L));
    received = y + z;
end