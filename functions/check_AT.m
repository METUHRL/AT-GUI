function new_AT = check_AT(QRSBegin,QRSEnd,AT)
% check_AT function: It checks if AT values are between the QRS region
% or not. If not in the range, it adds the QRSBegin value
    L = length(AT);
    if sum(AT>=QRSBegin & AT<=QRSEnd)/L >= 0.9
        new_AT = AT; 
    else
        new_AT = AT + QRSBegin;
    end
end
