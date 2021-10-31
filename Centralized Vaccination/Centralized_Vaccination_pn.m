% MSF: Centeralized Vaccination Program

clear all; 
clc;

global global_info

% Change the MAX_LOOP to 150*1000 if you want to make a full run for the
% 150 000 residents of Stavanger.
global_info.MAX_LOOP = 1000; % Stoping after several steps
    
pns = pnstruct('Centralized_Vaccination_pn_pdf');

% initial tokens

%Change to 150000 to simulate full run of the 150 000 residents of
%Stavanger.
num_of_residents = 900

% Assuming we have enough vaccines to everybody.
num_of_vaccines = num_of_residents

dyn.m0 = {'p1',num_of_residents, 'p2',0, 'p3',0, 'p4',0, 'p5',num_of_vaccines};
dyn.ft = {'tREGISTRATION',5, 'tVACCINATION',10, 'tWAITING',30};
dyn.re = {'Staff',15,inf,'Health_Workers',15,inf,'Waiting_Rooms',30,inf}; 

pni = initialdynamics(pns, dyn); 

sim = gpensim(pni); % perform simulation runs
prnss(sim);  % print the simulation results 
plotp(sim, {'p1','p2','p3','p4','p5'}); % plot the results
%cotree(pni, 1, 1) % reachability tree, text disp and graphical disp
%prnschedule(sim);
occupancy(sim, {'tREGISTRATION', 'tVACCINATION', 'tWAITING'});
plotGC(sim); % plot the Gantt Chart

