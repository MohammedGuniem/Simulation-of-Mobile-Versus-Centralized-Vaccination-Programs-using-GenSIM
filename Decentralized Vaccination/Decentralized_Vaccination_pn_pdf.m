% PDF: Decenteralized Vaccination Program

function [png] = Decentralized_Vaccination_pn_pdf()

    png.PN_name = 'Decenteralized Vaccination Program';
    png.set_of_Ps = {'p1','p2','p3','p4','p5','p6'}
    % Done
    png.set_of_Ts = {'tVISIT', 'tVACCINATION'}
    png.set_of_As = {
        'p1','tVISIT',300,... 
        'p2','tVISIT',15,...
        'tVISIT','p3',15,...
        'tVISIT','p4',300,...
        'p3','tVACCINATION',15,...
        'p4','tVACCINATION',300,...
        'p5','tVACCINATION',300,...
        'tVACCINATION','p2',15,...
        'tVACCINATION','p6',300,...
    }
end