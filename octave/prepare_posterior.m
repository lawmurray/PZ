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
function prepare_posterior ()
    experiments = {'pf', 'mupf', 'cupf', 'apf', 'amupf', 'acupf'};
    invars = {'EPg', 'VPg'};
    rang = [100001:100:200000];
    
    % construct models
    for i = 1:length(experiments)
        file = sprintf('results/mcmc_%s-0.nc.0', experiments{i});
        
        models{i} = model_posterior(file, invars, [], rang);
    end

    save -binary 'model_posterior.mat' models
end
