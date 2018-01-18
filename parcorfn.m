function pacf=parcorfn(y,maxlag)
%
% This function computes the partial autocorrelation function up
% to lag "maxlag" using a regression approach. The SWEEP operator
% is used to compute that necessary coefficients.
%
% Calling sequence: 
%  parcorfn(y,maxlag)
%

% J. McLellan, October 1998
% 
% Revision History:
%

% First, set up the data matrix:
if size(y,1)==1
   y=y';
end;
% and mean centre
y=y-mean(y);
dlength=size(y,1);
Y=zeros(dlength-maxlag,maxlag+1);
for i=0:maxlag
   % funny index (i+1) is because of non-zero subscripting limit
   Y(:,i+1)=y(i+1:dlength-maxlag+i);
end;
% 
% Now set up sum of squares matrix from Y for the sweep operator
%
S0=Y'*Y;
% and get ready to compute pacf's
pacf=zeros(maxlag+1,1);
pacf(1)=1.0;
for i=1:maxlag
   S=sweep(S0,i);
   % remember that there are maxlag+1 columns of data here,
   % and the first lag will appear in the second (and subsequently
   % i+1 ) diagonal elements of the computed S matrix
   pacf(i+1)=S(1,i+1);
   S0=S;
end;
bar(0:maxlag,pacf)
title('partial autocorrelations')
xlabel('lag')
ylabel('pacf value')
hold on
lim=ones(maxlag+1,1)*2/sqrt(dlength);
plot(0:maxlag,lim,'r--',0:maxlag,-lim,'r--')

