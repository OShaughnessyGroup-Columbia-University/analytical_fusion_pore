function res = shape_eqn_6bc_clamped_asymmetric(ya,yb,params)
% y(1) = z, y(2) = r, y(3) = phi, y(4) = phi', y(5) = phi'', y(6) = smax
% ya: upper hoop; yb: bottom hoop.
% params(1): height; params(2): radius of bottom hoop; params(3): radius of
% upper hoop
res = [ ya(1) - params(1);
        ya(2) - params(3);
        ya(3)-pi;
        yb(1);
        yb(2) - params(2);
        yb(3)];
end