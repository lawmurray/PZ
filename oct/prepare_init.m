% Copyright (C) 2011
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} prepare_init ()
%
% Prepare init file for generating observations.
% @end deftypefn
%
function prepare_init ()
    mu = 0.29032;
    sigma = 0.10938;
    
    nc = netcdf('data/init.nc', 'c');
    nc{'mu'} = ncdouble();
    nc{'sigma'} = ncdouble();
    nc{'mu'}(:) = mu;
    nc{'sigma'}(:) = sigma;
end
