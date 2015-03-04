function [ beamPair ] = beamCoding( inputAngles,outputAngles,N,transAngle,receiveAngle )
%Computes the beamcoding algorithm
%   Detailed explanation goes here
%N-number of arrays

%signal 
t=linspace(0,1,100);
testsig=ones(size(t));

f=100e6;
wavelength=physconst('LightSpeed')/f;
distance=wavelength/2;

%computing the weights
for e=1:length(inputAngles)
    w(:,e)=direction(0.5,N,inputAngles(e));
end

%walsh-hadamard

z=hadamard(length(inputAngles));

hadMat=w*z;

%transmitter signal
s1=hadMat(:,1)*testsig;
s2=hadMat(:,2)*testsig;
s3=hadMat(:,3)*testsig;
s4=hadMat(:,4)*testsig;

%channel matrix
H=direction(0.5,N,receiveAngle)*arrival(0.5,N,transAngle);

%received signals
r1=awgn(H*s1,20,'measured');
r2=awgn(H*s2,20,'measured');
r3=awgn(H*s3,20,'measured');
r4=awgn(H*s4,20,'measured');


rMat=[r1 r2 r3 r4];

output=zeros(length(inputAngles),100,length(outputAngles));
power=zeros(length(inputAngles),length(outputAngles));
totalOutput=zeros(length(inputAngles),length(outputAngles));


%beamforming algo
for k=1:length(outputAngles)
    for i=1:length(inputAngles)
        for test=1:length(inputAngles)   
        
            l=(i-1)*100+1;
            output(test,:,k)=output(test,:,k)+z(test,i)*arrival(0.5,N,outputAngles(k))*rMat(:,l:l+99) ;
           
        
             %output=arrival(0.5,N,outputAngles(k))*r2;
            %totalOutput=sum(output);
            %power(i,k)=abs(totalOutput);
        
        end
    
    end
end

for input=1:length(inputAngles)
    for out=1:length(outputAngles)
        totalOutput(input,out)=sum(output(input,:,out));
        power(input,out)=abs(totalOutput(input,out));
    end
end
    power;
    [row,col]=find(power==max(power(:)));
    beamPair=[inputAngles(row),outputAngles(col)];



        
    
    end






