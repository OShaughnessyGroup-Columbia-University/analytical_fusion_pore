function res = shape_eqn_8bc_clamped_fixa(ya,yb,params)
% y(1) = z, y(2) = r, y(3) = phi, y(4) = phi', y(5) = phi'', y(6) = smax
% y(7) = gamma, y(8) = A;
% ya: upper hoop; yb: bottom hoop.
% params(1): height; params(2): radius of upper/bottom hoop; 
% params(3): total area
res = [ ya(1) - params(1);
        ya(2) - params(2);
        ya(3)-pi;
        ya(8);
        yb(1);
        yb(2) - params(2);
        yb(3)
        yb(8) - params(3)];
end