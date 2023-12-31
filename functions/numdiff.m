function [dif, difHR, fsignal] = numdiff(signal)
% Author: Onder Nazim Onak
% Input: 
% signal: is the noisy signal values of length N on uniform grid
% Output:
% dif: derivative of the given signal with same resolution with given signal
% difHR: derivative of the given signal of length M*N + 1. The interval between two consecutive signal values is divided into
% M subintervals to increase the resolution of the derivative.
% fsignal: filtered signal
%
% For more detail:
% Numerical differentiation based on Tikhonov regularization and Simpson
% integration algorithm. More details are available in METHODS FOR NUMERICAL DIFFERENTIATION OF
% NOISY DATA, IAN KNOWLES, ROBERT J. RENKA, Variational and Topological Methods: Theory, Applications, Numerical Simulations, and
% Open Problems (2012). Electronic Journal of Differential Equations, Conference 21 (2014),
% pp. 235?246. ISSN: 1072-6691 
%
% Construct Integral matrix
[numlead, numSample] = size(signal);
%dif = zeros(numlead,1);

%M = 5;
M = 2;
w = sparse(zeros(numSample,(numSample)*M));

for i =1:numSample
    N = i*M ;
    h = i/(N-1);
    w(i,1) = 1; 
    w(i,2:2:N) = 4; 
    w(i,3:2:N) = 2; 
    w(i,N) = 1; 
    w(i,:) = w(i,:)*h/3;
end

% generates a sparse tridiagonal representation of the classic second difference operator
n = (numSample)*M ;
e = ones(n,1);
%D = spdiags([0*e -1*e e], -1:1, n, n);
D = spdiags([e -2*e e], -1:1, n, n);

    [U,S,X,~,~] = cgsvd(w,D);
    for i = 1:numlead
        yhat = signal(i,:)' - signal(i,1);
        [reg_min,~,~] = gcv(U,S,yhat);
        [diffPot,~,~] = tikhonov(U,S,X,yhat,reg_min);
        %[diffPot] = LpLqReg(w,D,double(yhat),1.1,2,double(reg_min*5));
        difHR(i,:) = diffPot';
        fsignal(i,:) = (w*diffPot) + signal(i,1);
        dif(i,:) = diffPot(1:M:end);
    end
end