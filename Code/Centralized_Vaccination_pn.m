% verstion - 1.0
% Centeralized Vaccination Program

clear all; 
clc;

global global_info
global_info.MAX_LOOP = 30000; % Stoping after several steps

% t1 = Registration
% t2 = Vaccine
% t3 = Wait
    
pns = pnstruct('Centralized_Vaccination_pn_pdf');

% initial tokens
dyn.m0 = {'p1',10000, 'p2',10, 'p4',10000, 'p5',10, 'p7',20};
dyn.ft = {'Registration',5, 'Vaccine',10, 'Wait',30};

pni = initialdynamics(pns, dyn); 

Sim_Results = gpensim(pni); % perform simulation runs
prnss(Sim_Results);  % print the simulation results 
plotp(Sim_Results, {'p1','p2','p3','p4','p5','p6','p7','p8'}); % plot the results
%cotree(pni, 1, 1) % reachability tree, text disp and graphical disp

