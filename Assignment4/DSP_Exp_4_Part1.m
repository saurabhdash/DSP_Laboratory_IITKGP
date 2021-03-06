%Power Spectral Density of sequence x(n) using Welch’s Non Parametric Method
close all;
clear all;
clc;

N=128;
N_point_dft=512;
y=normrnd(0,1,1,N);

B=1;
A=[1 -0.9 0.81 -0.729];

x=filter(B,A,y);
x_size=size(x);

L=8;
D=2;

M=ceil((x_size(1,2)+(L-1)*D)/L);
k=1;
x_samples=zeros(L,M);

for Rs=1:L
    for j=1:M
        if k <= x_size(1,2)
            x_samples(Rs,j)=x(1,k);
        end
        
        k=k+1;
    end
    
    k=k-D;
end

n=0:M-1;
sum=0;

for N=1:M
    w(1,N)=0.54-0.46*cos(2*pi*n(1,N)/(M-1));
    sum=sum+w(1,N)*w(1,N);
end

U=sum/M;

for Rs=1:L
    for n=1:M
        W(Rs,n)=x_samples(Rs,n).*w(1,n);
    end
    dft_sq(Rs,:)=fft(W(Rs,:),N_point_dft);
end

for Rs=1:L
    for n=1:N_point_dft
        p(Rs,n)=(dft_sq(Rs,n).*dft_sq(Rs,n))./(M*U);
    end
end

P=zeros(1,N_point_dft);

for n=1:N_point_dft
    for Rs=1:L
        P(1,n)= P(1,n)+p(Rs,n);
    end
    P(1,n)=P(1,n)./L;
end

plot(-.5:1/N_point_dft:.5-1/N_point_dft,fftshift(abs(P)));
title('Power Spectral Density of sequence x(n) using Welch’s Non Parametric Method ');
xlabel('Frequency ------>');ylabel('Power Spectral Density ------>')
