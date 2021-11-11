function [fire, transition] = COMMON_PRE(transition)
    global global_info;
    
    if contains(transition.name, 'tVISITOR')    
        if lt(current_time(), global_info.STOP_RECEIVING_VISITORS_AT)
            fire = 1;
        else
            fire = 0;
        end;
    elseif contains(transition.name, 'tREGISTRATION')
        granted = requestSR({'Staff',1});
        % fire only if resource acquired 
        fire = granted; 
    elseif contains(transition.name, 'tVACCINATION')
        granted = requestSR({'Health_Workers',1});
        % fire only if resource acquired 
        fire = granted; 
    elseif contains(transition.name, 'tWAITING')
        granted = requestSR({'Waiting_Rooms',1});
        % fire only if resource acquired 
        fire = granted;
    end