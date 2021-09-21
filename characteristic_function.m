%%% Characteristic function from discrete observations %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Given discrete observations (x,fx), evaluate a  f at
% t such that f(t) is equal to f(x) where x is the nearest observed value
% from below to t


function [v] = characteristic_function(t,x,fx)
% x is a vector of points on the domain of the function for which discrete
% observations exist, e.g ages 0,1,...95
% fx are the discretely observed function values
% t is a point at which to evaluate the characteristic function that
% satisfies:
% (min(x) <= t <= max(x)
       
        [~,index_of_nearest_x_from_below] = max(x(x <= t));
        v = fx(index_of_nearest_x_from_below);    


end