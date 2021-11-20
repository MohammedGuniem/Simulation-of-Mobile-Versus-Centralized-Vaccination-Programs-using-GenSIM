% This file holds a series of methods that helps in making in scaling the
% implemented simulation of the Centeralized Vaccination Program.

%%Uncooment this section of code from line 3 to 19 to test the results of
%%methods in this file.
% clear all;
% clc;
% 
% num_of_staff = 2;
% num_of_health_workers = 4;
% num_of_waiting_rooms = 8;
% 
% global global_info;
% 
% global_info.time_between_visitors = 1;
% ft = construct_set('firing_times', num_of_staff, num_of_health_workers, num_of_waiting_rooms);
% 
% Ts = construct_set('transitions', num_of_staff, num_of_health_workers, num_of_waiting_rooms);
% 
% global_info.num_of_visitors_each_minute = 1;
% global_info.num_of_visitors_at_each_fire = 2;
% set_of_As = construct_set('arcs', num_of_staff, num_of_health_workers, num_of_waiting_rooms);


% A bundle method that can be used to dynamically construct:
% type = 'firing_times': The firing times of transitions 
% by calling the FT method down below.
% type = 'transitions': The set of transitions in the petri net of
% centralized vaccination by calling the TS method down below
% type = 'arcs': The set of arcs in the petri net of
% centralized vaccination by calling the AS method down below
function cell = construct_set(type, num_of_staff, num_of_health_workers, num_of_waiting_rooms)
    global global_info;
    
    if strcmp(type, 'firing_times')
        cell = FT(global_info.time_between_visitors,...
            num_of_staff, num_of_health_workers, num_of_waiting_rooms);
    elseif strcmp(type, 'transitions')
        cell = TS(num_of_staff, num_of_health_workers, num_of_waiting_rooms);
    elseif strcmp(type, 'arcs')
        cell = AS(global_info.num_of_visitors_at_each_fire,...
            num_of_staff, num_of_health_workers,num_of_waiting_rooms);
    end
end

function [ft] = FT(time_between_visitors, num_of_staff, num_of_health_workers, num_of_waiting_rooms)
    
    ft = cell(1, 0);
    
    ft{end+1} = 'tVISITOR';
    ft{end+1} = time_between_visitors;

    for s = 1:num_of_staff
        ft{end+1} = ['tREGISTRATION_',num2str(s)];
        ft{end+1} = 5*60;
    end

    for h = 1:num_of_health_workers
        ft{end+1} = ['tVACCINATION_',num2str(h)];
        ft{end+1} = 10*60;
    end

    for h = 1:num_of_waiting_rooms
        ft{end+1} = ['tWAITING_',num2str(h)];
        ft{end+1} = 30*60; 
    end

end

function [Ts] = TS(num_of_staff, num_of_health_workers, num_of_waiting_rooms)
    
    Ts = cell(1, 0);
    
    Ts{end+1} = 'tVISITOR';

    for s = 1:num_of_staff
        Ts{end+1} = ['tREGISTRATION_',num2str(s)];
    end

    for h = 1:num_of_health_workers
        Ts{end+1} = ['tVACCINATION_',num2str(h)];
    end

    for h = 1:num_of_waiting_rooms
        Ts{end+1} = ['tWAITING_',num2str(h)];
    end

end

function [set_of_As] = AS(num_of_visitors_at_each_fire, num_of_staff, num_of_health_workers, num_of_waiting_rooms)
    
    set_of_As = cell(1, 0);
    
    set_of_As{end+1} = 'tVISITOR';
    set_of_As{end+1} = 'p1';
    set_of_As{end+1} = num_of_visitors_at_each_fire;
    
    % to tREGISTRATION_*
    for s = 1:num_of_staff
       set_of_As{end+1} = 'p1';
       set_of_As{end+1} = ['tREGISTRATION_',num2str(s)];
       set_of_As{end+1} = 1;
    end
    
    % from tREGISTRATION_*
    for s = 1:num_of_staff
       set_of_As{end+1} = ['tREGISTRATION_',num2str(s)];
       set_of_As{end+1} = 'p2';
       set_of_As{end+1} = 1;
    end
    
    % to tVACCINATION_*
    for h = 1:num_of_health_workers
        set_of_As{end+1} = 'p2';
        set_of_As{end+1} = ['tVACCINATION_',num2str(h)];
        set_of_As{end+1} = 1;
        
        set_of_As{end+1} = 'p5';
        set_of_As{end+1} = ['tVACCINATION_',num2str(h)];
        set_of_As{end+1} = 1;
    end
    
    % from tVACCINATION_*
    for h = 1:num_of_health_workers
        set_of_As{end+1} = ['tVACCINATION_',num2str(h)];
        set_of_As{end+1} = 'p3';
        set_of_As{end+1} = 1;
    end

    % to tWAITING_*
    for h = 1:num_of_waiting_rooms
        set_of_As{end+1} = 'p3';
        set_of_As{end+1} = ['tWAITING_',num2str(h)];
        set_of_As{end+1} = 1;
    end
    
    % from tWAITING_*
    for h = 1:num_of_waiting_rooms
        set_of_As{end+1} = ['tWAITING_',num2str(h)];
        set_of_As{end+1} = 'p4';
        set_of_As{end+1} = 1;
    end
    
end