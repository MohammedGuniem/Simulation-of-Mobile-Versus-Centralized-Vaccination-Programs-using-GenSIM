% PDF: Mobile Vaccination Program

function [png] = Mobile_Vaccination_pn_pdf()
    
    global global_info
    
    png.PN_name = 'Mobile Vaccination Program';
    png.set_of_Ps = {'p1','p2','p3','p4','p5','p6','p7','p8'};
    png.set_of_Ts = construct('transitions', global_info.num_of_health_workers);
    png.set_of_As = construct('arcs', global_info.num_of_health_workers);
    
end