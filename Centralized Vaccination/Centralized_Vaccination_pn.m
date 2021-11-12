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

% Assuming we get a even distribution of 1 visitor per minute 
% from 8 am to 15:30
global_info.num_of_visitors_each_minute = 1; 

% Study Case includes 5 staff, 
% each available for 7,5 hours of work during the simulation
% since they have a 0.5 hours break in one work day.
global_info.num_of_staff = 5;

% Study Case includes 10 health works, 
% each available for 7,5 hours of work during the simulation
% since they have a 0.5 hours break in one work day.
global_info.num_of_health_workers = 10;

% Study Case includes 5 waiting rooms to be used 
% for observation after vaccination
global_info.num_of_waiting_rooms = 30;

pns = pnstruct('Centralized_Vaccination_pn_pdf');

% initial tokens

% Here we set the number of vaccines doses available to be used,
% Set this number very carefully to make sure 
% there is enough vaccines to everybody.
% This should equal the target number of visitors to process:
% If we are planning on receiving 1 visitor each minute for 7.5 hours,
% then we can are going to need 7.5*60 = 450 doses of vaccine.
num_of_vaccines = 450;

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

