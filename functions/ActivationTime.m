function [at] = ActivationTime(signal)
    
    [~, difHR, ~] = numdiff(signal);
    %length of differentiated signal diff greater than original signal to
    %increase the resolution.
    N = size(signal,2);
    [nlead, ntime] = size(difHR);
    h = N/(ntime - 1);   
    
    at = zeros(nlead,1);
    for i =1:nlead
        [~, ind] = min(difHR(i,:));    
        at(i,1) = ind*h;
    end
end