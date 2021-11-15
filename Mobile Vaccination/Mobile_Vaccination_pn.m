% MSF: Mobile Vaccination Program

clear all; 
clc;

global global_info

% Start simulations at 8:00 AM
global_info.START_AT = [8 0 0]; 

% Stop  simulations at 16:00
global_info.STOP_AT  = [16 00 0];

% Number of health workers at duty
global_info.num_of_health_workers = 20;

% The number of available vaccination busses.
num_of_busses = 10; %5 in Stavanger

% The total number of residents in the city 
% or inside the area of study case.
num_of_residents = 500; %141000 in Stavanger

% The number of streets to be visited inside a city
% or the area of a study case.
num_of_streets = 20; %5552 in Stavanger

% assuming all streets have the same number of residents.
% set to be the average number of residents between all streets.
% make sure this evaluate to an integer.
global_info.residents_per_street = num_of_residents/num_of_streets;

pns = pnstruct('Mobile_Vaccination_pn_pdf');

% Assuming we have enough vaccines to everybody.
num_of_vaccines = num_of_residents;

% initial tokens
dyn.m0 = {
    'p1',global_info.num_of_health_workers,...
    'p2',num_of_streets,...
    'p3',num_of_busses,...
    'p4',0,...
    'p5',0,...
    'p6',num_of_vaccines,...
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
plotp(sim, {'p8'});

% Uncomment to Print the reachability tree, text disp and graphical disp
%cotree(pni, 1, 1) 