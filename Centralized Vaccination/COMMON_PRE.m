function [fire, transition] = COMMON_PRE(transition)

    if strcmp(transition.name, 'tREGISTRATION'),
        granted = requestSR({'Staff',15});
    elseif strcmp(transition.name, 'tVACCINATION'),
        granted = requestSR({'Health_Workers',15});
    elseif strcmp(transition.name, 'tWAITING'),
        granted = requestSR({'Waiting_Rooms',30});
    end

% fire only if resource acquired 
fire = granted; 
