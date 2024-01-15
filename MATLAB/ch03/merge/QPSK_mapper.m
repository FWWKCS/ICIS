function QPSK_symbol = QPSK_mapper(Data, N)
% QPSK Symbol Mapping
    QPSK_symbol = zeros(1, N/2);
    for i = 1:N/2
        two_bit = [Data(2*i-1) Data(2*i)];
        if two_bit == [0, 0]
            QPSK_symbol(i) = sqrt(0.5) + 1i*sqrt(0.5);
        elseif two_bit == [0, 1]
            QPSK_symbol(i) = -sqrt(0.5) + 1i*sqrt(0.5);
        elseif two_bit == [1 0]
            QPSK_symbol(i) = sqrt(0.5) - 1i*sqrt(0.5);
        else
            QPSK_symbol(i) = -sqrt(0.5) - 1i*sqrt(0.5);
        end
    end
end