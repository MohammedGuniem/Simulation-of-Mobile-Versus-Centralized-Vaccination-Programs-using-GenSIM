%%Uncooment this section of code from line 3 to 14 to test the results of
%%methods in this file.
% clear all;
% clc;
% 
% num_of_staff = 2;
% num_of_health_workers = 4;
% num_of_waiting_rooms = 8;
% 
% ft = construct_set('firing_times', num_of_staff, num_of_health_workers, num_of_waiting_rooms);
% Ts = construct_set('transitions', num_of_staff, num_of_health_workers, num_of_waiting_rooms);
% global global_info
% global_info.num_of_visitors_each_minute = 1;
% set_of_As = construct_set('arcs', num_of_staff, num_of_health_workers, num_of_waiting_rooms);

% A bundle method that can be used to dynamically construct:
% type = 'firing_times': The firing times of transitions 
% by calling the FT method down below
% type = 'transitions': The set of transitions in the petri net of
% centralized vaccination by calling the TS method down below
% type = 'arcs': The set of arcs in the petri net of
% centralized vaccination by calling the AS method down below
function cell = construct(type, num_of_health_workers)
    if strcmp(type, 'firing_times')
        cell = FT(num_of_health_workers);
    elseif strcmp(type, 'transitions')
        cell = TS(num_of_health_workers);
    elseif strcmp(type, 'arcs')
        cell = AS(num_of_health_workers);
    end
end

function [ft] = FT(num_of_health_workers)
    ft = cell(1, 0);
    
    for h = 1:(num_of_health_workers/2)
        ft{end+1} = ['tDRIVE_',num2str(h)];
        ft{end+1} = 5*60;
        ft{end+1} = ['tVACCINATION_',num2str(h)];
        ft{end+1} = 10*60;
        ft{end+1} = ['tCOMPLETION_',num2str(h)];
        ft{end+1} = 1*60;
    end
end

function [Ts] = TS(num_of_health_workers)

    Ts = cell(1, 0);
    
    for h = 1:(num_of_health_workers/2)
        Ts{end+1} = ['tDRIVE_',num2str(h)];
        Ts{end+1} = ['tVACCINATION_',num2str(h)];
        Ts{end+1} = ['tCOMPLETION_',num2str(h)];
    end

end

function [set_of_As] = AS(num_of_health_workers)
    
    global global_info

    set_of_As = cell(1, 0);
    
    % to tDRIVE_*
    for h = 1:(num_of_health_workers/2)
        
        set_of_As{end+1} = 'p1';
        set_of_As{end+1} = ['tDRIVE_',num2str(h)];
        set_of_As{end+1} = 2;
        
        set_of_As{end+1} = 'p2';
        set_of_As{end+1} = ['tDRIVE_',num2str(h)];
        set_of_As{end+1} = 1;
        
        set_of_As{end+1} = 'p3';
        set_of_As{end+1} = ['tDRIVE_',num2str(h)];
        set_of_As{end+1} = 1;
        
    end
        
    % from tDRIVE_*
    for h = 1:(num_of_health_workers/2)
        
        set_of_As{end+1} = ['tDRIVE_',num2str(h)];
        set_of_As{end+1} = 'p4';
        set_of_As{end+1} = 2;
        
        set_of_As{end+1} = ['tDRIVE_',num2str(h)];
        set_of_As{end+1} = 'p5';
        set_of_As{end+1} = global_info.residents_per_street;
        
    end
    
    % to tVACCINATION_*
    for h = 1:(num_of_health_workers/2)
        
        set_of_As{end+1} = 'p4';
        set_of_As{end+1} = ['tVACCINATION_',num2str(h)];
        set_of_As{end+1} = 1;
        
        set_of_As{end+1} = 'p5';
        set_of_As{end+1} = ['tVACCINATION_',num2str(h)];
        set_of_As{end+1} = 1;
        
        set_of_As{end+1} = 'p6';
        set_of_As{end+1} = ['tVACCINATION_',num2str(h)];
        set_of_As{end+1} = 1;
        
    end
    
    % from tVACCINATION_*
    for h = 1:(num_of_health_workers/2)
        
        set_of_As{end+1} = ['tVACCINATION_',num2str(h)];
        set_of_As{end+1} = 'p4';
        set_of_As{end+1} = 1;
        
        set_of_As{end+1} = ['tVACCINATION_',num2str(h)];
        set_of_As{end+1} = 'p7';
        set_of_As{end+1} = 1;
        
    end
    
    % to tCOMPLETION_*
    for h = 1:(num_of_health_workers/2)
        
        set_of_As{end+1} = 'p4';
        set_of_As{end+1} = ['tCOMPLETION_',num2str(h)];
        set_of_As{end+1} = 2;
        
        set_of_As{end+1} = 'p7';
        set_of_As{end+1} = ['tCOMPLETION_',num2str(h)];
        set_of_As{end+1} = global_info.residents_per_street;
        
    end
    
    % from tCOMPLETION_*
    for h = 1:(num_of_health_workers/2)

        set_of_As{end+1} = ['tCOMPLETION_',num2str(h)];
        set_of_As{end+1} = 'p1';
        set_of_As{end+1} = 2;
        
        set_of_As{end+1} = ['tCOMPLETION_',num2str(h)];
        set_of_As{end+1} = 'p3';
        set_of_As{end+1} = global_info.residents_per_street;
        
        set_of_As{end+1} = ['tCOMPLETION_',num2str(h)];
        set_of_As{end+1} = 'p8';
        set_of_As{end+1} = global_info.residents_per_street;
        
    end

end