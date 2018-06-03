clear all;
clc;

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
%=================>>>>>>>>>>>>>>>>>>>>>>>>>>verim standardý eklenecek

%%

P_rated = 250000; %W
Vline = 400; %V
Npole = 8;
n_rated = 758; %rpm
w_rated = n_rated/60*2*pi;
T_rated = P_rated/w_rated; %Nm
f_rated = 50; %Hz
target_eff = 0.96; % %
target_pf = 0.87;
Vph = Vline/sqrt(3);
Pph = P_rated/3;

Npole_pair = Npole/2;

Iph = Pph/(Vph*target_eff*target_pf);% A

f_syn = f_rated/Npole_pair; %hz
n_syn = f_syn *60; %rpm
w_syn = n_syn*2*pi/60; % rad/sec

Number_of_ph = 3;

u0 = 4*pi*10e-7;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Main Dimensions
% In this part, inner diameter and length of the machine will calculate. In
% order to achive this Cmech(machine constant) should be detected according 
%to calculated power per pole.
%%

P_per_pole = P_rated/Npole;

fprintf('Power per pole is %g W.\n',P_per_pole);

%%
%   ===>>>>>>>>>>>>>>>>>>>>>>>>>>>>Cmech grafiði koyulacak
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

fprintf('di^2*L is %g\n',D2L);
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

fprintf('Inner diameter is  %g m\n',M_inner_diameter);
fprintf('Outer diameter is  %g m\n',M_outer_diameter);


fprintf('Machine length is  %g m\n',M_length);

%%
% After decide the main dimensions, we should check it with tangential(shear)
% stress. It shold an interval which is specified folloing table.

%====================>>>>>>>>>>>>> shear stresi filan gösteren tabloyu
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
airgap = (0.18 + 0.006*P_rated^0.4);

fprintf('Airgap is  %g mm\n',airgap);

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


%=================================magnetic aralýðý ekle!!!!!!!!!!!!!
%%

Bg_av = 0.51; %T
Bg = 0.8;   %T 
Bs_yoke = 1.6;  %T
Bs_tooth = 1.9; %T
Br_yoke = 1.5;  %T
Br_tooth = 2.0;  %T

fprintf('Magnetic Loading is  %g T\n',Bg_av);
fprintf('Selected air gap flux density is  %g T\n',Bg);
fprintf('Selected stator yoke flux density is  %g T\n',Bs_yoke);
fprintf('Selected stator teeth flux density is  %g T\n',Bs_tooth);
fprintf('Selected rotor yoke flux density is  %g T\n',Br_yoke);
fprintf('Selected rotor teeth flux density is  %g T\n',Br_tooth);


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

fprintf('Number of stator slots are  %g\n',Qs);
fprintf('Number of rotor slots are  %g\n',Qr);

%%
% In order to eliminate 5th harmonics of the machine, it is prefered to
% design double layer winding with 7/9 pitch factor. 3rd harmonics are
% eliminated because of line to line connection of phases. 
%%
pitch_factor = 7/9;
slot_angle = pi*Npole/Qs;
pitch_angle = pitch_factor*pi;
pole_pitch = pi*M_inner_diameter/Npole;

Kd_1 = sin(qs*slot_angle/2)/(qs*sin(slot_angle/2));
Kp_1 = sin(pitch_angle/2);
Kw_1 = Kd_1*Kp_1;

Kd_5 = sin(5*qs*slot_angle/2)/(qs*sin(5*slot_angle/2));
Kp_5 = sin(5*pitch_angle/2);
Kw_5 = Kd_5*Kp_5;

Kd_7 = sin(7*qs*slot_angle/2)/(qs*sin(7*slot_angle/2));
Kp_7 = sin(7*pitch_angle/2);
Kw_7 = Kd_7*Kp_7;

Kd_11 = sin(11*qs*slot_angle/2)/(qs*sin(11*slot_angle/2));
Kp_11 = sin(11*pitch_angle/2);
Kw_11 = Kd_11*Kp_11;

fprintf('Winding factor of fundemental harmonic is  %g\n',Kw_1);
fprintf('Winding factor of 5th harmonic is  %g\n',Kw_5);
fprintf('Winding factor of 7th harmonic is  %g\n',Kw_7);
fprintf('Winding factor of 11th harmonic is  %g\n',Kw_11);


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

fprintf('Calculated number of turns per phase is  %g\n',Nph);
fprintf('Calculated number of turns per slot is  %g\n',Ns);

%%
% To make number of turns integer Ns is taken 3.
%%
Ns = 3;
Nph = Ns*(Npole_pair*qs);
fprintf('Number of turns per phase is  %g\n',Nph);
fprintf('Number of turns per slot is  %g\n',Ns);

%%
% Electrical loading is calculated as A = Ns*I*Qs/(pi*Di)
%%

A = Shear_stress/magnetic_loading; %kA/m

fprintf('Magnetic loading is  %g T\n',magnetic_loading);
fprintf('Electrical loading is  %g kA/m\n',A);


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

fprintf('Phase current is  %g kA\n',Iph);
fprintf('skin depth is  %g mm\n',skin_depth*1000);
fprintf('Needed copper area is  %g mm2\n',copper_area);

%%
% According to the skin depth value cable can have maximum 20mm diameter.
% Phase current is calculated as 432Arms so that  5 parallel AWG4 cable can
% be used. Because desired current density of AWG4 is about 6A/mm2. 

% =================>>>>>>>>>>>>>awg tablosus eklenecek
%%


awg4_cross_area = 21.1; %mm2
awg4_R_per_km = 0.081508; %ohm
cable_cross_area = 5*awg4_cross_area; %mm2
cable_R_per_km = awg4_R_per_km/5;  %@25 degree

%%
% I will make an approximation about copper length with following calculation. 
%%
one_turn_length = 2*M_length+2*M_inner_diameter; 
total_copper_length = one_turn_length*Qs*Ns; %m
ph_stator_copper_resistance = cable_R_per_km*total_copper_length/3/1000;

fprintf('Total copper length is %g km\n',total_copper_length);
fprintf('Copper resistance is  %g ohm\n',ph_stator_copper_resistance);

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

%% Stator Slot Dimensions
%%
% Teeth dimension will be calculated according to magnnetic flux densities.
% Moreover, slots will be design tapered type slots because I would like to
% make tooth width constant. 
% 



slot_pitch = pole_pitch/9;

fprintf('Pole pitch is  %g mm\n', pole_pitch*1000);
fprintf('Slot pitch is  %g mm\n', slot_pitch*1000);
fprintf('Needed slot area is %g mm2\n', total_slot_area);



%================>>>>>>>>>>>stator slot figuru !!!!!!!!!!!!!!!!!!!!!!!!!!!!

%%
% All flux of airgap could not flux through to teeth because there is a
% leakege and fringing fluxes. So that, when I calculate teeth width, ý
% will take %95 of flux passes.
%%

Kfe = 0.95;

b_ts= Bg_av*slot_pitch/(Kfe*Bs_tooth)*1000; %mm

fprintf('Stator slot tooth width (b_ts) is %g mm\n',b_ts);
%%
% I will select slot openning according to the cable diameter to make
% producing easier.
%%

b_os = 6; %mm
h_os = 2;
h_w = 2;


b_s1 = pi*(M_inner_diameter*1e3+2*h_os+2*h_w)/Qs-b_ts; % mm

fprintf('Stator slot opening width (b_os) is %g mm\n',b_os);
fprintf('Stator slot opening height (h_os) is %g mm\n',h_os);
fprintf('The bottom stator slot width (b_s1) is %g mm\n',b_s1);


b_s2 = sqrt(4*total_slot_area*tan(pi/Qs)+b_s1^2);

h_s = 2*total_slot_area/(b_s1+b_s2); % mm

fprintf('The top stator slot width (b_s2) is %g mm\n',b_s2);
fprintf('The useful stator slot height (hs) is %g mm\n',h_s);
%%
% Calculations are made by geometrical calculations. 
%%

h_cs = (1e3*M_outer_diameter-(1e3*M_inner_diameter+2*(h_os+h_w+h_s)))/2;

fprintf('The thickness of stator back iron(yoke) is (h_cs) is %g mm\n',h_cs);

%%
% Check the yoke magnetic flux density.
%%

B_cs = flux_per_pole/(2*M_length*h_cs*1e-3);

fprintf('Calculated Magnetic flux density at yoke is %g T\n',B_cs);
fprintf('Aimed Magnetic flux density at yoke is %g T\n',Bs_yoke);
%%
% This value is smaller from saturation value of the iron so that, in order
% to decrease mass and cost of the motor outer diameter could decrease.
% I will increase B_cs value sligtly.
%%

B_cs_aimed = 1.4; %T

h_cs_new = flux_per_pole/(2*M_length*B_cs_aimed*1e-3); % mm

M_outer_diameter_new = (2*h_cs_new+(1e3*M_inner_diameter+2*(h_os+h_w+h_s)))*1e-3; % m

fprintf('The decreased thickness of stator back iron(yoke) is (h_cs) is %g mm\n',h_cs_new);
fprintf('The decreased outer diameter is %g m\n',M_outer_diameter_new);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Rotor Bar Dimensions
%%
% Rotor slots will fill aliminum so that fill factor is 1. Also, I will
% choose shape of the rotor teeth according to easy producing. Stacking
% factor is taken same as stator.


%===================>>>>>>>>>>>>>rotor figuru eklenecek
%%

%%

% All equations are used in finding slot dimensions are 
% given following table.

%==================>>>>>>>>>>>>>> eq. tablosunu ekle

%%


fprintf('Number of slot at the rotor is %g \n',Qr);
Rotor_slot_pitch = pi*(1e3*M_inner_diameter-2*airgap)/Qr; % mm
fprintf('Rotor slot pitch is %g mm\n',Rotor_slot_pitch);

b_tr = (Bg_av*Rotor_slot_pitch)/(Br_tooth*Kfe); % mm

h_or = 2; %mm
b_or = 3; %mm

%%
% Rotor current should be calculated to calculate aliminum bar area. Chosen
% current density is decreased because of conductivity of the aliminum is
% smaller than copper. 
%%

J_rotor = 6; %A/mm2
KI = 0.8*target_pf +0.2;
I_rotor_bar = KI*2*Number_of_ph*Nph*Kw_1*Iph/Qr;
Rotor_al_area = I_rotor_bar/J_rotor;
I_rotor_ring = I_rotor_bar/(2*sin(2*pi/Qr)); % A
J_ring = 0.78*J_rotor; % A/mm^2
Rotor_ring_area = I_rotor_ring/J_ring; % mm^2

fprintf('Rotor slot current density is %g A/mm2\n',J_rotor);
fprintf('Rotor ring current density is %g A/mm2\n',J_ring);
fprintf('Rotor bar current is %g A\n',I_rotor_bar);
fprintf('Needed rotor aliminum area is %g mm2\n',Rotor_al_area);
fprintf('Rotor ring current is %g A\n',I_rotor_ring);
fprintf('Needen ring area is %g mm2\n',Rotor_ring_area);


%%
% Then, we need to calculate rotor other rotor dimensions by using given
% equation 14,15,16,17 and 18 at previous equation table.
%%

d_1 = (pi*(1e3*M_inner_diameter-2*airgap-2*h_or)-Qr*b_tr)/(pi+Qr); % mm

d_2 = 3; % mm
h_r = (d_1 - d_2)/(2*tan(pi/Qr)); % mm
rotor_slot_area = (pi/8)*(d_1^2+d_2^2)+(d_1+d_2)*h_r/2; % mm^2

h_cr = 1e3*flux_per_pole/(2*M_length*Br_yoke); % mm

Dshaftmax = M_inner_diameter*1e3-2*airgap-2*(h_or+h_r+h_cr+(d_1+d_2)/2); % mm
D_shaft = 100; % mm

fprintf('Tooth width of rotor slot (btr) is %g mm\n',b_tr);
fprintf('Opening width of rotor slot (bor) is %g mm\n',b_or);
fprintf('Opening height of rotor slot (hor) is %g mm\n',h_or);

fprintf('The top diameter of rotor bar (d1) is %g mm.\n',d_1);
fprintf('The bottom diameter of rotor bar (d2) %g mm.\n',d_2);
fprintf('The height of rotor bar (hr) %g mm.\n',h_r);
fprintf('Rotor slot area is %g mm^2.\n',rotor_slot_area);
fprintf('The height of the rotor back iron (hcr) is %g mm.\n',h_cr);
fprintf('Calculated maximum shaft diameter is %g mm.\n',Dshaftmax);
fprintf('Selected shaft diameter of rotor is %g mm.\n',D_shaft);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Effective Airgap
%%
% Flux density always decreases at the slot opening so that carter 
% coeffcient should be calculated and effective airgap distance estimate
% to calculate MMF and other dependent parameters. It
% will calculate after dimensions are decided.
%%

K_s = (b_os/(airgap))/(5+(b_os/airgap));
k_cs = slot_pitch*1000/(slot_pitch*1000-K_s*b_os);

K_r = (b_or/(airgap))/(5+(b_or/airgap));
k_cr = Rotor_slot_pitch*1000/(Rotor_slot_pitch*1000-K_r*b_os);


eff_airgap = k_cs*k_cr*airgap;
fprintf('Carters coefficient of stator is %g.\n',k_cs);
fprintf('Carters coefficient of rotor is %g.\n',k_cr);
fprintf('Effective airgap is %g mm.\n',eff_airgap);

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Thermal Calculations
%%
% Cooling ducts is added to keep cool the rotor. 
%* I will add 15 cooling ducts
%* Air-forced convection cooling method is using at this machine
%* Fan cooled machine
% According to researhed wind turbine datasheet, wind turbine machines are
% operating temprature between -40 to 85 degree.

%%

N_ducts = 15;
L_ducts = 5; %mm

k = (L_ducts/eff_airgap)/(5+L_ducts/eff_airgap);

eff_L_ducts = k*L_ducts;

eqv_M_length = M_length-1e-3*N_ducts*eff_L_ducts+1e-3*2*eff_airgap; % m

fprintf('Number of cooling ducts is %g.\n',N_ducts);
fprintf('Length of a cooling duct is %g mm.\n',L_ducts);
fprintf('The equivalent core length with cooling ducts is %g m.\n',eqv_M_length);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Inductances
%%
% In this part, leakege and magnetization inductances will be calculated. 
% Formulations are derived in class. I have used them. 
%
%%

Lm = (Number_of_ph/2)*M_inner_diameter*u0*eqv_M_length*(Kw_1*Nph)^2/(Npole_pair^2*eff_airgap*1e-3); % Henries
Xm = 2*pi*f_rated*Lm; % Ohms

P_stator = u0*eqv_M_length*((h_os/b_os)+(h_s/(3*b_s2))); % permeance
Lph = P_stator*4*(Nph*Kw_1)^2*Number_of_ph/Qs; % Henries
Xs_ph = 2*pi*f_rated*Lph; % ohms


%%
% In order to calculate rotor permeance, we have to calculate both bar and
% ring permeance.
%%

P_r1 = 0.66 + 2*h_r/(3*(d_1+d_2)) + h_or/b_or; % permeance
P_r2 = 0.9*Rotor_slot_pitch/(k_cs*eff_airgap)*1e-2; % permeance
Kx = 1; % skin effect coefficient
P_rotor = u0*eqv_M_length*(Kx*P_r1+P_r2); % permeance
Lrp = P_rotor*4*(Nph*Kw_1)^2*Number_of_ph/Qr; % Henries
Xrp = 2*pi*f_rated*Lrp; % ohms


Xph = Xs_ph+Xrp;


fprintf('The magnetizing inductance of the machine is %g mH.\n',Lm*1e3);
fprintf('The magnetizing reactance at 50Hz is %g Ohms.\n',Xm);
fprintf('leakage inductance of the stator is %g mH.\n',Lph*1e3);
fprintf('Leakage reactance of the stator at 50Hz is %g Ohms.\n',Xs_ph);
fprintf('Leakage inductance of the rotor referred to the stator side is %g mH.\n',Lrp*1e3);
fprintf('Leakage reactance of the rotor referred to the stator side is %g Ohms.\n',Xrp);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Resistances
%%
% Stator phase copper resistance is calculated previous part also. Also
% rotor resistance is calculated with rotor alimþnum dimensions.

%%


resistivity_al = 3.1*1e-8; % ohm*m %25 degree
Kr = 1.74;
Dre = M_inner_radius-1e-3*eff_airgap; % m
b = h_r+h_or+(d_1+d_2)/2; % mm
ler = 1e-3*pi*(Dre+b)/Qr; % m
Rbe = resistivity_al*((M_length*Kr/(rotor_slot_area*1e-6))+(ler/(2*Rotor_al_area*1e-6*(sin(3*pi/Qr))^2))); %ohms
R2p = Rbe*4*Number_of_ph/Qr*(Nph*Kw_1)^2; % ohms

R1p = ph_stator_copper_resistance;

Rph = R1p+R2p;

fprintf('Stator phase copper resistance is  %g ohm\n',R1p);
fprintf('Rotor phase resistance referred to stator side is  %g ohm\n',R2p);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Mass Calculation

cu_density = 8.96; % gr/cm^3
al_density = 2.70; % gr/cm^3
fe_density = 7800; % kg/m^3

%%
% Copper mass
%%
copper_volume = cable_cross_area/100*total_copper_length*100; %cm3
copper_mass = copper_volume*cu_density/1000; %kg

%%
% Aliminum mass, bar and ring 
%%

al_volume = Qr*(M_length*rotor_slot_area + ler* Rotor_al_area);%cm3
al_mass = al_volume*al_density/1000; %kg

%%
% Iron mass
%%
Stator_teeth_mass = fe_density*Qs*b_ts*1e-3*(h_s+h_w+h_os)*1e-3*M_length*Kfe; % kg
Stator_yoke_mass =  fe_density*pi/4*(M_outer_diameter_new^2-(M_outer_diameter_new-2*h_cs*1e-3)^2)* M_length*Kfe; % kg

Rotor_teeth_mass = fe_density*Qr*b_tr*1e-3*(h_r+(d_1+d_2)/2)*1e-3*M_length*Kfe; % kg

iron_mass = Stator_teeth_mass+Stator_yoke_mass+Rotor_teeth_mass;

%%
% I increased the shaft length %20;
%%
Shaft_mass = fe_density* pi/4*(D_shaft/1000)^2*M_length*1.2;


Total_mass = copper_mass+al_mass+iron_mass+Shaft_mass;

fprintf('Copper mass is  %g kg\n',copper_mass);
fprintf('Aliminum mass is  %g kg\n',al_mass);
fprintf('Iron mass is  %g kg\n',iron_mass);
fprintf('Shaft mass is  %g kg\n',Shaft_mass);
fprintf('Total mass is  %g kg\n',Total_mass);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Efficiency
%%
% In order to calculate efficiency, copper and core losses should be
% calculated.
%%

Pcu_s = 3*Iph^2*(R1p);
Pcu_r = 3*Iph^2*(R2p);
Pcu = Pcu_s + Pcu_r;

K_core = 3.3;
Pcore = iron_mass*K_core; 
%%
% Core loss resistance can be calculated for equavalent circuit.
%%
Rc = Vph^2/(Pcore/3);
fprintf('Core loss resistance(Rc) is %g ohm\n',Rc);

Ploss = Pcore+Pcu;

fprintf('Stator copper conduction loss is  %g W\n',Pcu_s);
fprintf('Rotor aliminum conduction loss is  %g W\n',Pcu_r);
fprintf('Total conduction loss is  %g W\n',Pcu);
fprintf('Total core loss is  %g W\n',Pcore);
fprintf('Total loss is  %g W\n',Ploss);

Efficiency = P_rated/(P_rated+Ploss);

fprintf('Efficiency is %g percent\n',Efficiency*100);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Characteristics

%%
%=============>>>>>>>>>>>>eq. circuit koyulacak
%%


%%
% Thevenin variables is calculated. 
%%
Zm = (1j*Xm*Rc)/(1j*Xm+Rc); % ohms
Z1 = Rph+1j*Xph; % ohms
Vth = Vph*Zm/(Z1+Zm); % volts
Zth = Z1*Zm/(Z1+Zm); % ohms
Rth = real(Zth); % ohms
Xth = imag(Zth); % ohms

s = -1:0.001:2;
s = fliplr(s);
Nr = n_syn*(1-s); % rpm
wr = Nr*2*pi/60; % rad/sec
num = numel(s);
Tm = (3*abs(Vth)^2/w_syn)*(1./ ( (Rth+R2p./s).^2 + (Xth+Xrp)^2 ) )...
    .*(R2p./s); % Nm

Tm((s==0)) = 0; % Nm
figure;
plot(Nr,Tm,'k-','LineWidth',2.0);
xlabel('Rotor speed (rpm)','Fontweight','Bold');
ylabel('Torque (Nm)','Fontweight','Bold');
title ('Induction Generator Torque-Speed Characteristic','Fontweight','Bold');
grid on;

figure;
plot(Nr,Tm,'k-','LineWidth',2.0);
xlabel('Rotor speed (rpm)','Fontweight','Bold');
ylabel('Torque (Nm)','Fontweight','Bold');
title ('Induction Generator Torque-Speed Characteristic','Fontweight','Bold');
grid on;
xlim([650 850]);


Rated_slip = (n_syn-n_rated)/n_syn;
fprintf('The rated slip is %g.\n',Rated_slip);
Starting_torque = Tm((s==1)); % Nm
Max_torque = max(Tm); % Nm
slip_max_torque = s((Tm==Max_torque));
fprintf('The starting torque of this machine is %d Nm.\n', Starting_torque);
fprintf('The maximum torque of this machine is %d Nm.\n', Max_torque);
fprintf('The slip at maximum torque is %d.\n', slip_max_torque);

































	
