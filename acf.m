function rho=acf(y,mlag)
%
% This function calculates the autocorrelation function 
% up to a given maximum lag. 
%
% calling sequence:
%        rho=acf(y,mlag)
% where
%        rho returns the numerical values of the autocorrelations
%        y is the data record
%        mlag is the maximum lag for the plot
%
% J. McLellan, October 1997

n=max(size(y));      
if size(y,1)==1
   y=y';
end;
rho(1)=1;
meany=mean(y);
yc=y-meany;
ycsq=yc'*yc;
for i=1:mlag
   rho(i+1)=yc(1:n-mlag,1)'*yc(1+i:n-mlag+i,1)/ycsq;
end;
%figure(2)
hold off
subplot(211)
index=0:1:mlag;
lim=ones(mlag+1,1)*2/sqrt(n);
bar(index,rho);
hold on
plot(index,lim,'r--');
plot(index,-1*lim,'r--');
title('autocorrelation function')
xlabel('lag');
ylabel('ACF');
hold on