% MSF: Decentralized Vaccination Program

clear all; 
clc;

global global_info
% Change the MAX_LOOP to 150*250 if you want to make a full run for the
% 150 000 residents of Stavanger.
global_info.MAX_LOOP = 150*225; % Stoping after several steps

pns = pnstruct('Decentralized_Vaccination_pn_pdf');

%Change to 150000 to simulate full run of the 150 000 residents of
%Stavanger.
num_of_residents = 150000

% Assuming we have enough vaccines to everybody.
num_of_vaccines = num_of_residents

% health workers who can visit and vaccinate residents.
num_of_health_workers = 15

% initial tokens
dyn.m0 = {'p1',num_of_residents, 'p2',num_of_health_workers, 'p3',0, 'p4',0, 'p5',num_of_vaccines, 'p6',0};
dyn.ft = {'tVISIT', 15, 'tVACCINATION',15*10};
dyn.re = {'Vehichles',15,inf}; 

pni = initialdynamics(pns, dyn);

sim = gpensim(pni); % perform simulation runs
prnss(sim);  % print the simulation results 
plotp(sim, {'p1','p2','p3','p4','p5','p6'}); % plot the results
%cotree(pni, 1, 1) % reachability tree, text disp and graphical disp
%prnschedule(sim);
occupancy(sim, {'tVISIT', 'tVACCINATION'});
plotGC(sim); % plot the Gantt Chart
