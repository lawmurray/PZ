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
    invar = {'EPg', 'VPg'};
    rang = [100001:100:200000];
    
    % construct arguments for parallel execution
    C = length(experiments);
    files = cell(C,1);
    invars = cell(C,1);
    coords = cell(C,1);
    rangs = cell(C,1);
    for i = 1:length(experiments)
        file = sprintf('results/mcmc_%s-26.nc.106', experiments{i});
        files{i} = file;
        invars{i} = invar;
        coords{i} = [];
        rangs{i} = rang;
    end

    % construct and kernel density estimate models
    models = parcellfun(2, @model_posterior, files, invars, coords, rangs, ...
        'UniformOutput', 0);
    models = parcellfun(2, @kde_model, models, 'UniformOutput', 0);

    % save
    save -binary 'model_posterior.mat' models
end
