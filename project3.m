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

%% Starting Values
% For this design, I aimed premium efficiency class because motor consumes
% high energy. It saturates %95.8 efficiency for high energy motors. Then, 
% target efficiency is chosen %96.
%=================>>>>>>>>>>>>>>>>>>>>>>>>>>verim standard� eklenecek

%%

P_rated = 250e3; %W
Vline = 400; %V
Npole = 8;
n_rated = 758; %rpm
w_rated = n_rated/60*2*pi;
T_rated = P_rated/w_rated; %Nm
f_rated = 50; %Hz
target_eff = 96; % %
target_pf = 0.87;
Vph = Vline/sqrt(3);
Pph = Prated/3;

Npole_pair = Npole/2;

Iph = Pph/(Vph*target_eff*target_pf);

f_syn = f_rated/Npole_pair
n_syn = f_syn *60

Number_of_ph = 3;

u0 = 4*pi*10e-7;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Main Dimensions
% In this part, inner diameter and length of the machine will calculate. In
% order to achive this Cmech(machine constant) should be detected according 
%to calculated power per pole.
%%

P_per_pole = Prated/Npole;

fprintf('Power per pole is %g\n.',P_per_pole);

%%
%   ===>>>>>>>>>>>>>>>>>>>>>>>>>>>>Cmech grafi�i koyulacak
%%

Cmech = 200000;

%%
% Product of inner_diameter^2 and length of the motor can be calculated from 
% power and machine constant Cmech. 
% Pmech = Cmech*D^2*l'*nsync;
% Also, aspect ratio should be calculated for decide dimensions.
% Aspect ratio can be calculated following formula for asynchronous machines  
% x = pi*(pole_pair^(1/3))/(2*pole_pair), x = Di/L.
 
%%

D2L = P_rated/(Cmech* f_syn);

Aspect_Ratio= pi*(Npole_pair^(1/3))/(2*Npole_pair);

fprintf('di^2*L is %g\n ',D2L);
fprintf('Aspect ratio is %g\n', Aspect_Ratio);
%%
% L_machine = Aspect_Ratio * D_machine
%%
%%
% Di^2*L is equal to the 1.66 and aspect ratio is 0.31. Also aspect ratio
% is equal to the  0.62. From previous parameters(D2L and aspect ratio),
% inner diameter and length of machine can be calculated.

% Moreover, outer diameter is calculated according to following table, which
% is generalized the outer diameter towards to the number of pole. Outer diameter
% coefficiend is decreasing when number of pole increase because magnetic
% flux density at the yoke decrease propotionally.

%=================================> Do tablosunu ekle !!!!!!!!!!!!!!!!!!!


%%

M_inner_diameter = (D2L/Aspect_Ratio)^(1/3);
M_length = M_inner_diameter*Aspect_Ratio;
M_outer_diameter = 1.66*M_inner_diameter;

fprintf('Inner diameter is  %g\n ',M_inner_diameter);
fprintf('Outer diameter is  %g\n ',M_outer_diameter);


fprintf('Machine length is  %g\n',M_length);

%%
% After decide the main dimensions, we should check it with tangential(shear)
% stress. It shold an interval which is specified folloing table.

%====================>>>>>>>>>>>>> shear stresi filan g�steren tabloyu
%ekle!!!!!!!!!!!!!!!!!!!!
%%

M_inner_radius = M_inner_diameter/2;
F_tan = T_rated/M_inner_radius;
M_surface_area = M_inner_diameter*pi*M_length;


Shear_stress = F_tan/M_surface_area/1000; %Kpa

fprintf('Shear stress is  %g\n',Shear_stress);

%%
% Shear stress value is appropriate. So, dimensions are checked.
%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

fprintf('Airgap is  %g\n ',airgap);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Magnetic Parameters
%%
% Magnetic loading is specified previous part, which is equal to the 0.51T
% specified at below. Calculation details are made at the Project-2. Therefore,
% for this design, we do not know teeth dimensions yet, so that we have to
% decide either magnetic paramters or teeth dimensions, then calculate
% other one. At previous project, we selected lamination first, then made a
% design. But, at this project, I would like to experience other way so
% that, I will specify magnetic parameters at desired intervals which is shown
% at following figure from textbook.


%=================================magnetic aral��� ekle!!!!!!!!!!!!!
%%

Bg_av = 0.51; %T
Bg = 0.8;   %T 
Bs_yoke = 1.6;  %T
Bs_tooth = 1.9; %T
Br_yoke = 1.5;  %T
Br_tooth = 2.0;  %T

fprintf('Magnetic Loading is  %g\n T\n ',Bg_av);
fprintf('Selected air gap flux density is  %g T\n ',Bg);
fprintf('Selected stator yoke flux density is  %g T\n',Bs_yoke);
fprintf('Selected stator teeth flux density is  %g T\n',Bs_tooth);
fprintf('Selected rotor yoke flux density is  %g T\n ',Br_yoke);
fprintf('Selected rotor teeth flux density is  %g T\n ',Br_tooth);


%%





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Electrical Parameters and Winding Selection
%%
% In this part of the project, number of slots of rotor and stator and
% winding factors of higher harmonics are calculated.
% For high pole machine, it is prefered to have Qr = Qs*1.2. In order to
% prevent cogging problem number of rotor and stator should be different
% and some combinations of these shold be avoided as Qs = 2Qr, Qr = Qs +-2p,
% etc. Moreover, if Qr = 6pg +-2p+-1, g is an integer, mechanical noise and
% vibrations could be observed.

% Number of slots per pole per phase is decided 3.
%%
qs = 3;
Qs = qs*Number_of_ph*Npole;

%%
% Qr = 1.2*Qs is nearly 86 and in general design, Qs/Qr = 72/88 is used.
%%

Qr = 88;

fprintf('Number of stator slots are  %g\n  ',Qs);
fprintf('Number of rotor slots are  %g\n  ',Qr);

%%
% In order to eliminate 5th harmonics of the machine, it is prefered to
% design double layer winding with 7/9 pitch factor.
%%
pitch_factor = 7/9;
slot_angle = pi*Npole/Qs;
pitch_angle = pitch_factor*pi;
pole_pitch = pi*M_inner_diameter/Npole;

Kd_1 = sin(qs*slot_angle/2)/(qs*sin(slot_angle/2));
Kp_1 = sin(pitch_angle/2);
Kw_1 = Kd_1*Kp_1;

Kd_3 = sin(3*qs*slot_angle/2)/(qs*sin(3*slot_angle/2));
Kp_3 = sin(3*pitch_angle/2);
Kw_3 = Kd_3*Kp_3;

Kd_5 = sin(5*qs*slot_angle/2)/(qs*sin(5*slot_angle/2));
Kp_5 = sin(5*pitch_angle/2);
Kw_5 = Kd_5*Kp_5;

Kd_7 = sin(7*qs*slot_angle/2)/(qs*sin(7*slot_angle/2));
Kp_7 = sin(7*pitch_angle/2);
Kw_7 = Kd_7*Kp_7;

fprintf('Winding factor of fundemental harmonic is  %g\n  ',Kw_1);
fprintf('Winding factor of 3rd harmonic is  %g\n  ',Kw_3);
fprintf('Winding factor of 5th harmonic is  %g\n  ',Kw_5);
fprintf('Winding factor of 7th harmonic is  %g\n  ',Kw_7);


%%
% Nunber of turns can be calculated induced emf formula. Induced emf is near
% to the phase voltage.

% At the project-2, deciding airgap average flux density is explained so 
% that I have chosen peak of airgap magnetic flux density 0.8T, magnetic
% loading is nearly 0.51T.

%% 

Bg_av = 0.51;
magnetic_loading = 0.51;

Ind_emf = Vph;

flux_per_pole = Bg_av*pole_pitch*M_length;
Nph = Ind_emf/(4.44*f_rated*flux_per_pole*Kw_1);

Ns = Nph/(Npole_pair*qs);

fprintf('Calculated number of turns per phase is  %g\n  ',Nph);
fprintf('Calculated number of turns per slot is  %g\n  ',Ns);

%%
% To make number of turns integer Ns is taken 3.
%%
Ns = 3;
Nph = Ns*(Npole_pair*qs);
fprintf('Number of turns per phase is  %g\n  ',Nph);
fprintf('Number of turns per slot is  %g\n  ',Ns);

%%
% Electrical loading is calculated as A = Ns*I*Qs/(pi*Di)
%%

A = Shear_stress/magnetic_loading; %kA/m

fprintf('Magnetic loading is  %g T\n  ',magnetic_loading);
fprintf('Electrical loading is  %g kA/m\n  ',A);


%%
% Electrical loading value is appropriate according to floowing figure from
% textbook.

% =========================elec_loading eklenecek!!!!!!!!!!!!!!!!!!!!!!!


%%
% In general, 7A/mm2 current densitiy is used for 8 pole air cooling 
% machines. Also skin depth should be considered at maximum frequency. 

%%
cu_resistivity = 1.7e-8; % Ohm*m
cu_permeability = 1.26e-6; % H/m
f_max = f_rated;
angular_frequency = 2*pi*f_max; % rad/sec
skin_depth = sqrt(cu_resistivity*2/(angular_frequency*cu_permeability));
copper_area = Iph/7;

fprintf('Phase current is  %g kA\n  ',Iph);
fprintf('skin depth is  %g mm\n  ',skin_depth*1000);
fprintf('Needed copper area is  %g mm2\n  ',copper_area);

%%
% According to the skin depth value cable can have maximum 20mm diameter.
% Phase current is calculated as 432Arms so that  5 parallel AWG4 cable can
% be used. Because desired current density of AWG4 is about 6A/mm2. 

% =================>>>>>>>>>>>>>awg tablosus eklenecek
%%


awg4_cross_area = 21.1; %mm2
awg4_R_per_km = 0.081508; %ohm
cable_cross_area = 5*awg4_cross_area;
cable_R_per_km = awg4_R_per_km/5; 

%%
% I will make an approximation about copper length with following calculation. 
%%
one_turn_length = 2*M_length+2*M_inner_diameter/Npole_pair; 
total_copper_length = one_turn_length*Qs*Ns/1000;
copper_resistance = cable_R_per_km*total_copper_length;
fprintf('Copper resistance is  %g ohm\n  ',copper_resistance);

%%
% At high power motors, fill factor is important because heating and 
% insulation are effected to it. In general, this kind of application %50
% fill factor is applicable. 

%%
fill_factor = 0.5;
total_slot_area = 6*cable_cross_area/fill_factor; %mm^2

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% New Airgap Magnetic Flux Density and Depended Parameters
%%
% Because of choosing higher turn number than calculated value length,
% radius and airgap flux density will decrease.
%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Teeth Dimensions
%%
% Teeth dimension will be calculated according to magnnetic flux densities.
% Moreover, slots will be design tapered type slots because I would like to
% make tooth width constant. Also, flux density always decreases at the
% slot opening so that carter coeffcient should be calculated and airgap
% distance estimate to calculate MMF and other dependent parameters.
% 
%%

slot_pitch = pole_pitch/9;

fprintf('Pole pitch is  %g m\n  ', pole_pitch);
fprintf('Slot pitch is  %g m\n  ', slot_pitch);
fprintf('Needed slot area is %g mm2\n  ', total_slot_area);



%================>>>>>>>>>>>stator slot figuru !!!!!!!!!!!!!!!!!!!!!!!!!!!!

%%
% All flux of airgap could not flux through to teeth because there is a
% leakege and fringing fluxes. So that, when I calculate teeth width, �
% will take %95 of flux passes.
%%

Kfe = 0.95;

b_ts= Bg_av*slot_pitch/(Kfe*Bs_tooth);




%%







%%





















	
