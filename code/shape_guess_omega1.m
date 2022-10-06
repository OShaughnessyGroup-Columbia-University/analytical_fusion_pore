% y(1) = z, y(2) = r, y(3) = phi, y(4) = phi', y(5) = phi'', y(6) = smax
% y(7) = gamma, y(8) = A; 
% params(1): height; params(2): radius of bottom hoop; params(3):
% fusion pore size; params(4): vesicle radius; params(5): gamma
% pamas = [h_total, w, r_pore, r_ves, gamma];

function y = shape_guess_omega1(x,params)
    
    h_total = params(1);
    w = params(2); 
    r_pore = params(3);
    r_ves = params(4);
    gamma = params(5);

    [z,r,s,phi,A]= gen_initial(r_ves, w, r_pore, h_total);
    r(1) = 0.1;
    smax = s(end);
    s = s / smax;

    y(1,:) = interp1(s,z,x);
    y(2,:) = interp1(s,r,x);
    y(3,:) = interp1(s,phi,x);
    y(4,:) = zeros(1,length(x));
    y(5,:) = zeros(1,length(x));
    y(6,:) = ones(1,length(x)) * 100;
    y(7,:) = ones(1,length(x)) * gamma;
    y(8,1) = interp1(s,A,x);
	
end



function [z,x,s,phi,A]= gen_initial(r_ves, w, r_pore, h_total)

    options = optimset('Display','off');

    a_cat = r_pore;
    r_cat = w;
    A_total = 4*pi*r_ves^2 + pi*r_cat^2/4;
    z_cat = fsolve(@(h)a_cat*cosh(h/a_cat)-r_cat, a_cat, options);

    sol = fsolve(@(x)solve_ellip(x,h_total, A_total, a_cat, z_cat),[r_ves, r_ves, pi/6, z_cat/2],options);
    a_ellip = sol(1); c_ellip = sol(2); theta = sol(3); h_cat = sol(4);

    z1 = linspace(z_cat+h_cat,0,101);
    x1 = a_cat * cosh((z1-z_cat)/a_cat);

    v2 = linspace(0, pi-theta, 101);
    x2 = a_ellip * sin(v2);
    z2 = c_ellip * cos(v2) + c_ellip * cos(theta) + h_cat + z_cat;

    z = [z2, z1];
    x = [x2, x1];
    
    s = zeros(1,length(z));
    phi = zeros(1,length(z));
    A = zeros(1,length(z));
    
    for i = 2:length(z)
        s(i) = s(i-1) + sqrt( (z(i)-z(i-1))^2 + (x(i)-x(i-1))^2);
        phi(i) = atan(-(z(i)-z(i-1))/(x(i)-x(i-1)));
        if(phi(i)<=0)
            phi(i) = phi(i)+pi;
        end
        A(i) = A(i-1) + 2*pi*(s(i)-s(i-1))*(x(i)+x(i-1))/2;
    end

end

function res = solve_ellip(x, h_total, A_total, a_cat, z_cat)
    
    %x = [a_ellip, c_ellip, theta, h_cat];
    a_ellip = x(1); c_ellip = x(2); theta = x(3); h_cat = x(4);
    r_cat = a_cat * cosh(h_cat/a_cat);
    A_cat = 1/2*pi*a_cat^2*((sinh(2*z_cat/a_cat)+2*z_cat/a_cat) + (sinh(2*h_cat/a_cat)+2*h_cat/a_cat));
    A_ellip = 2*pi * integral(@(x)a_ellip*sin(x).*sqrt(a_ellip^2*cos(x).^2+c_ellip^2*sin(x).^2), 0, pi-theta); 
    
    res(1) = a_ellip / c_ellip * cot(theta) - sinh(h_cat/a_cat);
    res(2) = c_ellip * (1+cos(theta)) + h_cat + z_cat - h_total;
    res(3) = r_cat - a_ellip * sin(theta);
    res(4) = A_cat + A_ellip - A_total;
    
end