% y(1) = z, y(2) = r, y(3) = phi, y(4) = phi', y(5) = phi'', y(6) = smax
% params(1): height; params(2): radius of upper/bottom hoop; params(3):
% fusion pore size; params(4): guess of smax.
function y = shape_guess1(x,params)
	x = x*pi;
	y = [params(1)/2*sin(pi/2-x)+params(1)/2;
         -(params(2)-params(3))*cos(pi/2-x)+params(2);
         x;
         0;
         0;
         params(4)];
         %800];
	
end