% Script computing the full joint distribution of the network!

clear all
close all

load('dataBNet_12_06_26__12_07_28.mat', 'timeline');

startI=1;
endI=size(timeline,2);
startFault=6001;
% 1 to 2000: learnng data to compute CPT
% 2001 to 4000: data fault to test our bnet
 
faultValue=1000;
%115: value with more prob after 2

% Load data and formatted according to the Bayesian network
dataZplug = createDataZplug; 
% Create data fault
[dataFault, indexMat] = createDataFault(dataZplug(:,startI:endI), startFault, faultValue, 'complete');

% discretizza i dati
[dataLearning, minmaxVector] = prepareDataLearning(dataFault);

% learning on pure data
bnetCPT = calculateCPT(dataLearning(:,1:startFault-1),minmaxVector);


%save 'CPT_hiddenZplug.mat'
 
%load('CPT_hiddenZplug.mat', 'bnetCPT');

disp('Computing joint distribution...');

[jointDistr, localCondDistr] = computeJointDistr(bnetCPT, dataLearning(:,startFault:endI));



save 'CPT_jointDistr.mat'

% Instead of calulating all the data, you can directly load this mat file!
%load 'CPT_jointDistr.mat'

% plot the result
indexMatRel(1:2,:)= indexMat(1:2,:) - startFault + 1;
indexMatRel(3,:)=indexMat(3,:);

% Set x Label Date
startDate = datenum(timeline{startFault});
endDate = datenum(timeline{endI});
xData = linspace(startDate,endDate,endI-startFault+1);

figure
semilogy(xData, jointDistr, 'b.')
hold on

for i=1:size(indexMatRel,2)
    switch(indexMatRel(3,i))
        case -2
            semilogy(xData(indexMatRel(1,i):indexMatRel(2,i)),jointDistr(indexMatRel(1,i):indexMatRel(2,i)), 'r.');
        case -1
            semilogy(xData(indexMatRel(1,i):indexMatRel(2,i)),jointDistr(indexMatRel(1,i):indexMatRel(2,i)), 'g.');
        otherwise
            k=indexMatRel(3,i);
            semilogy(xData(indexMatRel(1,i):indexMatRel(2,i)),jointDistr(indexMatRel(1,i):indexMatRel(2,i)), 'g.');
            semilogy(xData(k-startFault +1),jointDistr(k-startFault +1), 'ro', 'MarkerFaceColor', [1 0 0]);
    end
    
end
% leg=legend({'correct data', 'detection with faults', 'detection without faults'});
% legtxt=findobj(leg,'type','line');
% 
% set(legtxt(5),'color','b');
% set(legtxt(3),'color','r');
% set(legtxt(1),'color','g');

set(gca,'XTick',xData)
datetick('x','dd-mmm','keeplimits')
xlabel('time');
ylabel('log(likelihood)');