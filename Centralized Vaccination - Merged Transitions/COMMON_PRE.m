function [fire, transition] = COMMON_PRE(transition)

    switch transition.name
        case 'tVISITOR'
            fire = 1;
        case 'tREGISTRATION'
            granted = requestSR({'Staff',5});
            % fire only if resource acquired 
            fire = granted; 
        case 'tVACCINATION'
            granted = requestSR({'Health_Workers',10});
            % fire only if resource acquired 
            fire = granted; 
        case 'tWAITING'
            granted = requestSR({'Waiting_Rooms',10});
            % fire only if resource acquired 
            fire = granted;
        otherwise
            fire = 0;
    end
