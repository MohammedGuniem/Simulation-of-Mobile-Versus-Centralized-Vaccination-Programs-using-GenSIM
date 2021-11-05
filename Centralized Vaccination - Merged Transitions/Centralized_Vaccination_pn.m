% MSF: Centeralized Vaccination Program

clear all;
clc;

global global_info
global_info.START_AT = [8 0 0]; % Start simulations at 8:00 AM
global_info.STOP_AT  = [15 00 0]; % Stop  simulations at 15:00

pns = pnstruct('Centralized_Vaccination_pn_pdf');

% initial tokens

%Change to 150000 to simulate full run of the 150 000 residents of
%Stavanger.
num_of_residents = 500

% Assuming we have enough vaccines to everybody.
num_of_vaccines = num_of_residents

% dyn.m0 = {'p1',0, 'p2',0, 'p3',0, 'p4',0, 'p5',num_of_vaccines};
% dyn.ft = {'tVISITOR',1*60, 'tREGISTRATION',5*60, 'tVACCINATION',10*60, 'tWAITING',30*60};
% dyn.re = {'Staff',5,7*60*60,'Health_Workers',10,7*60*60,'Waiting_Rooms',10,7*60*60}; 

dyn.m0 = {'p1',0, 'p2',0, 'p3',0, 'p4',0, 'p5',num_of_vaccines};
dyn.ft = {'tVISITOR',15*60, 'tREGISTRATION',5*60, 'tVACCINATION',10*60, 'tWAITING',30*60};
dyn.re = {'Staff',5,7*60*60,'Health_Workers',10,7*60*60,'Waiting_Rooms',10,7*60*60};

pni = initialdynamics(pns, dyn); 

sim = gpensim(pni); % perform simulation runs
prnss(sim);  % print the simulation results 
plotp(sim, {'p2','p3'})
%plotp(sim, {'p1','p2','p3','p4','p5'}); % plot the results
%cotree(pni, 1, 1) % reachability tree, text disp and graphical disp

%occupancy(sim, {'tREGISTRATION', 'tVACCINATION', 'tWAITING'});
%plotGC(sim); % plot the Gantt Chart
prnschedule(sim);