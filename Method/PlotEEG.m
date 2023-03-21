function PlotEEG(Data, Fs, ChanTitles, Scale, Title)
%
% PlotEEG(Data, Fs, ChanTitles, Scale, Title)
%
% This function plots EEG or analogous data 
%
% INPUT:
%
% Data       -> (nChan x nObserv) matrix of data
% Fs         -> sampling rate (default 256Hz)
% ChanTitles -> Cell with channel titles (optional)
% Scale      -> Y scale for drawing (optional)
% Title      -> Graph title (optional)
% 
%
% Valeri A. Makarov, vmakarov@opt.ucm.es
% Sept. 2006
%

if nargin < 1, 
    disp('No arguments');
    help PlotEEG
    return;
end
[nChs, nPts] = size(Data);
if nChs > 20, 
    disp('Too many channels (try to transpose the data)');
    return
end
if nargin < 2 || isempty(Fs),
    Fs = 256;   % default sampling rate
end
if nargin < 3 || isempty(ChanTitles),
    ChanTitles = [];   % default channel titles
end
if nargin < 4 || isempty(Scale),
    Scale =0.6*(max(Data(:)) - min(Data(:))); % atomatic Y-scale
end
if nargin < 5 || isempty(Title),
    Title = 'Data'; 
end
t = (1:nPts)/Fs;
Ct = {};
for k = 1:nChs,
    plot(t, (nChs - k)*Scale + Data(k,:),'k');
    hold on
    if isempty(ChanTitles),
        Ct = [Ct; {num2str(nChs - k + 1)}];
    else
        Ct = [Ct; ChanTitles(nChs - k + 1)];
    end
end
hold off;
xlim([0 nPts]/Fs);
ylim([-1 nChs+1]*Scale);
title(Title);
set(gca,'YTick', (0:1:nChs-1)*Scale);
set(gca,'YTickLabel',Ct);
xlabel('Time (s)')
