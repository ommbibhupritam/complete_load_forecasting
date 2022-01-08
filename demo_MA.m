clear
close all
clc

load fulldataset
data=fulldataset;
clear fulldataset
rng=1000:2000;
figure(1);
plot(data(rng));xlabel('Time (hours)');ylabel('Active Power (MW)');title('Moving Average Model');
xlim([0 rng(end)-rng(1)]);
hrs=60;
predicted = movavgFilt (data', hrs, 'Left');
rmserror=sqrt(mean((data(hrs:end)-predicted(hrs:end)').^2));

Mean_Absolute_Percentage_Error = 100*mean((abs(data(hrs:end)-predicted(hrs:end)'))./abs(data(hrs:end)))

figure(1);hold on;
plot(predicted(rng));legend('Actual','Predicted');

figure(2);
subplot(2,2,1);
plot(data);xlabel('Samples');ylabel('Active power (MW)');title('Load forecast');
subplot(2,2,2);
plot(data,'.b');hold on;
plot(predicted,'.r');legend('Test samples','Predicted');xlabel('Samples');
title(strcat('Mean Absolute Percentage Error:  ',num2str(Mean_Absolute_Percentage_Error),'%'));
subplot(2,2,3);
plot((data-predicted')./data);xlabel('Samples');ylabel('Prediction error rate');
subplot(2,2,4);
plot(data,predicted','.');xlabel('Actual Load demand (MW)');ylabel('Predicted Load demand (MW)');
