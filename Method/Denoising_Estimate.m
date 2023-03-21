function Data = Denoising_Estimate(NoiseData,flag,Fs)
warning off
switch flag
    case 1
        Data = Zeroing_ICA(NoiseData,Fs); % Zeroing ICA
    case 2
        Data = wICA(NoiseData,Fs); % wICA
    case 3
        Data = ATICA(NoiseData,15,Fs); % ATICA
end
end