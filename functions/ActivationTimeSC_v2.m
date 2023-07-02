function [TActivation] = ActivationTimeSC_v2(potvals,ATmindVdT, geom)
% SpatiallyCoherent Activation time
% ActivationTime   Find the activation time of every lead based on the
%                  method defined in the paper titled Spatially Coherent
%                  Activation Maps for Electrocardiographic Imaging, ﻿
%                  Duchateau et. al DOI: 10.1109/TBME.2016.2593003
%
% Usage:
%        TActivation = ActivationTime(potvals, geom);
%
% Inputs:
%   potvals     Time varying potential values for leads (size: (m x n) m: number of leads, n: number of time instance)
%   geom        Heart surface geometry. Must include triangle information geom.fac (size: (3 x numOfTri);
%               node indexing should start with 1, not 0)
%
% Output:
%   TActivation  Activation time vector (size: m x 1):


% Find first order neighbours of the each measurement point on the surface
[m, ~] = size(potvals);
neighbours = build_nbours(geom.fac, m);

% For each measurement point calculate the activation time delays between
% its first order neighbours
[mn, nn] = size(neighbours);
neigSize = sum(neighbours(:,2));
D_incidence = spalloc(neigSize,nn, neigSize*2);
FON_time_delay = zeros(neigSize,1); % time delay vector
index = 1;
for i =1:mn
    for j = 1:neighbours(i,2)
        if(i < neighbours(i,j+2))
            D_incidence(index,i) = 1;
            D_incidence(index,neighbours(i,j+2)) = -1;
            FON_time_delay(index,1) = ActivationTimeDelay(potvals(i,:),potvals(neighbours(i,j+2),:));
            index = index +1;
        end
    end
end

% % Find the activation times of the measurement points
% T = zeros(m,1);
% for i = 1:m
%     T(i,1) = ActDetect(potvals(i,:),10,2);
% end
% ATmindVdT = T;

% Recast the activation times considering the computed time delays
I = eye(m,m);
A = vertcat(I,D_incidence);
% A = [I; D_incidence];
C = [ATmindVdT;FON_time_delay];

TActivation = A\C;


end

