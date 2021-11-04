function [fire, transition] = COMMON_PRE(transition)
    
    if contains(transition.name, 'tVISITOR')
        fire = 1;
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