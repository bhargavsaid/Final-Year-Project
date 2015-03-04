function [ weights ] =compweight(N, phase )
%UNTITLED3 Summary of this function goes here
%   phase-direction towards which the phase should be computed
    if nargin==0
        help scan;
        return;
    end
    
    m=(0:N-1)-(N-1)/2;
    weights=exp(-1i*m*phase);
    
              

end

