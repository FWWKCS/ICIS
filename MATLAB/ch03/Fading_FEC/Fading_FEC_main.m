clear; clc;
close all;

N = 200000; % 생성할 데이터 bit 수
x = randi([0,1], 1, N); % Binary User Data
SNR_range = 0:2:20;

FEC = [1, 1/3, 1/5];
F = length(FEC);
curve = zeros(F, 11);

for R = 1:F
    y = FEC_enc(x, FEC(R));
    
    %% QPSK symbol mapping
    y = QPSK_mapper(y, length(y));
    
    %%  GET BER curve
    for i = SNR_range
        
        %% Multipath Fading 삽입
        SNR = i; % SNR in dB
        
        %% Equalizer
        % e = r./h = y + z./h;
        e = fading(y, SNR);    
    
        %% Demodulation
        x_hat = QPSK_demapper(e);
        x_hat = FEC_dec(x_hat, FEC(R));
    
        %% BER
        curve(R, (i/2)+1) = BER(x, x_hat);
    end
end

figure(2);
% No FEC
semilogy(SNR_range, curve(1, :), 'r-'); hold on;

% FEC R = 1/3
semilogy(SNR_range, curve(2, :), 'g-'); hold on;

% FEC R = 1/5
semilogy(SNR_range, curve(3, :), 'b-')

legend('Fading, without FEC', 'Fading, with FEC R=1/3', 'Fading, with FEC R=1/5')
xlabel('SNR [dB]'); ylabel('BER');
ylim([10^-5 10^0]); xlim([0 20]); grid on
 
