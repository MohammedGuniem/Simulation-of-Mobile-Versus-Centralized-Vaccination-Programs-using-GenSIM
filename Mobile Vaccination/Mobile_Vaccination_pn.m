% Main Simulation File (MSF) for Mobile Vaccination Program

clear all; 
clc;

global global_info

% Starts the simulation at 8:00 AM
global_info.START_AT = [8 0 0]; 
% Stops the simulation at 16:00
global_info.STOP_AT  = [16 0 0];

% Gives the simulation a name, so it can be used in the resulted plots.
%global_info.simulation_name = "Simple Simulation"; %Example with simple minimum resources.
global_info.simulation_name = "Realistic Simulation"; %Example with simple minimum resources.

% Set the number of available health workers at duty, 
% health workers handles the vaccination.
%global_info.num_of_health_workers = 2; %Example with simple minimum resources.
global_info.num_of_health_workers = 14; %Example with realistic resources.

% Set the number of available vaccination busses with their drivers.
%global_info.num_of_busses = 2; %Example with minimum simple resources.
global_info.num_of_busses = 14; %Example with realistic resources.

% Assuming all streets have the same number of residents.
% which is set to be the average number of residents between all streets.
% make sure this is an integer.
%global_info.residents_per_street = 20; % Simple Example: 20 residents on each street.
global_info.residents_per_street = 73; % Example: ~70 residents on each street in Stavanger.

% Sets the number of streets to be visited inside a city
% or the area of the simulation.
global_info.num_of_streets = 100; % Example: 2021 unique streets in Stavanger

% Sets the number of residents to be vaccinated during the simulation.
% Example: 141000 residents in Stavanger
global_info.num_of_residents = global_info.num_of_streets*global_info.residents_per_street;

% Assuming we have enough vaccines to everybody, 
% we set the number of vaccine doses to equal the number of residents.
global_info.num_of_vaccines = global_info.num_of_residents;

pns = pnstruct('Mobile_Vaccination_pn_pdf');

% Initial tokens
% The places in the topology of petri net for mobile vaccination
% No queuing algorithm is used, but random selection of residents from
% the next firing transition.
% p1 = Place for available health workers at duty.
% p2 = Place for the streets to visit during the simulation.
% p3 = Place for available vaccination buses at duty, with their drivers.
% p4 = Place for health workers at a street, where the vaccination is
% performed
% p5 = Place for residents in a street.
% p6 = Place for available vaccine doses.
% p7 = Place for vaccinated residents before the health workers would have 
% finished vaccinating all residents in the street.
% p8 = Place for vaccinated residents after the health workers have 
% finished vaccinating the entire street.
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

% The firing times are
% 15 minutes under dispatch transitions.
% 10 minutes under vaccination transitions.
% 1 minutes for completion transitions.
% This is constructed dynamically using the method "FT" in "contruct.m"
dyn.ft = construct("firing_times", global_info.num_of_health_workers);

% Initializes the GPenSIM simulation
pni = initialdynamics(pns, dyn); 

% Performs the GPenSIM simulation
sim = gpensim(pni);

% Prints the simulation results 
prnss(sim);

% Plots the results 
plotp(sim, {'p1','p2','p3','p4','p5','p7','p8'}); % removing vaccine place p6 to make the plot more readable.
title(global_info.simulation_name, ['Using ', num2str(global_info.num_of_busses), ' busses with their drivers & ', num2str(global_info.num_of_health_workers), ' Health Workers & ', num2str(global_info.residents_per_street), ' Residents per Street'])

% Uncomment to Print the reachability tree, text disp and graphical disp
%cotree(pni, 1, 1) 