function [fire, transition] = tREGISTRATION_pre(transition)
 
granted = requestSR({'Staff',1}); % requestGR(1); 

% fire only if resource acquired 
fire = granted; 
