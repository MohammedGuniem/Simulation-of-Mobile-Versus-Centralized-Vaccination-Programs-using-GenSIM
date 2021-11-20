% Common Post-precessor File for Centeralized Vaccination Program

function [] = COMMON_POST(transition)

    % Postprocessor for the tVISITOR transistions.
    if contains(transition.name, 'tVISITOR')
        % No resrouces is used here, just return.
        return;
        
    % Postprocessor for the tREGISTRATION transistions.
    elseif contains(transition.name, 'tREGISTRATION')
        %release the occupied staff resource after registration is complete.
        release();
        
    % Postprocessor for the tVACCINATION transistions.
    elseif contains(transition.name, 'tVACCINATION')
        %release the occupied health worker resource after vaccination is complete. 
        release();
     
    % Postprocessor for the tWAITING transistions.  
    elseif contains(transition.name, 'tWAITING')
        %release the the occupied room resource after waiting for any abnormal reaction.
        release();
        
    end
