function [] = COMMON_POST(transition)

    % Postprocessor for the tVISITOR transistions.
    if contains(transition.name, 'tVISITOR')
        % No resrouces is used here, just return.
        return;
        
    % Postprocessor for the tREGISTRATION transistions.
    elseif contains(transition.name, 'tREGISTRATION')
        %release the resources after registration.
        release();
        
    % Postprocessor for the tVACCINATION transistions.
    elseif contains(transition.name, 'tVACCINATION')
        %release the resources after vaccination.
        release();
     
    % Postprocessor for the tWAITING transistions.  
    elseif contains(transition.name, 'tWAITING')
        %release the resources after waiting for any abnormal reaction.
        release();
        
    end
