function [fire, transition] = COMMON_PRE(transition)

    switch transition.name
        case 'tREGISTRATION'
            granted = requestSR({'Staff',1});
        case 'tVACCINATION'
            granted = requestSR({'Health_Workers',1});
        case 'tWAITING'
            granted = requestSR({'Waiting_Rooms', 1});
    end

% fire only if resource acquired 
fire = granted; 
