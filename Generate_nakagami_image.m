%% Generate Nakagami mu_Image and omega_Image
%  1)A square window of length, L, and width, W, is taken across envelope 
%    matrix (starting from the upper-left corner). The elements within the 
%    box are fed into a nakagami distribution, and resulting mu and omega 
%    values are stored in corresponding positions of mu_Image and 
%    omega_Image matrices respectively
%  2)Square window is shifted by one pixel over the whole envelope matrix
%    and step 1 is repeated for each shift
%% Input
clear all;close all;clc
W=15;  %Width=15 elements laterally across matrix
L=73;  %Lenght=73 elements axially across matrix

% READ DATA
load('rf_data_patient1.mat','rf');
env = envelope(rf);  % COMPUTE ENVELOPE (Envelope Matrix)
[rENV,cENV]=size(env);

%% Generate Nakagami 
for c=1:cENV-W+1
    for r= 1 : rENV-L+1                              
        Window=env(r : L+r-1,  c : c+W-1);  %square window     
        [~,~,values_window] = find(Window);
        naka=fitdist(values_window,'Nakagami');
        mu_Image(r,c)=naka.mu;
        omega_Image(r,c)=naka.omega;
    end
end
%% Output 
% mu_Image---------->local mapping of m parameter of Nakagami distribution
% omega_Image------->local mapping of omega parameter of Nakagami distribution
figure(1),imagesc(mu_Image),title('mu image')
figure(2),imagesc(omega_Image),title('omega image')