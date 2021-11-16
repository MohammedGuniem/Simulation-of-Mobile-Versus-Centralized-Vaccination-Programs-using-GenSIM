% MSF: Centeralized Vaccination Program

clear all;
clc;

global global_info

% Start simulations at 8:00 AM
global_info.START_AT = [8 0 0]; 

% Stop  simulations at 16:00
global_info.STOP_AT  = [16 00 0];

% Reception is closed at 15:30
global_info.STOP_RECEIVING_VISITORS_AT = 15.5*60*60; 

% Assuming we get an even distribution of 1 visitor per minute 
% from 8 am to 15:30
global_info.time_between_visitors = 1*60; %1*60;
global_info.num_of_visitors_at_each_fire = 2; 

% Number of health staff at duty.
global_info.num_of_staff = 8; %5;

% Number of health workers at duty.
global_info.num_of_health_workers = 16; %10;

% Number of available waiting rooms to be used 
% for observation after vaccination.
global_info.num_of_waiting_rooms = 48; %30;

pns = pnstruct('Centralized_Vaccination_pn_pdf');

% initial tokens

% Here we set the number of vaccines doses available to be used,
% because we would like to assume we have enough vaccine doses to everyone
% and we know that the process of waiting for any abnormal reactions
% is the bottle neck and it is also the longest and last process.
% we can dynamically set this number to be equal to =
% The number of available waiting rooms 
% X 2(a waiting room can process 2 visitors each hour)
% X 8(the rooms are available 8 hours per day which is the length of this simulation)
% for 6 rooms we get 96 doses of vaccines.
num_of_vaccines = global_info.num_of_waiting_rooms*2*8; 

% The places in the topology of petri net for centralized vaccination
% No queuing algorithm is used, but random selection of visitors from
% the next transition.
% p1 = Place for visitors upon arrival before registration.
% p2 = Place for registered visitors waiting for vaccination.
% p3 = Place for vaccinated visitors waiting to access a waiting room.
% p4 = Place to fully approved and vaccinated visitors to be used for
% measurement of how many visitors the system is able to handle in one day.
% p5 = Place for vaccine doses to be used under vaccination.
dyn.m0 = {'p1',0, 'p2',0, 'p3',0, 'p4',0, 'p5',num_of_vaccines};

% The firing times are
% 5 minutes under registration transitions.
% 10 minutes under vaccination transitions.
% 30 minutes for waiting transitions.
% This is constructed dynamically using the method "FT" in "contruct.m"
dyn.ft = construct('firing_times',...
    global_info.num_of_staff,...
    global_info.num_of_health_workers,...
    global_info.num_of_waiting_rooms...
);

% The resources are
% Staff who works with registration, 
% available (7.5 hours), break (0.5 hour)
% Health workers who works with vaccination, 
% available (7.5 hours), break (0.5 hour)
% waiting rooms to be used for observation., 
% available the entire day (Inf), no break
dyn.re = {
    'Staff',global_info.num_of_staff,7.5*60*60,...
    'Health_Workers',global_info.num_of_health_workers,7.5*60*60,...
    'Waiting_Rooms',global_info.num_of_waiting_rooms,Inf
}; 

% Initializes the GPenSIM simulation
pni = initialdynamics(pns, dyn); 

% Performs the GPenSIM simulation
sim = gpensim(pni);

% Prints the simulation results 
prnss(sim);

% Plots the results 
plotp(sim, {'p1','p2','p3','p4','p5'});

% Uncomment to Print the reachability tree, text disp and graphical disp
%cotree(pni, 1, 1) 

% Uncomment to view the occupancy of resources by transistions
%occupancy(sim, {'tREGISTRATION', 'tVACCINATION', 'tWAITING'});

% Uncomment to plot the Gantt chart of the occupancy of resources
%plotGC(sim); % plot the Gantt Chart

% Uncomment to print the schedualed resource use.
%prnschedule(sim);

% Final Current State: 180p1 + 696p4 + 48p5
