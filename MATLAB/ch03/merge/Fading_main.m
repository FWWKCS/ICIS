clear; clc;
close all;

N = 100000; % 생성할 데이터 bit 수
x = randi([0,1], 1, N); % Binary User Data

curve = zeros(1, 21);
SNR_range = 0:20;

%% QPSK symbol mapping
y = QPSK_mapper(x, N);

%%  GET BER curve
for i = SNR_range
    %% Multipath Fading 삽입
    SNR = i; % SNR in dB
    % z = sqrt(0.5*10^(-SNR/10))* (randn(1, length(y)) + 1i*randn(1, length(y)));
    % h = sqrt(0.5) * (randn(1, length(y)) + 1j*randn(1, length(y)));
    % r = h .* y + z;
    
    %% Equalizer
    e = fading(y, SNR);
    
    plot(e, '.') % 성상도 확인
    
    
    %% Demodulation
    L = length(y);
    x_hat = QPSK_demapper(e);
    
    %% BER
    curve(i+1) = BER(x, x_hat);
end

figure(2);
semilogy(SNR_range, curve, 'b-'); grid on
xlim([0 20]); ylim([10^-4 10^0]);
 
