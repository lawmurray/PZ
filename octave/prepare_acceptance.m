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
    experiments = {'pf', 'mupf', 'cupf', 'apf', 'amupf', 'acupf', ...
        'pf-pmatch', 'mupf-pmatch', 'cupf', 'apf-pmatch', 'amupf-pmatch', ...
        'acupf'};
    invar = {'EPg', 'VPg'};
    M = 200;
    iter = 1000;
    
    % construct arguments for parallel execution
    C = length(experiments);
    files = cell(C,1);
    invars = cell(C,1);
    Ms = cell(C,1);
    coords = cell(C,1);
    iters = cell(C,1);
    for i = 1:length(experiments)
        file = sprintf('results/likelihood_%s.nc.0', experiments{i});
        files{i} = file;
        invars{i} = invar;
        coords{i} = [];
        Ms{i} = M;
        iters{i} = iter;
    end

    % construct and krig models
    models = cellfun(@model_acceptance, files, invars, coords, Ms, ...
        'UniformOutput', 0);
    save -binary model_acceptance.mat models
    models = cellfun(@krig_model, models, iters, 'UniformOutput', 0);
    
    % save
    save -binary model_acceptance.mat models
end
