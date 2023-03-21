
%% suggest that the data length is equal to 1000, 
%% and there are provide three artifact denoising methods, that is
%% Zeroing ICA, wICA, ATICA.
clc;
clear all;
close all;
Method_flag = [1,2,3];
Method_Label = {'Zeroing ICA','wICA','ATICA'};
addpath(genpath(pwd))
load('example Data.mat');
% Data = Data_filter;
Fs = 1000;
Downsample = 10;
for c_i = 1:size(Data_filter,1)
    Data(c_i,:) = downsample(Data_filter(c_i,:),Downsample);
end
Fs = Fs/Downsample;
for method_ii = 1:length(Method_flag)
    tic
    rec_Data = Denoising_Estimate(Data,Method_flag(method_ii),Fs);
    figure('color',[1 1 1]);
    for c_i = 1:1:30
        subplot(10,3,c_i)
        plot(Data(c_i,:));
        hold on
        plot(rec_Data(c_i,:)); 
    end
    title([Method_Label{Method_flag(method_ii)}])
    T = toc;
    fprintf('Method: %s, Spend Time: %.2f s\n',Method_Label{Method_flag(method_ii)},T);
end
