function [fire, transition] = COMMON_PRE(transition)
    
    % Prepresessor for the tVISITOR transistion.
    if contains(transition.name, 'tDRIVE')
        disp(transition.name);
        disp(string_HH_MM_SS(current_time()));
        fire = 1;
        
    % Preprocessor for the tREGISTRATION transistions.
    elseif contains(transition.name, 'tVACCINATION')
        
        fire = 1; 
        
    % Preprocessor for the tVACCINATION transistions.
    elseif contains(transition.name, 'tCOMPLETION')
        
        fire = 1; 
        
    end