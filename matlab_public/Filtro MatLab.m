%Sinais e Sistemas
%Darlan Nascimento e Alo�zio
%Implementa��o de um filtro Faixa Baixa digital
%Junho de 2019
clc;
clear all;
close all;

%Carregando a m�sica e coletando a Frequencia de Amostragem
[x, fs] = audioread('carrie1.wav');
%Pegando o Lado Direito
audio = x(:, 1).';
%An�lise do Espectro no dom�nio da Frequ�ncia
my_fft(audio, fs);
%Processo de Filtragem
%Dados===========================================
fc = 4000;
M = 10; %Coprimento do Filtro
wc = (2*pi*fc)/fs;%Frequencia de Corte
%================================================
n = [0:M-1];

%Janela de Hamming
w = (0.54 - 0.46*cos((2*pi*n)/(M-1)))';%Janela Ideal
hd = (wc/pi)*sinc((wc/pi)*(n-(M/2))); %Filtro Ideal

%Calcular Filtro PB
h=hd'.*w; %Multiplica��o entre os vetores

%Filtragem do sinal
audio_filtrado = conv(h,audio); %convolu��o entre os sinais
my_fft(audio_filtrado,fs); %Espectro de Frequencias do sinal filtrado

%figure();
%plot(audio_filtrado(1:length(t)));
%title('An�lise de Espectro2');
%xlabel('Frequ�ncia(Hz)');
%ylabel ('Amplitude');


function [S,frequency] = my_fft (s, fs)

normal = length(s);
aux = 0:normal-1;
T = normal/fs;
frequency = aux/T;
S = fftn(s)/normal;
fc = ceil(normal/2);
S = S(1:fc);

figure();
plot(frequency(1:fc),abs(S));
title('An�lise de Espectro');
xlabel('Frequ�ncia(Hz)');
ylabel ('Amplitude');
grid on;

end
