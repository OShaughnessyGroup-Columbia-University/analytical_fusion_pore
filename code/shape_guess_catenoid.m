% y(1) = z, y(2) = r, y(3) = phi, y(4) = phi', y(5) = phi'', y(6) = smax
% y(7) = gamma, y(8) = A; 
% params(1): height; params(2): radius of upper/bottom hoop; params(3):
% fusion pore size, params(4): gammafunction y = shape_guess4(x,params)
function y = shape_guess_catenoid(x, params)
	y = zeros(8,length(x));
    y(1:6,:) = shape_guess2(x,[params(1:3),0]);
    smax = sum(sqrt((y(1,2:end)-y(1,1:end-1)).^2+(y(2,2:end)-y(2,1:end-1)).^2));
    smax = 200;
    y(6,:) = ones(1,length(x)) * smax;
    y(7,:) = ones(1,length(x)) * params(4);
    y(8,1) = 0;
    for i = 2 : length(x)
        y(8,i) = trapz(y(6,1)*x(1:i),2*pi.*y(2,1:i));
    end	
end