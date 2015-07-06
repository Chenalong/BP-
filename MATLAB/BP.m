% close all 
% clear 
% echo on 
% clc 

% [inputs,targets] = simplefitdata;
%  net = newff(inputs,targets,20);
%  net = train(net,inputs,targets);
%  outputs = net(inputs);
%  errors = outputs - targets;
%  perf = perform(net,outputs,targets)
inputs = zeros(12,8);

fid = fopen('fingers_feature.txt');
inputs = fscanf(fid, '%f', [12,8]);
disp(inputs);
fclose(fid);
% inputs = [1,2,3,4;1.9,3.7,5.2,3.6;0,1,-1,-1;2,4,6,4;3,6,9,3];
targets = [0,0,0,0,1,1,1,1;0,0,1,1,0,0,1,1;0,1,0,1,0,1,0,1];
net = newff(inputs,targets,20);
net = train(net,inputs,targets);
outputs = net(inputs);
errors = outputs - targets;
perf = perform(net,outputs,targets)  


% NEWFF??����һ���µ�ǰ�������� 
% TRAIN??�� BP ���������ѵ�� 
% SIM??�� BP ��������з��� 
% pause        
% %  ���������ʼ 
% clc 
% %  ����ѵ������ 
% % P Ϊ����ʸ�� 
% P=[-1,  -2,    3,    1;       -1,    1,    5,  -3];
% % T ΪĿ��ʸ�� 
% T=[-1, -1, 1, 1]; 
% pause; 
% clc 
% %  ����һ���µ�ǰ�������� 
% net=newff(minmax(P),[3,1],{'tansig','purelin'},'traingdm')
% %  ��ǰ�����Ȩֵ����ֵ 
% inputWeights=net.IW{1,1} 
% inputbias=net.b{1} 
% %  ��ǰ�����Ȩֵ����ֵ 
% layerWeights=net.LW{2,1} 
% layerbias=net.b{2} 
% pause 
% clc 
% %  ����ѵ������ 
% net.trainParam.show = 50; 
% net.trainParam.lr = 0.05; 
% net.trainParam.mc = 0.9; 
% net.trainParam.epochs = 1000; 
% net.trainParam.goal = 1e-3; 
% pause 
% clc 
% %  ���� TRAINGDM �㷨ѵ�� BP ���� 
% [net,tr]=train(net,P,T); 
% pause 
% clc 
% %  �� BP ������з��� 
% A = sim(net,P) 
% %  ���������� 
% E = T - A 
% MSE=mse(E) 
% pause 
% clc 
% echo off 