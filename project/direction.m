function [ beamWeight ] =direction( d,N,phase )
%UNTITLED2 Summary of this function goes here
%   d=element space in units of lambda
% N=number of sensors
%phase-broadside angle
if nargin==0
    help direction;
    return;
end
if phase ==90
    beamWeight=ones(N,1);
    return;
end
phase=(phase*pi)/180;
cosPhase=2*pi*d*cos(phase);
beamWeight=conj(compweight(N,cosPhase)');
    
    


end

