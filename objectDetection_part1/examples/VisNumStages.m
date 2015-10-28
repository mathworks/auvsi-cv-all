% Copyright 2014-2015 The MathWorks, Inc
%% Open a new figure for visualization
figure

%% Visualization of True Positives for different False Alarm Rates


subplot(2,2,1),plot(statsTable.NumStages(1:4:24),statsTable.TP(1:4:24),'*-','LineWidth',2)
hold on
subplot(2,2,1),plot(statsTable.NumStages(2:4:24),statsTable.TP(2:4:24),'^-','LineWidth',2)
subplot(2,2,1),plot(statsTable.NumStages(3:4:24),statsTable.TP(3:4:24),'+-','LineWidth',2)
subplot(2,2,1),plot(statsTable.NumStages(4:4:24),statsTable.TP(4:4:24),'o-','LineWidth',2)
hold off
set(gca,'XTick',5:2:15)
legend('False Alarm Rate - 10%','False Alarm Rate - 7.5%','False Alarm Rate - 5%','False Alarm Rate - 2.5%','Location','eastoutside')
xlabel('Number of Cascaded Stages')
ylabel('Number of True Positives')
title('True Positives')

%% Visualization of False Alarms for different False Alarm Rates

subplot(2,2,2),plot(statsTable.NumStages(1:4:24),statsTable.FP(1:4:24),'*-','LineWidth',2)
hold on
subplot(2,2,2),plot(statsTable.NumStages(2:4:24),statsTable.FP(2:4:24),'^-','LineWidth',2)
subplot(2,2,2),plot(statsTable.NumStages(3:4:24),statsTable.FP(3:4:24),'+-','LineWidth',2)
subplot(2,2,2),plot(statsTable.NumStages(4:4:24),statsTable.FP(4:4:24),'o-','LineWidth',2)
hold off
set(gca,'XTick',5:2:15)
legend('False Alarm Rate - 10%','False Alarm Rate - 7.5%','False Alarm Rate - 5%','False Alarm Rate - 2.5%','Location','eastoutside')
xlabel('Number of Cascaded Stages')
ylabel('Number of False Alarms')
title('False Alarms')

%% Visualization of Misses for different False Alarm Rates

subplot(2,2,3),plot(statsTable.NumStages(1:4:24),statsTable.FN(1:4:24),'*-','LineWidth',2)
hold on
subplot(2,2,3),plot(statsTable.NumStages(2:4:24),statsTable.FN(2:4:24),'^-','LineWidth',2)
subplot(2,2,3),plot(statsTable.NumStages(3:4:24),statsTable.FN(3:4:24),'+-','LineWidth',2)
subplot(2,2,3),plot(statsTable.NumStages(4:4:24),statsTable.FN(4:4:24),'o-','LineWidth',2)
hold off
set(gca,'XTick',5:2:15)
legend('False Alarm Rate - 10%','False Alarm Rate - 7.5%','False Alarm Rate - 5%','False Alarm Rate - 2.5%','Location','eastoutside')
xlabel('Number of Cascaded Stages')
ylabel('Number of Misses')
title('Misses')

%% Visualization of True Negatives for different False Alarm Rates

subplot(2,2,4),plot(statsTable.NumStages(1:4:24),statsTable.TN(1:4:24),'*-','LineWidth',2)
hold on
subplot(2,2,4),plot(statsTable.NumStages(2:4:24),statsTable.TN(2:4:24),'^-','LineWidth',2)
subplot(2,2,4),plot(statsTable.NumStages(3:4:24),statsTable.TN(3:4:24),'+-','LineWidth',2)
subplot(2,2,4),plot(statsTable.NumStages(4:4:24),statsTable.TN(4:4:24),'o-','LineWidth',2)
hold off
set(gca,'XTick',5:2:15)
legend('False Alarm Rate - 10%','False Alarm Rate - 7.5%','False Alarm Rate - 5%','False Alarm Rate - 2.5%','Location','eastoutside')
xlabel('Number of Cascaded Stages')
ylabel('Number of True Negatives')
title('True Negatives')
