clear all;clc
load handel
v = y'/2;
figure(1)
plot((1:length(v))/Fs,v);
xlabel('Time [sec]');
ylabel('Amplitude');
title('Signal of Interest, v(n)');
% This is in time domain

% p8 = audioplayer(v,Fs);
% playblocking(p8);

L = 9;
n = length(v);
t2 = (1:n+1)/Fs;
t = t2(1:n); 
k = (2*pi/L)*[0:n/2-1 -n/2:-1];
ks = fftshift(k);

vt = fft(v(1:end-1));
figure(2)
subplot(2,1,1)
plot(t,v)
subplot(2,1,2)
plot(ks,fftshift(vt))

%% Gabor

%tslide = 0:0.1:9; 
tslide = 0:1:9;
%tslide = 0:0.02:9;
spc = [];
for j = 1:length(tslide)
    %g = exp(-(t-tslide(j)).^10); 
    %g = exp(-0.01*(t-tslide(j)).^10); %bigger window 
    %g = exp(-100*(t-tslide(j)).^10); %smaller window: localizing in time
    %g = exp(-(t-tslide(j)).^2); %Gaussian Wavelet
    %g = exp(-0.1*(t-tslide(j)).^2); %Gaussian Big
    %g = exp(-10*(t-tslide(j)).^2); %Gaussian Small
    %g = (1-(t-tslide(j)).^2).*exp(-(t-tslide(j)).^2); %Mexican hat
    %g = (1-0.1*(t-tslide(j)).^2).*exp(-0.1*(t-tslide(j)).^2); %Mexican hat big
    %g = (1-10*(t-tslide(j)).^2).*exp(-10*(t-tslide(j)).^2); %Mexican hat small
    %g = abs(t-tslide(j)) <= 0.5; %Shannon function
    %g = 0.1*abs(t-tslide(j)) <= 0.5; %Shannon function big 
    g = 10*abs(t-tslide(j)) <= 0.5; %Shannon function small
    
    vf = g.*v; % signal filter
    vft = fft(vf(1:end-1));
    spc = [spc;abs(fftshift(vft))]; %save fourier transform of the signal
    
    figure(3)
    subplot(3,1,1)
    plot(t,v,'k-',t,g,'r-','Linewidth',[2])
    subplot(3,1,2)
    plot(t,vf,'k-','Linewidth',[2])
    axis([0 9 -0.5 0.5])
    subplot(3,1,3)
    plot(fftshift(k),abs(fftshift(vft))/max(abs(fftshift(vft))),'m','Linewidth',[2])
    axis([-200 200 0 0.2])
    pause(0.2)
end

figure(4)
pcolor(tslide,fftshift(k),spc.'),shading interp, colormap(hot)
axis([0 7 -8000 8000])
title('Spectrogram use Gabor filter Shannon Wavelet(small window, oversampling)')

% Sspec = spectrogram(v);
% figure(5)
% pcolor(abs(Sspec)),shading interp, colormap(hot)

