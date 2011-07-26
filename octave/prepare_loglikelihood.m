% Copyright (C) 2011
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} prepare_loglikelihood ()
%
% Prepare log-likelihoods for PZ model.
% @end deftypefn
%
function prepare_loglikelihood ()
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
        
        model{i} = model_loglikelihood(file, invars, [], M);
        model{i} = krig_model(model{i}, 1000);
        mx{i} = max_model(model{i});
    end

    save -binary 'model_loglikelihood.mat' model mx
end
