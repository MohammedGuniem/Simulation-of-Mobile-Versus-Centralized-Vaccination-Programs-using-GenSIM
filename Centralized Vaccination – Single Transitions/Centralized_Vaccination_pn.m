% MSF: Centeralized Vaccination Program

clear all;
clc;

global global_info
global_info.START_AT = [8 0 0]; % Start simulations at 8:00 AM
global_info.STOP_AT  = [16 00 0]; % Stop  simulations at 16:00
global_info.STOP_RECEIVING_VISITORS_AT = 15.5*60*60; % 15:30

global_info.number_of_visitors_each_minute = 1;
global_info.num_of_staff = 5;
global_info.num_of_health_workers = 10;
global_info.num_of_waiting_rooms = 30;

pns = pnstruct('Centralized_Vaccination_pn_pdf');

% initial tokens

%Change to 150000 to simulate full run of the 150 000 residents of
%Stavanger.
num_of_residents = 500;

% Assuming we have enough vaccines to everybody.
num_of_vaccines = num_of_residents;

dyn.m0 = {'p1',0, 'p2',0, 'p3',0, 'p4',0, 'p5',num_of_vaccines};
dyn.ft = construct('firing_times',...
    global_info.num_of_staff,...
    global_info.num_of_health_workers,...
    global_info.num_of_waiting_rooms...
);
dyn.re = {
    'Staff',global_info.num_of_staff,7.5*60*60,...
    'Health_Workers',global_info.num_of_health_workers,7.5*60*60,...
    'Waiting_Rooms',global_info.num_of_waiting_rooms,8*60*60
}; 

pni = initialdynamics(pns, dyn); 

sim = gpensim(pni); % perform simulation runs
prnss(sim);  % print the simulation results 
plotp(sim, {'p1','p2','p3','p4','p5'}); % plot the results 
%plotp(sim, {'p2','p3'});
%ylim([0 50]);
%cotree(pni, 1, 1) % reachability tree, text disp and graphical disp
%occupancy(sim, {'tREGISTRATION', 'tVACCINATION', 'tWAITING'});
%plotGC(sim); % plot the Gantt Chart
prnschedule(sim);