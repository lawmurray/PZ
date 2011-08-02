% Copyright (C) 2011
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} get_init ()
%
% Generate init file for likelihood -- equispaced grid of points over
% domain of uniform prior.
% @end deftypefn
%
function prepare_init ()
    EPg = linspace(0, 1.0, 32);
    VPg = linspace(0, 0.5, 33)(2:end); % drop zero
    
    [EPg, VPg] = meshgrid(EPg, VPg);
    EPg = EPg(:);
    VPg = VPg(:);
    
    P = length(EPg);

    nco = netcdf('data/likelihood_init.nc', 'c', '64bit-offset');
    nco('np') = P;
    nco{'EPg'} = ncdouble('np');
    nco{'VPg'} = ncdouble('np');
    
    nco{'EPg'}(:) = EPg;
    nco{'VPg'}(:) = VPg;
end
