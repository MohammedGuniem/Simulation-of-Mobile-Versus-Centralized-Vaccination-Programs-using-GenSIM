% Common Pre-precessor File for Centeralized Vaccination Program

function [fire, transition] = COMMON_PRE(transition)
    global global_info;
    
    % Prepresessor for the tVISITOR transistion.
    if contains(transition.name, 'tVISITOR')
        
        % If time is under global_info.STOP_RECEIVING_VISITORS_AT
        % still open for receiving visitors, do fire
        if lt(current_time(), global_info.STOP_RECEIVING_VISITORS_AT)
            fire = 1;
            
        % If time is over global_info.STOP_RECEIVING_VISITORS_AT
        % closed for receiving visitors, do not fire
        else
            fire = 0;
            
        end;
        
    % Preprocessor for the tREGISTRATION transistions.
    elseif contains(transition.name, 'tREGISTRATION_')
        
        % One staff is needed to register one visitor
        granted = requestSR({'Staff',1});
        
        % fire only if resource acquired 
        fire = granted; 
        
    % Preprocessor for the tVACCINATION transistions.
    elseif contains(transition.name, 'tVACCINATION_')
        
        % One health worker is needed to register one visitor
        granted = requestSR({'Health_Workers',1});
        
        % fire only if resource acquired 
        fire = granted; 
        
    % Preprocessor for the tWAITING transistions.
    elseif contains(transition.name, 'tWAITING_')
        
        % One waiting room is needed to observe for any negative effects 
        % of the vaccine on the vaccinated person.
        granted = requestSR({'Waiting_Rooms',1});
        
        % fire only if resource acquired 
        fire = granted;
        
    end