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

dyn.m0 = {'p1',0, 'p2',0, 'p3',0, 'p4',0, 'p5',num_of_vaccines};
dyn.ft = {
    'tVISITOR',15*60,...
    'tREGISTRATION_1',5*60,... 
    'tREGISTRATION_2',5*60,... 
    'tREGISTRATION_3',5*60,... 
    'tREGISTRATION_4',5*60,... 
    'tREGISTRATION_5',5*60,... 
    'tVACCINATION_1',10*60,...
    'tVACCINATION_2',10*60,...
    'tVACCINATION_3',10*60,...
    'tVACCINATION_4',10*60,...
    'tVACCINATION_5',10*60,...
    'tVACCINATION_6',10*60,...
    'tVACCINATION_7',10*60,...
    'tVACCINATION_8',10*60,...
    'tVACCINATION_9',10*60,...
    'tVACCINATION_10',10*60,...
    'tWAITING_1',30*60,...
    'tWAITING_2',30*60,...
    'tWAITING_3',30*60,...
    'tWAITING_4',30*60,...
    'tWAITING_5',30*60,...
    'tWAITING_6',30*60,...
    'tWAITING_7',30*60,...
    'tWAITING_8',30*60,...
    'tWAITING_9',30*60,...
    'tWAITING_10',30*60,...
};
dyn.re = {'Staff',5,7*60*60,'Health_Workers',10,7*60*60,'Waiting_Rooms',10,7*60*60}; 

pni = initialdynamics(pns, dyn); 

sim = gpensim(pni); % perform simulation runs
%prnss(sim);  % print the simulation results 
%plotp(sim, {'p1'})
plotp(sim, {'p1','p2','p3','p4','p5'}); % plot the results
%cotree(pni, 1, 1) % reachability tree, text disp and graphical disp

%occupancy(sim, {'tREGISTRATION', 'tVACCINATION', 'tWAITING'});
%plotGC(sim); % plot the Gantt Chart
prnschedule(sim);