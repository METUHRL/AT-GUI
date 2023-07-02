function corrector_AT = ATcorrector(QRSbegin,QRSend,ind)
    
    interval = QRSend - QRSbegin;

    if ind < interval
        corrector_AT = ind;
    else
        corrector_AT  = ind - QRSbegin;
    end
end