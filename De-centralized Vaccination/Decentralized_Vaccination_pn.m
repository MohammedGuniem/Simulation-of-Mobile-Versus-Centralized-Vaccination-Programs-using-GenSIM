% verstion - 1.0
% Decenteralized Vaccination Program

clear all; 
clc;

global global_info
global_info.MAX_LOOP = 3000; % Stoping after several steps

% t1 = Visit
% t2 = Vaccine
% t3 = Done

pns = pnstruct('Decentralized_Vaccination_pn_pdf');

% initial tokens
dyn.m0 = {'p1',1000, 'p2',15, 'p3',2, 'p4',1000};
dyn.ft = {'visit', 10, 'vaccine',15};

pni = initialdynamics(pns, dyn);

Sim_Results = gpensim(pni); % perform simulation runs
prnss(Sim_Results);  % print the simulation results 
plotp(Sim_Results, {'p1','p2','p3','p4','p5','p6','p7'}); % plot the results
%cotree(pni, 1, 1) % reachability tree, text disp and graphical disp
