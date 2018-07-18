% Data acquisition

addpath(genpath('dataAcquisition'));
disp("Creating matrix 'dataBnet.mat'...");
dataBnet = createDataBNet('database/until12_07_26.sqlite', '2012-06-26 00:00:00', '2012-06-29 00:00:00');
fprintf("Saving matrix 'dataBnet.mat'...");
save('dataBNet.mat');
disp('Done!');