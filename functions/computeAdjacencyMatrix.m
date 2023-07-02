%% HELP:
%
%	This function computes the adjacency matrix on the graph defined in
%	the geometry "geom".
%	The adjacency matrix can be extended to all the neighbors of a node
%	that are at a distance "pathLength" from that node.
%
%
%	INPUT:
%		- geom - struct - input geometry. Assumed to be a triangular
%		surface mesh. The struct is composed of two fields: node and face.
%		- pathLength - int - number of jumps on the graph that define the
%		adjacency.
%
%	OUTPUT:
%		- AdjMtrx - <M,M>bool - matrix defining which nodes are neighbors
%		of which.
%
%	AUTHOR:
%		Jaume Coll-Font <jcollfont@gmail.com>
%

function [AdjMtrx] = computeAdjacencyMatrix(geom, pathLength)

        geom.node = geom.pts'; geom.face = geom.fac';
		% check if the geometry is oriented correctly (should be 3xP):
		if(size(geom.node,1)>size(geom.node,2))
			geom.pts=geom.node';
		end
		if(size(geom.face,1)>size(geom.face,2))
			geom.face=geom.face';
		end

		[d1,M] = size(geom.node);
		[d2,numFac] = size(geom.face);
			
% 		if d ~= 3 % Why do we need this part? Should they be in 3xP format here?
% 			numFac = d; % If d is not equal to 3, it should be the number of nodes, numFac should be the number of triangles!!!
% 			geom.face = geom.face';
% 			geom.node = geom.node';
% 		end
% 			
	%% create 1rst order adjacency matrix
		adjMtrx = false(M); % same as zeros(M,M)
		for ii = 1:numFac % For all triangles, if two nodes (i and j) are connected, set the corresponding 
            % element of adjMtrx (adjMtrx(i,j)) to 1. 
			adjMtrx(geom.face(1,ii),geom.face(2,ii)) = 1;%distance(geom.face(1,ii),geom.face(2,ii));
			adjMtrx(geom.face(2,ii),geom.face(3,ii)) = 1;%distance(geom.face(2,ii),geom.face(3,ii));
			adjMtrx(geom.face(3,ii),geom.face(1,ii)) = 1;%distance(geom.face(3,ii),geom.face(1,ii));
			adjMtrx(geom.face(2,ii),geom.face(1,ii)) = 1;%distance(geom.face(2,ii),geom.face(1,ii));
			adjMtrx(geom.face(3,ii),geom.face(2,ii)) = 1;%distance(geom.face(3,ii),geom.face(2,ii));
			adjMtrx(geom.face(1,ii),geom.face(3,ii)) = 1;%distance(geom.face(1,ii),geom.face(3,ii));
		end
		
	%% extend adjacency matrix according to path length
	AdjMtrx = adjMtrx + eye(M);
	for rep = 1:(pathLength-1)
		for n =1:M
			neighbors = find(AdjMtrx(n,:));
			for m = neighbors
				AdjMtrx(n,:) = AdjMtrx(n,:)|adjMtrx(m,:);
			end
		end
	end
end