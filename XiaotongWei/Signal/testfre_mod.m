%% Plot the Frequency modulated signal
% Signal parameters
f0=10;
f1=20;
b=2;
A = 2;
%Frequency is 10
maxFreq = f0;
samplFreq = 5*maxFreq;
samplIntrvl = 1/samplFreq;

samplFreq2 = 0.5*maxFreq;
samplIntrvl2 = 1/samplFreq2;

% Time samples
timeVec = 0:samplIntrvl:6.0;
timeVec2 = 0:samplIntrvl2:6.0;
% Number of samples
nSamples = length(timeVec);

% Generate the signal
sigVec = fre_mod(timeVec,b,f0,f1,A);
sigVec2 = fre_mod(timeVec2,b,f0,f1,A);

%Plot the signal 
figure;
plot(timeVec,sigVec,'Marker','.','MarkerSize',24);
figure;
plot(timeVec2,sigVec2,'Marker','.','MarkerSize',24);
%
%Plot the periodogram
%--------------
%Length of data 
dataLen = timeVec(end)-timeVec(1);
%DFT sample corresponding to Nyquist frequency
kNyq = floor(nSamples/2)+1;
% Positive Fourier frequencies
posFreq = (0:(kNyq-1))*(1/dataLen);
% FFT of signal
fftSig = fft(sigVec);
% Discard negative frequencies
fftSig = fftSig(1:kNyq);

%Plot periodogram
figure;
plot(posFreq,abs(fftSig));

%Plot a spectrogram
%----------------
winLen = 0.8;%sec
ovrlp = 0.4;%sec
%Convert to integer number of samples 
winLenSmpls = floor(winLen*samplFreq);
ovrlpSmpls = floor(ovrlp*samplFreq);
[S,F,T]=spectrogram(sigVec,winLenSmpls,ovrlpSmpls,[],samplFreq);
figure;
imagesc(T,F,abs(S)); axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
