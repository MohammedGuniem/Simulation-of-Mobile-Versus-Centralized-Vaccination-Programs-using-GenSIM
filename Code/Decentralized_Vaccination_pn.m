% verstion - 1.0
% Decenteralized Vaccination Program

clear all; 
clc;

global global_info
global_info.MAX_LOOP = 10000; % Stoping after several steps

% t1 = Visit
% t2 = Vaccine
% t3 = Done

%global_info.STOP_AT = 105;
%global_info.STOP_AT = current_clock(3) + [0 0 15];
%global_info.REAL_TIME = 1; %real time run
% all times are in minuttes or we can use the computer(real time) clock, as
% follows: global_info.REAL_TIME = 1
% ('allothers', number) can be used to refer for many with commen firetime
%dyn.ft = {'Registration', 1, 'allothers', 1}

pns = pnstruct('Decentralized_Vaccination_pn_pdf');

% initial tokens
dyn.m0 = {'p1',150, 'p2',15, 'p3',2, 'p4',150};
dyn.ft = {'visit', 10, 'vaccine',15};

pni = initialdynamics(pns, dyn);

Sim_Results = gpensim(pni); % perform simulation runs
prnss(Sim_Results);  % print the simulation results 
plotp(Sim_Results, {'p1','p2','p3','p4','p5','p6','p7'}); % plot the results
%cotree(pni, 1, 1) % reachability tree, text disp and graphical disp
