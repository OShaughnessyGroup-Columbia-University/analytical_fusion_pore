function res = shape_eqn_6bc_nd_test(ya,yb,params)
% y(1) = z, y(2) = r, y(3) = phi, y(4) = phi', y(5) = phi'', y(6) = smax
% ya: upper hoop; yb: bottom hoop.
% params(1): height; params(2): radius of bottom hoop; params(3): radius of
% upper hoop; params(4): kappa

kappa = params(4);
lp = 100; % in unit of pN*nm
a2 = 8*lp; % in unit of pN*nm*nm
a1 = 2*lp;
k = (a2-a1)/params(3)^2;

res = [ ya(1) - params(1);
        ya(2) - params(3);
        2*kappa*1/2*(ya(4)/ya(6)+sin(ya(3))/ya(2)) - k*sin(2*ya(3))/2;
        yb(1);
        yb(2) - params(2);
        yb(3)];
end