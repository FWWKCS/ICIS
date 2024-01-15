clear; clc;
close all;

N = 100000; % 생성할 데이터 bit 수
x = randi([0,1], 1, N); % Binary User Data

curve_AWGN = zeros(1, 10);
AWGN_SNR_range = 0:10;
curve_Fading = zeros(1, 20);
Fading_SNR_range = 0:20;

%% QPSK symbol mapping
y = QPSK_mapper(x, N);

%%  GET AWGN BER curve
for i = AWGN_SNR_range
    %% AWGN 잡음 삽입
    SNR = i; % SNR in dB

    r = AWGN(y, SNR);
    %% Demodulation
    x_hat = QPSK_demapper(r);
    
    %% BER
    curve_AWGN(i+1) = BER(x, x_hat);
end

%% GET Fading BER curve
for i = Fading_SNR_range
    SNR = i;
    %% Multipath Fading 삽입
    % r = h .* y + z
    %% Equalizer
    eq = fading(y, SNR);

    %% Demodulation
    x_hat = QPSK_demapper(eq);

    %% BER
    curve_Fading(i+1) = BER(x, x_hat);
end

% Use semilogy
figure(1);
semilogy(AWGN_SNR_range, curve_AWGN, 'r-'); grid on
hold on
semilogy(Fading_SNR_range, curve_Fading, 'b-'); grid on
xlabel('SNR [dB]'); ylabel('BER'); legend('AWGN', 'Fading');
ylim([10^-4 10^0]); xlim([0 20]);