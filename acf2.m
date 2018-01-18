function rho=acf2(y,mlag)
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

figure(2),clf

index=0:1:mlag;
lim=1.96/sqrt(2*mlag+1)
lim=repmat(lim,1,mlag+1)
bar(index,rho);
hold on
plot(index,lim,'r:');
plot(index,-1*lim,'r:');
%title('autocorrelation function')
xlabel('lag');
ylabel('ACF');
hold on
axis([-5 450 -1.05 1.05])