clear all;
clc;

num_of_staff = 5;
num_of_health_workers = 10;
num_of_waiting_rooms = 10;

ft = FT(num_of_staff, num_of_health_workers, num_of_waiting_rooms);
Ts = TS(num_of_staff, num_of_health_workers, num_of_waiting_rooms);

function [ft] = FT(num_of_staff,num_of_health_workers,num_of_waiting_rooms)
    
    ft = cell(1, 26);
    
    ft{end+1} = {'tVISITOR'};
    ft{end+1} = 15*60;

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

function [Ts] = TS(num_of_staff,num_of_health_workers,num_of_waiting_rooms)

    Ts = {'tVISITOR'};

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

