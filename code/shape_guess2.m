% y(1) = z, y(2) = r, y(3) = phi, y(4) = phi', y(5) = phi'', y(6) = smax
% params(1): height; params(2): radius of upper/bottom hoop; params(3):
% fusion pore size; params(4): guess of smax.
function y = shape_guess2(x,params)
	x = x*pi;
	y = [params(1)/2+params(1)/2*cos(x);
         params(2)-(params(2)-params(3))*sin(x);
         x;
         0;
         0;
         params(4)];
	
end