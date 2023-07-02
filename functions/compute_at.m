function [ATmindVdT,EGM2] = compute_at(EGM, ATsearchreg, mindVdTmeth, filtParam)
% EGM base line should be removed beforehand
% ATmethod  'mindVdT', 'ST' (Erem's), 'SC' (Duchateau's)
% geom.node px3
% geom.face qx3
% ATsearchreg [beginInd endInd]
% mindVdTmeth 'MA' 'BW' 'NoFilt'
% filtParam: winLength for 'MA' and [orderBW cutoffH Fs] for BW

% Compute AT using the min_dVdT method
   
nNodes = size(EGM,1);
switch mindVdTmeth
    case 'NoFilt'
        EGM2 = EGM;
    case 'MA'
        winLength = filtParam;
        EGM2 = lowpassma(EGM,winLength);
    case 'BW'
        orderBW = filtParam(1);%5;
        % Filter high freq noise
        cutoffH = filtParam(2);%60;
        Fs = filtParam(3);
        WnH=cutoffH/(Fs/2);
        [aH, bH]=butter(orderBW,WnH,'low');
        for j = 1:nNodes
            EGM2(j,:) = filtfilt(aH,bH,EGM(j,:)); % HF noise removed
        end
end
[ATmindVdT, ~,~] = mindVdT(EGM2(:,ATsearchreg(1):ATsearchreg(2))); % % The unit of AT in samples.
% [ATmindVdT, ~] = mindVdT(EGM2(:,ATsearchreg(1):ATsearchreg(2))); % % The unit of AT in samples.
ATmindVdT = ATmindVdT(:)+ATsearchreg(1)-1;

% switch ATmethod
%     case 'mindVdT'
%     case 'ST'
%         % ST AT parameters
%         pathLength = 2;	% number of jumps on graph to determine neighborhood
%         % compute adjacency matrix
%         [AdjMtrx] = computeAdjacencyMatrix(geom, pathLength);
%         % compute gradient estimator
%         wghFcn = @(indx) AdjMtrx(indx,:);
%         [~, H] = meshVolDiffHessMatrix(geom,wghFcn);
%         Ltan=LaplacianMatrixFromHessianMatrix(H);
%         A = eye(max(size(geom.pts)));
%         [U,S,X,~,~] = cgsvd(A,Ltan);
% %         [m,n] = size(U);[sm,sn] = size(S);[am,an] = size(ATmindVdT);
% %         fprintf('U size %d x %d',m,n); fprintf('S size %d x %d',sm,sn);
% %         fprintf('ATmindvdt %d x %d',am,an);
%         [reg_min,~,~] = gcv(U,S,ATmindVdT);
%         [ATspattemp,~,~] = tikhonov(U,S,X,ATmindVdT,reg_min);
%     case 'SC'
%         [ATspattemp] = ActivationTimeSC_v2(EGM2,ATmindVdT, geom);
% end

% for k=1:nNodes
%     subplot(211)
%     plot(ATsearchreg(1):ATsearchreg(2),EGM(k,ATsearchreg(1):ATsearchreg(2)),'k');
%     hold on
%     plot(ATsearchreg(1):ATsearchreg(2),EGM2(k,ATsearchreg(1):ATsearchreg(2)),'b');
%     axis tight
%     v=axis;
%     h=line([ATmindVdT(k) ATmindVdT(k)],v(3:4));h.Color = 'r';
%     h=line([ATspattemp(k) ATspattemp(k)],v(3:4));h.Color = 'g';
% %     h=line([ATspattemp2(k) ATspattemp2(k)],v(3:4));h.Color = 'm';
%     title(num2str(k))
%     hold off
%     subplot(212)
%     plot(ATsearchreg(1):ATsearchreg(2),FilteredSig(k,:),'b');
%     hold on
%     axis tight
%     v=axis;
%     h=line([ATmindVdT(k) ATmindVdT(k)],v(3:4));h.Color = 'r';
%     h=line([ATspattemp(k) ATspattemp(k)],v(3:4));h.Color = 'g';
%     hold off
%     pause
% end
