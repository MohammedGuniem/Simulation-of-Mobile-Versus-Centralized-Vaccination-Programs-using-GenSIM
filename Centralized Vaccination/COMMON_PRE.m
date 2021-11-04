function [fire, transition] = COMMON_PRE(transition)
    
    switch transition.name
        case 'tVISITOR'
            fire = 1;
        case 'tREGISTRATION'
            granted = requestSR({'Staff',12});
            % fire only if resource acquired 
            fire = granted; 
        case 'tVACCINATION'
            granted = requestSR({'Health_Workers',24});
            % fire only if resource acquired 
            fire = granted; 
        case 'tWAITING'
            granted = requestSR({'Waiting_Rooms',30});
            % fire only if resource acquired 
            fire = granted;
        otherwise
            fire = 0;
    end
