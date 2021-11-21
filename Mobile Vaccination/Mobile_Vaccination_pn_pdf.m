% Petri net Definition File (PDF) for Mobile Vaccination Program

function [png] = Mobile_Vaccination_pn_pdf()
    png.PN_name = 'Mobile Vaccination Program';
    
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
    png.set_of_Ps = {'p1','p2','p3','p4','p5','p6','p7','p8'};
    
    global global_info
    
    % The set of transistions is generated dynamically using 
    % the method "TS" in "contruct.m"
    png.set_of_Ts = construct('transitions', global_info.num_of_health_workers);
    
    % The set of arcs between 
    % from/to transitions from/to places is generated dynamically using 
    % the method "AS" in "contruct.m"
    png.set_of_As = construct('arcs', global_info.num_of_health_workers);
    
end