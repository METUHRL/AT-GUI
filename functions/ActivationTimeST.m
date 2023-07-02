function [TActivation, tau] = ActivationTimeST(potvals, L)
% SpatioTemporal Activation time
% ActivationTime   Find the activation time of every lead based on the
%                  method defined in the paper titled 'Using Transmural
%                  Regularization and Dynamic Modeling for Noninvasive
%                  Cardiac Potential Imaging of Endocardial Pacing With
%                  Imprecise Thoracic Geometry' by Erem etal,
%                  DOI:10.1109/TMI.2013.2295220
%
% L : Regularization matrix
% potvals : epicardial potential matrix

nLead = size(potvals,1);
A = eye(nLead);
% initialize activation time vector
tau = zeros(nLead,1);

windowLength = 20;
degree = 2;
for i = 1:nLead
    tau(i) = ActDetect(potvals(i,:),windowLength,degree);
end
% tau is the AT found using the mindVdT approach

[U,S,X,~,~] = cgsvd(A,L);

%[reg_corner,rho,eta,reg_param] = l_curve(U,S,tau);
[reg_min,~,~] = gcv(U,S,tau);
[TActivation,~,~] = tikhonov(U,S,X,tau,reg_min);

end

