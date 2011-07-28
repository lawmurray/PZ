% Copyright (C) 2011
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} prepare_converge ()
%
% Compute $\hat{R}^p$ statistics (Brooks & Gelman 1998) for PZ model runs.
%
% @end deftypefn
%
function prepare_converge ()
    experiments = {'pf', 'mupf', 'cupf', 'apf', 'amupf', 'acupf'};
    invar = {'EPg', 'VPg'};

    % construct arguments for parallel execution
    C = length(experiments);
    Rp = cell(C,1);
    ins = cell(C,1);
    invars = cell(C,1);
    for i = 1:C
        j = 1;
        file = sprintf('results/mcmc_%s-%d.nc.%d', experiments{i}, ...
            fix((j - 1)/2), j - 1);
        while exist(file, 'file')
            ins{i}{j} = file;
            j = j + 1;
            file = sprintf('results/mcmc_%s-%d.nc.%d', experiments{i}, ...
                fix((j - 1)/2), j - 1);
        end
        invars{i} = invar;
    end
   
    % execute
    Rp = parcellfun(C, @converge, ins, invars, 'UniformOutput', 0);
    
    % save
    save -binary Rp.mat Rp
end