% Copyright (C) 2011
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} prepare_acceptance ()
%
% Prepare acceptance rates for PZ model.
% @end deftypefn
%
function prepare_acceptance ()
    experiments = {'pf', 'mupf', 'cupf', 'apf', 'amupf', 'acupf'};
    invars = {'EPg', 'VPg'};
    M = 200;

    % common axes
    ax1 = [];
    cax1 = [];
    
    % construct models
    for i = 1:length(experiments)
        experiment = experiments{i};
        file = sprintf('results/likelihood_%s.nc.0', experiment);
        
        model{i} = model_acceptance(file, invars, [], M);
        model{i} = krig_model(model{i}, 1000);
    end

    save -binary model_acceptance.mat model
end
