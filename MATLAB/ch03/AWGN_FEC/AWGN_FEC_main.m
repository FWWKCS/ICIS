clear; clc;
close all;

N = 200000; % 생성할 데이터 bit 수
x = randi([0,1], 1, N); % Binary User Data
SNR_range = 0:10;

FEC = [1, 1/3, 1/5];
F = length(FEC);
curve = zeros(F, 11);

for R = 1:F
    y = FEC_enc(x, FEC(R));

    %% QPSK symbol mapping
    y = QPSK_mapper(y, length(y));

    for i = SNR_range
        %% AWGN 잡음 삽입
        SNR = i; % SNR in dB
        r = AWGN(y, SNR);
        
        %% Demodulation
        x_hat = QPSK_demapper(r);
        x_hat = FEC_dec(x_hat, FEC(R));
        
        %% BER        
        curve(R, i+1) = BER(x, x_hat);
    end
end

% Use semilogy
figure(1);

% No FEC
semilogy(SNR_range, curve(1, :), 'r-'); hold on;

% FEC R = 1/3
semilogy(SNR_range, curve(2, :), 'g-'); hold on;

% FEC R = 1/5
semilogy(SNR_range, curve(3, :), 'b-')

legend('AWGN, without FEC', 'AWGN, with FEC R=1/3', 'AWGN, with FEC R=1/5')
xlabel('SNR [dB]'); ylabel('BER');
ylim([10^-5 10^0]); xlim([0 10]); grid on