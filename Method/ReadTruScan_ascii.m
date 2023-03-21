function [data, ChanTitle, fn] = ReadTruScan_ascii(fn)

if nargin < 1,
    [filename, pathname] = uigetfile({'*.txt;*.tdt'}, 'Select an ascii EEG file');
    if isequal(filename,0) | isequal(pathname,0),
        data = []; ChanTitle = []; fn = [];
        return
    end
    
    fn = [pathname filename];
end
fid = fopen(fn,'r');

Ns = 1;
s = fscanf(fid,'%s',1);
while isempty(str2num(s)),
    ChanTitle{Ns} = s;
    Ns = Ns + 1;
    s = fscanf(fid,'%s',1);
end
data = [str2num(s); fscanf(fid,'%f')];
Ncol = Ns - 1; % number of columns
data = reshape(data,Ncol,[])';
fclose(fid);    
