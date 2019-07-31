%% Piano
clear all;clc
L = 16;
n = 701440;
t2 = linspace(0,L,n+1);
t = t2(1:n); % make n+1 points and throw out the last point
k = (2*pi/L)*[0:n/2-1 -n/2:-1];

tr_piano=16; % record time in seconds
y1=audioread('music1.wav'); 
Fs1=length(y1)/tr_piano;
y1 = y1.';
figure(1)
plot((1:length(y1))/Fs1,y1);
xlabel('Time [sec]'); ylabel('Amplitude');
title('Mary had a little lamb (piano)'); drawnow
%p8 = audioplayer(y1,Fs1); playblocking(p8);

figure(2)
tslide = 0:0.1:16; 
Max = [];
spc = [];
for j = 1:length(tslide)
    g = exp(-20*(t-tslide(j)).^2);
    Sf = g.*y1; % signal filter
    Sft = fft(Sf);
    [f_max,ind] = max(Sft);
    Max = [Max;k(ind)];
    spc = [spc;abs(fftshift(Sft))];
 
    subplot(3,1,1)
    plot(t,y1,'k-',t,g,'r-','Linewidth',[2])
    subplot(3,1,2)
    plot(t,Sf,'k-','Linewidth',[2])
    axis([0 16 -1 1])
    subplot(3,1,3)
    plot(fftshift(k),abs(fftshift(Sft))/max(abs(fftshift(Sft))),'m','Linewidth',[2])
    axis([-100 100 0 0.1])
    pause(0.2)
end
figure(3)
plot(tslide,abs(Max./(2*pi)))
xlabel('Time [sec]'); ylabel('Hz');
title('Mary had a little lamb (piano)')

figure(4)
pcolor(tslide,fftshift(k),spc.'),shading interp, colormap(hot)
axis([0 7 -4000 4000])
title('Spectrogram of Mary had a little lamb (piano)')
%% Record
clear all;clc
L = 14;
n = 627712;
t2 = linspace(0,L,n+1);
t = t2(1:n); % make n+1 points and throw out the last point
k = (2*pi/L)*[0:n/2-1 -n/2:-1];

figure(5)
tr_rec=14; % record time in seconds
y2=audioread('music2.wav'); Fs2=length(y2)/tr_rec;
y2 = y2.';
plot((1:length(y2))/Fs2,y2);
xlabel('Time [sec]'); ylabel('Amplitude');
title('Mary had a little lamb (recorder)');
%p8 = audioplayer(y,Fs); playblocking(p8);

tslide = 0:0.1:14; 
Max2 = [];
spc2 = [];
for j = 1:length(tslide)
    g = exp(-20*(t-tslide(j)).^2);
    Sf2 = g.*y2; % signal filter
    Sft2 = fft(Sf2);
    [f_max2,ind] = max(Sft2);
    Max2 = [Max2;k(ind)];
    spc2 = [spc2;abs(fftshift(Sft2))];
    
%     figure(6)
%     subplot(3,1,1)
%     plot(t,y2,'k-',t,g,'r-','Linewidth',[2])
%     subplot(3,1,2)
%     plot(t,Sf2,'k-','Linewidth',[2])
%     axis([0 14 -1 1])
%     subplot(3,1,3)
%     plot(fftshift(k),abs(fftshift(Sft2))/max(abs(fftshift(Sft2))),'m','Linewidth',[2])
%     axis([-100 100 0 0.1])
%     pause(0.2)
end
figure(7)
plot(tslide,abs(Max2./(2*pi)))
xlabel('Time [sec]'); ylabel('Hz');
title('Mary had a little lamb (recorder)')
figure(8)
pcolor(tslide,fftshift(k),spc2.'),shading interp, colormap(hot)
axis([0 7 -10000 10000])
title('Spectrogram of Mary had a little lamb (recorder)')