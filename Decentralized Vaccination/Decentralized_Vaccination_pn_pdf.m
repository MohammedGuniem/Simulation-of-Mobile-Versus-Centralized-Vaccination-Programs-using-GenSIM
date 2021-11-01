% PDF: Decenteralized Vaccination Program

function [png] = Decentralized_Vaccination_pn_pdf()

    png.PN_name = 'Decenteralized Vaccination Program';
    png.set_of_Ps = {'p1','p2','p3','p4','p5','p6'}
    % Done
    png.set_of_Ts = {'tVISIT', 'tVACCINATION'}
    png.set_of_As = {
        'p1','tVISIT',375,... % number of residents to be visited is 375 = 25 residents per street X each of the 15 health workers visiting a new street.
        'p2','tVISIT',15,... %15 health workers
        'tVISIT','p3',15,... %15 health workers ready to vaccinate residents.
        'tVISIT','p4',375,... %25*15 = 375 residents ready to be vaccinated.
        'p3','tVACCINATION',15,... %15 health workers ready to vaccinate residents.
        'p4','tVACCINATION',375,...  %25*15 = 375 residents ready to be vaccinated.
        'p5','tVACCINATION',375,... %25*15 = 375 doses of vaccine available, everybody gets one dose.
        'tVACCINATION','p2',15,... %15 health workers are ready to visit new streets.
        'tVACCINATION','p6',375,... %25*15 = 375 residents are fully vaccinated.
    }
end