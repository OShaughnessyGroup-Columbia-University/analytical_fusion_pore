% y(1) = z, y(2) = r, y(3) = phi, y(4) = phi', y(5) = phi'', y(6) = smax
% y(7) = gamma, y(8) = A; 
% params(1): height; params(2): radius of upper/bottom hoop; params(3):
% gamma, params(4): Area
function y = shape_guess3(x,params)

	y = zeros(8,length(x));
    fName0 = ['shapes/Area',num2str(params(4)),'_radius',num2str(params(2)),...
              '/tether_gamma',num2str(params(3)),'_height',num2str(params(1)),...
              '_radius',num2str(params(2)),'.mat'];
    load(fName0, 'sol');
    y_deval = deval(x, sol);
    y(1:6,:) = y_deval;
    y(7,:) = ones(1,length(x)) * params(3);
    y(8,1) = 0;
    for i = 2 : length(x)
        y(8,i) = trapz(y_deval(6,1)*x(1:i),2*pi.*y_deval(2,1:i));
    end
	
end