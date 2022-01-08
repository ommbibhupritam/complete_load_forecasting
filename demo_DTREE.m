clear
close all
clc

load fulldataset
data=fulldataset;
clear fulldataset
rng=1000:2000;
figure(1);
plot(data(rng));xlabel('Time (hours)');ylabel('Active Power (MW)');title('Decision Tree Model');
xlim([0 rng(end)-rng(1)]);

hrs=60;

T=traj(data,hrs);
X=T(1:end-1,:);
Y=T(2:end,1);

per=10;
train_loc=randperm(numel(Y),round((numel(Y)/100)*per));

train_X=X(train_loc,:);
test_X=X;test_X(train_loc,:)=[];
train_Y=Y(train_loc,:);
test_Y=Y;test_Y(train_loc,:)=[];

tree = fitrtree(train_X,train_Y);
pred_Y = predict(tree,test_X);
rmserror=sqrt(mean((test_Y-pred_Y).^2));

Mean_Absolute_Percentage_Error = 100*mean((abs(test_Y-pred_Y))./abs(test_Y))

figure(1);hold on;
plot(pred_Y(rng));legend('Actual','Predicted');

figure(2);
subplot(2,2,1);
plot(data);xlabel('Samples');ylabel('Active power (MW)');title('Load forecast');
subplot(2,2,2);
plot(test_Y,'.b');hold on;
plot(pred_Y,'.r');legend('Test samples','Predicted');xlabel('Samples');
title(strcat('Root Mean Square error:  ',num2str(Mean_Absolute_Percentage_Error),'%'));
subplot(2,2,3);
plot((test_Y-pred_Y)./test_Y);xlabel('Samples');ylabel('Prediction error rate');
subplot(2,2,4);
plot(test_Y,pred_Y,'.');xlabel('Actual Load demand (MW)');ylabel('Predicted Load demand (MW)');

