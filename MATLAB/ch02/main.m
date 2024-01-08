clear; clc;
close all;

N = 1000; % 생성할 데이터 bit 수
x = randi([0,1], 1, N); % Binary User Data

curve = zeros(1, 12);
SNR_range = 0:11;

%% QPSK symbol mapping
y = QPSK_mapper(x, N);

%%  GET BER curve
for i = 1:12
    %% AWGN 잡음 삽입
    SNR = i-1; % SNR in dB
    % z = sqrt(0.5*10^(-SNR/10))* (randn(1, length(y)) + 1i*randn(1, length(y)));
    % r = y + z;
    r = AWGN(y, SNR);
    
    %% Demodulation
    L = length(y);
    x_hat = QPSK_demapper(r);
    
    %% BER
    % Q = error bits after demodulation
    % N = Tx bits (send bits)
    % BER = Q / N
    
    curve(i) = BER(x, x_hat);
end

% Use Plot function
figure(1);
plot(SNR_range, curve, 'r-'); grid on
% 감소할 수록 변화량이 0이 되어 확인이 어려움 

% Use semilogy
figure(2);
semilogy(SNR_range, curve, 'b-'); grid on
ylim([10^-4 10^0]); xlim([0 11]);