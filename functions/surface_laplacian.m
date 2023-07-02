function Lapl = surface_laplacian(geom)

% SURFACE_LAPLACIAN  Calculates the surface Laplacian matrix for the Epicardial Geometries
%
% Usage:   L = surface_laplacian(geom)
%
% Input:
%   geom    Geometry of epicardial surface
%       geom.pts is points (nLeads x 3),
%       geom.fac are the triangles (size: (numOfTri x 3);
%               node indexing should start with 1, not 0)
%
% Output:
%   L       Surface Laplacian matrix (operator acting on the x vector)

% Reference: "Interpolation on a Triangulated 3{D} Surface",
% Oostendorp, T.F. and van Oosterom, A. and Huiskamp, G.J.
% J. Comp. Physics, 1989, 80 331--343.

if size(geom.pts,2) > size(geom.pts,1)
    geom.pts = geom.pts';
end
if size(geom.fac,2) > size(geom.fac,1)
    geom.fac = geom.fac';
end

nLeads = size(geom.pts,1);
Lapl = zeros(nLeads, nLeads);

% Load or calculate nbours
% First column  : lead number (i --> i'th row of geom.pts)
% Second column : # of neighbors of lead i
% Other columns : Pointer to neighbors of that lead (j --> j'th row of pts)
%

nbours = build_nbours(geom.fac, nLeads);

% n = size(nbours,2); % # of columns in nbours.

% For each point, calculate distance to all of its neighbors:
[dist,invdist] = deal(zeros(nLeads,max(nbours(:,2))));

for i=1:nLeads,
  for j=1:nbours(i,2) % number of neigbours of the current lead
    dist(i,j) = norm(geom.pts(i,:) - geom.pts(nbours(i,j+2),:));
    % sqrt( (xi-xj)^2 +  (yi-yj)^2 + (zi-zj)^2 )

    % Find 1/dist(i,j)
    invdist(i,j) = 1/dist(i,j);
  end
end

% The average of 'dist' and '1/dist' for each point { Ave. of h_ij }
hpar = (sum(dist,2))./nbours(:,2); % average of all distances
hinvpar = (sum(invdist,2))./nbours(:,2); % average of all inverse distances

% Find the elements of the Laplacian:
for i=1:nLeads,
  for j=1:nbours(i,2)
    k = nbours(i,2+j);
    Lapl(i,i) = -4*hinvpar(i)/hpar(i);
    Lapl(i,k) = 4/(hpar(i)*nbours(i,2)*dist(i,j));
  end;
end;