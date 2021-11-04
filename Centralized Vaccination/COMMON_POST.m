function [] = COMMON_POST(transition)
    switch transition.name
        case 'tREGISTRATION'
            release(); 
        case 'tVACCINATION'
            release(); 
        case 'tWAITING'
            release(); 
        case 'tVISITOR'
            return;
        otherwise
            return;
    end
