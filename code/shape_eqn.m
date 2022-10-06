
% The problem to solve is the shape equation written as below.
%
%      z' =  -sin(phi) * smax
%      r' = cos(phi) * smax
%      (phi)' = phi'
%      (phi')' =  phi''
%      (phi'')' = -(phi')^3/2 - 2cos(phi)/r*phi''*smax 
%               + 3sin(phi)/2/r*(phi')^2*smax
%               + (3cos(phi)^2-1)/2/r^2*phi'*smax^2
%               + phi'*smax^2*gamma_tilda + gamma_tilda/r*sin(phi)*smax^3
%               - (cos(phi)^2+1)/2/r^3*sin(phi)*smax^3
%               - p_tilda*smax^3
%      smax' = 0        

function dydx = shape_eqn(x,y,params)
% y(1) = z, y(2) = r, y(3) = phi, y(4) = phi', y(5) = phi'', y(6) = smax
% params(1) = gamma/kappa = gamma_tilda, params(2) = delta_p/kappa = p_tilda

dydx =  [ -sin(y(3)) * y(6);
          cos(y(3)) * y(6);
          y(4);
          y(5);
          - 1/2*(y(4))^3 - 2*cos(y(3))/y(2)*y(5)*y(6) ...
          + 3*sin(y(3))/2/y(2)*(y(4))^2*y(6) ...
          + (3*(cos(y(3)))^2-1)/2/(y(2))^2*y(4)*(y(6))^2 ...
          + y(4)*(y(6))^2*params(1) + params(1)/y(2)*sin(y(3))*(y(6))^3 ...
          - ((cos(y(3)))^2+1)/2/(y(2))^3*sin(y(3))*y(6)^3 ...
          - params(2)*y(6)^3;
          0+x-x ];
end

