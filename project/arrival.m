function [ output ] = arrival( d,N,phase )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if nargin==0
    help arrival;
    return;
end
if phase ==90
    output=ones(1,N);
    return;
end
phase=(phase*pi)/180;
cosPhase=-2*pi*d*cos(phase);
output=compweight(N,cosPhase);
end

