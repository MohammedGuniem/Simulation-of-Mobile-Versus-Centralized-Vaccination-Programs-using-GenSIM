% Petri net Definition File (PDF) for Centeralized Vaccination Program

function [png] = Centralized_Vaccination_pn_pdf()
png.PN_name = 'Centeralized Vaccination Program';

% The places in the topology of petri net for centralized vaccination
% No queuing algorithm is used, but random selection of visitors from
% the next transition.
% p1 = Place for visitors upon arrival before registration.
% p2 = Place for registered visitors waiting for vaccination.
% p3 = Place for vaccinated visitors waiting to access a waiting room.
% p4 = Place to fully approved and vaccinated visitors to be used for
% measurement of how many visitors the system is able to handle in one day.
% p5 = Place for vaccine doses to be used under vaccination.
png.set_of_Ps = {'p1','p2','p3','p4','p5'};

global global_info

% The set of transistions is generated dynamically using 
% the method "TS" in "contruct.m"
png.set_of_Ts = construct('transitions',...
    global_info.num_of_staff,...
    global_info.num_of_health_workers,...
    global_info.num_of_waiting_rooms...
);

% The set of arcs between 
% from/to transitions from/to places is generated dynamically using 
% the method "AS" in "contruct.m"
png.set_of_As = construct('arcs',...
    global_info.num_of_staff,...
    global_info.num_of_health_workers,...
    global_info.num_of_waiting_rooms...
);
end

