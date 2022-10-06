function res = shape_eqn_8bc_omega_fixa(ya,yb,params)
% y(1) = z, y(2) = r, y(3) = phi, y(4) = phi', y(5) = phi'', y(6) = smax
% y(7) = gamma, y(8) = A;
% ya: upper hoop; yb: bottom hoop.
% params(1): height; params(2): radius of upper hoop; 
% params(3): radius of bottom hoop; params(4): total area
% params = [0.1, w, A_total];

res = [ ya(1) - params(1);
        ya(2) - params(2);
        ya(3);
        ya(8);
        yb(1);
        yb(2) - params(3);
        %yb(4)/yb(6) + sin(yb(3))/yb(2);
        yb(3);
        yb(8) - params(4)];
end