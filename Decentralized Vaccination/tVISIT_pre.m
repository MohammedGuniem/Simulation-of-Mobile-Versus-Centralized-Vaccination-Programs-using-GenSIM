function [fire, transition] = tVISIT_pre(transition)
    granted = requestSR({'Vehichles',15});
    
% fire only if resource acquired 
fire = granted; 
