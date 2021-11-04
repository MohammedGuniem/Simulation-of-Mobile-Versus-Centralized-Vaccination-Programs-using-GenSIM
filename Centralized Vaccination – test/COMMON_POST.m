function [] = COMMON_POST(transition)
    if contains(transition.name, 'tVISITOR')
        return;
    elseif contains(transition.name, 'tREGISTRATION')
        release();
    elseif contains(transition.name, 'tVACCINATION')
        release();
    elseif contains(transition.name, 'tWAITING')
        release();
    end
