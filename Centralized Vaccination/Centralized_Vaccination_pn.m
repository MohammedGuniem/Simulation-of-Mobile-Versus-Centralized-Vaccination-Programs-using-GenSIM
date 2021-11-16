% MSF: Centeralized Vaccination Program

clear all;
clc;

global global_info

% Starts the simulation at 8:00 AM
global_info.START_AT = [8 0 0]; 
% Stops the simulation at 16:00
global_info.STOP_AT  = [16 00 0];
% Reception is closed at 15:30
global_info.STOP_RECEIVING_VISITORS_AT = 15.5*60*60; 

% Determines the time between vistors.
global_info.time_between_visitors = 5*60;

% Sets how many visitors are arriving at the same time.
%global_info.num_of_visitors_at_each_fire = 1; %Example with simple minimum resources.
global_info.num_of_visitors_at_each_fire = 8; %Example with realistic resources.

% Number of staff at duty, staff are responsible for registration.
%global_info.num_of_staff = 1; %Example with simple minimum resources.
global_info.num_of_staff = 8; %Example with realistic resources.

% Number of health workers at duty, health workers handles the vaccination.
%global_info.num_of_health_workers = 2; %Example with simple minimum resources.
global_info.num_of_health_workers = 16; %Example with realistic resources.

% Number of available waiting rooms to be used 
% for observation after vaccination.
%global_info.num_of_waiting_rooms = 6; %Example with simple minimum resources.
global_info.num_of_waiting_rooms = 48; %Example with realistic resources.

% Here we set the number of vaccines doses available to be used,
% because we would like to assume we have enough vaccine doses to everyone
% and we know that the process of waiting for any abnormal reactions
% is the bottle neck and it is also the longest and last process.
% we can dynamically set this number to be equal to =
% The number of available waiting rooms 
% X 2(a waiting room can process 2 visitors each hour)
% X 8(the rooms are available 8 hours per day which is the length of this simulation)
num_of_vaccines = global_info.num_of_waiting_rooms*2*8; 

pns = pnstruct('Centralized_Vaccination_pn_pdf');

% Initial tokens
% The places in the topology of petri net for centralized vaccination
% No queuing algorithm is used, but random selection of visitors from
% the next firing transition.
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
% available (7.5 hours), each get a break of (0.5 hour) each day.
% Health workers who work with vaccination, 
% available (7.5 hours), each get a break of (0.5 hour) each day.
% Waiting rooms to be used for observation, 
% available to be occupied the entire day (Inf)
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
% Change the number "1" to the number of the transitions you are examining. 
%occupancy(sim, {'tREGISTRATION_1', 'tVACCINATION_1', 'tWAITING_1'});

% Uncomment to plot the Gantt chart of the occupancy of resources
%plotGC(sim); % plot the Gantt Chart

% Uncomment to print the schedualed resource use.
%prnschedule(sim);
