%% EE564 DESIGN OF ELECTRICAL MACHINES
% PROJECT 3 - TRACTION MOTOR DESIGN


%% INTRODUCTION
% In this project, traction asynchronous squirrel cage induction motor 
% (with copper rotor-bars) is designed. Then, designed motor will be analyzed 
% with FEM program. Specificitions of the generator as follows,

%%
% * Rated Power Output: 1280 kW
% * Line-to-line voltage: 1350 V
% * Number of poles: 6
% * Rated Speed: 1520 rpm (72 km/h) (driven with 78 Hz inverter)
% * Rated Motor Torque: 7843 Nm
% * Cooling: Forced Air Cooling
% * Insulating Class: 200C
% * Train Wheel Diameter: 1210 mm
% * Maximum Speed: 140 km/h
% * Gear Ratio: 4.82
% * Intended duty cycle :S1, direct on-line drive
% * 3 phase
%%
% Design steps at below will be followed at this design.
%%
% =================>>>>>>>>>>>>>>>>>>>>>>>> procedure koyulacak

%%
%
% %
%%

%% STARTING VALUES
% For this design, I aimed premium efficiency class because motor consumes
% high energy. It saturates %95.8 efficiency for high energy motors. Then, 
% target efficiency is chosen %96.
%=================>>>>>>>>>>>>>>>>>>>>>>>>>>verim standardý eklenecek



Prated = 1280e3; %W
Vline = 1350; %V
Npole = 6;
n_rated = 1520; %rpm
T_rated = 7843; %Nm
f_rated = 78; %Hz
v_rated = 74; %km/h
eff_des = 96; % %
Vph = Vline/sqrt(3);
Pph = Prated/3;

Iph = Pph/Vph;

u0 = 4*pi*e-7;
Bav = 0.5; %T

maxwell_stress_tensor = 0.5*(Bav^2)/u0;

























	
