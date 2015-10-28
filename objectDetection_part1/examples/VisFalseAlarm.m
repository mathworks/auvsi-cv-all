% Copyright 2014-2015 The MathWorks, Inc
%% Open a new figure for visualization
figure

%% Visualization of True Positives for different Number of Cascaded Stages

subplot(2,2,1),plot(statsTable.FalseAlarmRates(1:4),statsTable.TP(1:4),'*-','LineWidth',2)
hold on
subplot(2,2,1),plot(statsTable.FalseAlarmRates(5:8),statsTable.TP(5:8),'^-','LineWidth',2)
subplot(2,2,1),plot(statsTable.FalseAlarmRates(9:12),statsTable.TP(9:12),'+-','LineWidth',2)
subplot(2,2,1),plot(statsTable.FalseAlarmRates(13:16),statsTable.TP(13:16),'o-','LineWidth',2)
subplot(2,2,1),plot(statsTable.FalseAlarmRates(17:20),statsTable.TP(17:20),'s-','LineWidth',2)
subplot(2,2,1),plot(statsTable.FalseAlarmRates(21:24),statsTable.TP(21:24),'d-','LineWidth',2)
hold off
set(gca,'XTick',0:0.025:1)
legend('NumStages - 5','NumStages - 7','NumStages - 9','NumStages - 11','NumStages - 13','NumStages - 15','Location','eastoutside')
xlabel('False Alarm Rate')
ylabel('Number of True Positives')
title('True Positives')

%% Visualization of False Alarms for different Number of Cascaded Stages

subplot(2,2,2),plot(statsTable.FalseAlarmRates(1:4),statsTable.FP(1:4),'*-','LineWidth',2)
hold on
subplot(2,2,2),plot(statsTable.FalseAlarmRates(5:8),statsTable.FP(5:8),'^-','LineWidth',2)
subplot(2,2,2),plot(statsTable.FalseAlarmRates(9:12),statsTable.FP(9:12),'+-','LineWidth',2)
subplot(2,2,2),plot(statsTable.FalseAlarmRates(13:16),statsTable.FP(13:16),'o-','LineWidth',2)
subplot(2,2,2),plot(statsTable.FalseAlarmRates(17:20),statsTable.FP(17:20),'s-','LineWidth',2)
subplot(2,2,2),plot(statsTable.FalseAlarmRates(21:24),statsTable.FP(21:24),'d-','LineWidth',2)
hold off
set(gca,'XTick',0:0.025:1)
legend('NumStages - 5','NumStages - 7','NumStages - 9','NumStages - 11','NumStages - 13','NumStages - 15','Location','eastoutside')
xlabel('False Alarm Rate')
ylabel('Number of False Alarms')
title('False Alarms')

%% Visualization of Misses for different Number of Cascaded Stages

subplot(2,2,3),plot(statsTable.FalseAlarmRates(1:4),statsTable.FN(1:4),'*-','LineWidth',2)
hold on
subplot(2,2,3),plot(statsTable.FalseAlarmRates(5:8),statsTable.FN(5:8),'^-','LineWidth',2)
subplot(2,2,3),plot(statsTable.FalseAlarmRates(9:12),statsTable.FN(9:12),'+-','LineWidth',2)
subplot(2,2,3),plot(statsTable.FalseAlarmRates(13:16),statsTable.FN(13:16),'o-','LineWidth',2)
subplot(2,2,3),plot(statsTable.FalseAlarmRates(17:20),statsTable.FN(17:20),'s-','LineWidth',2)
subplot(2,2,3),plot(statsTable.FalseAlarmRates(21:24),statsTable.FN(21:24),'d-','LineWidth',2)
hold off
set(gca,'XTick',0:0.025:1)
legend('NumStages - 5','NumStages - 7','NumStages - 9','NumStages - 11','NumStages - 13','NumStages - 15','Location','eastoutside')
xlabel('False Alarm Rate')
ylabel('Number of Misses')
title('Misses')

%% Visualization of True Negatives for different Number of Cascaded Stages

subplot(2,2,4),plot(statsTable.FalseAlarmRates(1:4),statsTable.TN(1:4),'*-','LineWidth',2)
hold on
subplot(2,2,4),plot(statsTable.FalseAlarmRates(5:8),statsTable.TN(5:8),'^-','LineWidth',2)
subplot(2,2,4),plot(statsTable.FalseAlarmRates(9:12),statsTable.TN(9:12),'+-','LineWidth',2)
subplot(2,2,4),plot(statsTable.FalseAlarmRates(13:16),statsTable.TN(13:16),'o-','LineWidth',2)
subplot(2,2,4),plot(statsTable.FalseAlarmRates(17:20),statsTable.TN(17:20),'s-','LineWidth',2)
subplot(2,2,4),plot(statsTable.FalseAlarmRates(21:24),statsTable.TN(21:24),'d-','LineWidth',2)
hold off
set(gca,'XTick',0:0.025:1)
legend('NumStages - 5','NumStages - 7','NumStages - 9','NumStages - 11','NumStages - 13','NumStages - 15','Location','eastoutside')
xlabel('False Alarm Rate')
ylabel('Number of True Negatives')
title('True Negatives')
