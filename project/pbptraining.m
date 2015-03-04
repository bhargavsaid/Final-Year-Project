function beampair = pbptraining( inputAngles,outputAngles,N,transAngle,receiveAngle )


%N-number of arrays

%signal 
t=linspace(0,1,100);
testsig=ones(size(t));

f=100e6;
wavelength=physconst('LightSpeed')/f;
distance=wavelength/2;

%transmitter signal
s1=direction(0.5,N,inputAngles(1))*testsig;
s2=direction(0.5,N,inputAngles(2))*testsig;
s3=direction(0.5,N,inputAngles(3))*testsig;
s4=direction(0.5,N,inputAngles(4))*testsig;

%channel matrix
H=direction(0.5,N,receiveAngle)*arrival(0.5,N,transAngle);

%received signals
r1=awgn(H*s1,20,'measured');
r2=awgn(H*s2,20,'measured');
r3=awgn(H*s3,20,'measured');
r4=awgn(H*s4,20,'measured');

%Received matrix
rMat=[r1 r2 r3 r4];

%beamforming algo
power=zeros(4,4);
output=zeros(1,100);

for i=1:length(inputAngles)
    for k=1:length(outputAngles)
        
        
            l=(i-1)*100+1;
            output=arrival(0.5,N,outputAngles(k))*rMat(:,l:l+99); 
            
            totalOutput=sum(output);
            power(i,k)=abs(totalOutput);
        
             %output=arrival(0.5,N,outputAngles(k))*r2;
            %totalOutput=sum(output);
            %power(i,k)=abs(totalOutput);
        
     end
    
end


%totalOutput=sum(output);
%power=abs(totalOutput);
[row,col]=find(power==max(power(:)));
%[row,col]
power   
beampair=[inputAngles(row),outputAngles(col)];

end

