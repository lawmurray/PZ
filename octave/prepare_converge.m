% Copyright (C) 2011
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} prepare_converge ()
%
% Compute $\hat{R}^p$ statistics for PZ model runs.
%
% @end deftypefn
%
function prepare_converge ()
    experiments = {'pf', 'mupf', 'cupf', 'apf', 'amupf', 'acupf'};
    invars = {'EPg', 'VPg'};
    
    C = length(experiments);
    Rp = cell(C,1);
    for i = 1:C
        experiment = experiments{i};
        ins = cell(16,1);
        for j = 1:length(ins)
            ins{j} = sprintf('results/mcmc_%s-%d.nc.%d', experiment, ...
                 fix((j - 1)/2), j - 1);
        end
        Rp{i} = converge(ins, invars);
        save Rp.mat Rp
    end
    
    save Rp.mat Rp
end
