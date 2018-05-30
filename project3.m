%% EE564 DESIGN OF ELECTRICAL MACHINES
% PROJECT 3 - TRACTION MOTOR DESIGN


%% INTRODUCTION
% In this project,quirrel cage induction generator will be designed for 
% the Northel Energy's VIRA-250 wind turbine. Then, designed motor will be analyzed 
% analyzed with FEM program. Specificitions of the generator as follows,

%%
% * Rated Power: 250 kW
% * Rated Wind Speed: 14 m/s
% * Rated Turbine Speed: 24.3 rpm
% * Gear Ratio: 31.2
% * Number of Poles: 8
% * Line to line voltage: 400 V
% * Frequency: 50 Hz
% * Rated Speed: 758 rpm
% * Gearbox: (Coupled from wind turbine blade)
% * Intended duty cycle :S1, direct on-line drive
% * 3 phase
%%
% Design steps at below will be followed at this design.
%%
% =================>>>>>>>>>>>>>>>>>>>>>>>> procedure.jpg koyulacak

%%
%
% %
%%

%% STARTING VALUES
% For this design, I aimed premium efficiency class because motor consumes
% high energy. It saturates %95.8 efficiency for high energy motors. Then, 
% target efficiency is chosen %96.
%=================>>>>>>>>>>>>>>>>>>>>>>>>>>verim standardý eklenecek

%%

P_rated = 250e3; %W
Vline = 400; %V
Npole = 8;
n_rated = 758; %rpm
T_rated = 7843; %Nm
f_rated = 50; %Hz
eff_des = 96; % %
Vph = Vline/sqrt(3);
Pph = Prated/3;

Npole_pair = Npole/2;

Iph = Pph/Vph;

f_syn = f_rated/Npole_pair
n_syn = f_syn *60


u0 = 4*pi*10e-7;
Bav = 0.5; %T

maxwell_stress_tensor = 0.5*(Bav^2)/u0;



%% Main Dimensions
% In this part, inner diameter and length of the machine will calculate. In
% order to achive this Cmech(machine constant) should be detected according 
%to calculated power per pole.
%%

P_per_pole = Prated/Npole;

fprintf('Power per pole is %g\n.',P_per_pole);

%%
%   ===>>>>>>>>>>>>>>>>>>>>>>>>>>>>Cmech grafiði koyulacak
%%

Cmech = 200;

%%
% Product of inner_diameter^2 and length of the motor can be calculated from 
% power and machine constant Cmech. 
% Pmech = Cmech*D^2*l'*nsync;
% Also, aspect ratio should be calculated for decide dimensions.
% Aspect ratio can be calculated following formula for asynchronous machines  
% x = pi*(pole_pair^(1/3))/(2*pole_pair), x = Di/L.
 
%%

D2L = P_rated/(Cmech* n_syn);

Aspect_Ratio= pi*(Npole_pair^(1/3))/(2*Npole_pair);

fprintf('Aspect ratio and di^2*L are %g\n, %g\n respectively ',D2L, Aspect_Ratio);

%%
% L_machine = Aspect_Ratio * D_machine
%%
%%
% Di^2*L is equal to the 1.66 and aspect ratio is 0.31. Also aspect ratio
% is equal to the  0.62. From previous parameters(D2L and aspect ratio),
% inner diameter and length of machine can be calculated.

% Moreover 
%%

M_inner_diameter = (D2L/Aspect_Ratio)^(1/3);
M_length = M_inner_diameter/Aspect_Ratio;

fprintf('Inner diameter is  %g\n m ',M_inner_diameter);

fprintf('Machine length is  %g\n m',M_length);

%% Airgap
%%
% After deciding main dimensions of the motor, airgap should be decided
% according to magnetical, electrical and mechanical properties. There is
% a trade-off between them. Acording to mechanical properties airgap shoul
% be maximize to rotate the machine smootly. Therefore, according to
% electromagnetical properties, it should be minimize to make power
% transfer more.

% Following figure shows that general airgap equations of asyncronuous machines

% ========>>>>>>>>>>>>>>>>>>>airgap formullerini ekle!!!!!!!!!!!!!!!!!!
%%
airgap = (0.18 + 0.006*P_rated^0.4)/1000;

fprintf('Airgap is  %g\n m ',airgap);

%% Winding Selection
%%
% In this part of the project, number of slots of rotor and stator and
% winding factors of higher harmonics are calculated.
%%



%%






















	
