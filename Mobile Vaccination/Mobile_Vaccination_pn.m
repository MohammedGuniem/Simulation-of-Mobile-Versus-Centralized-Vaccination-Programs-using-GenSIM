% MSF: Mobile Vaccination Program

clear all; 
clc;

global global_info

% Start simulations at 8:00 AM
global_info.START_AT = [8 0 0]; 

% Stop  simulations at 16:00
global_info.STOP_AT  = [16 0 0];

% Number of health workers at duty
global_info.num_of_health_workers = 16;

% The number of available vaccination busses with their drivers.
global_info.num_of_busses = 16;

% The total number of residents in the city 
% or inside the area of study case.
global_info.num_of_residents = 2500; %141000 in Stavanger

% The number of streets to be visited inside a city
% or the area of a study case.
global_info.num_of_streets = 100; %5552 in Stavanger

% assuming all streets have the same number of residents.
% set to be the average number of residents between all streets.
% make sure this evaluate to an integer.
global_info.residents_per_street = 25; %10 in each steet.

% Assuming we have enough vaccines to everybody.
global_info.num_of_vaccines = global_info.num_of_residents;

pns = pnstruct('Mobile_Vaccination_pn_pdf');

% initial tokens
dyn.m0 = {
    'p1',global_info.num_of_health_workers,...
    'p2',global_info.num_of_streets,...
    'p3',global_info.num_of_busses,...
    'p4',0,...
    'p5',0,...
    'p6',global_info.num_of_vaccines,...
    'p7',0,...
    'p8',0
};
dyn.ft = construct("firing_times", global_info.num_of_health_workers);

% Initializes the GPenSIM simulation
pni = initialdynamics(pns, dyn); 

% Performs the GPenSIM simulation
sim = gpensim(pni);

% Prints the simulation results 
prnss(sim);

% Plots the results 
%plotp(sim, {'p1','p2','p3','p4','p5','p6','p7','p8'});
plotp(sim, {'p7', 'p8'});

% Uncomment to Print the reachability tree, text disp and graphical disp
%cotree(pni, 1, 1) 

% Final Current State: 57p2 + 2p4 + 345p5 + 1795p6 + 17p7 + 675p8