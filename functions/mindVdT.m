function [mdVdT,jitterdVdT] = mindVdT(ciEgm)
% Compute AT maps using min dVdT

    nChannel = size(ciEgm,1);
    mdVdT = zeros(1,nChannel);
    for iChannel=1:nChannel
        FilteredSig = filter([1 -1],1,ciEgm(iChannel,:));  % derivative computed over 2 points
        [~,mdVdT(iChannel)] = min(FilteredSig(2:end));
    end
    jitterdVdT = min(mdVdT);

end

