function corrplots(y,maxlag)
%
% This function generates a plot of the acf and pacf functions
% for the data vector y, up to maxlag.
%
% Calling sequence: 
% corrplots(y,maxlag)
%

% J. McLellan, October 1998
% 
% Revision History:
%

figure(5);clf
subplot(211)
acf(y,maxlag);
subplot(212)
parcorfn(y,maxlag);