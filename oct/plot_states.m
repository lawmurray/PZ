% Copyright (C) 2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} plot_states ()
%
% Produce plots of state posteriors for PZ model.
%
% @itemize @var{is} Dimension indices.
%
% @end deftypefn
%
function plot_states ()
    priorFile = 'results/prior.nc';
    posteriorFile = 'results/posterior.nc';
    obsFile = 'data/obs.nc';
    
    % work out appropriate sample range
    nc = netcdf (priorFile, 'r');
    P = length (nc('np'));
    ps = [2000:P];

    subplot (1, 2, 1);
    bi_plot_quantiles (priorFile, 'P');
    hold on;
    bi_plot_quantiles (posteriorFile, 'P');
    bi_plot_paths (obsFile, 'P_obs');
    hold off;
    xlabel('t');
    ylabel('Z');
    legend ('prior', '', 'posterior', '', 'observed');
    
    subplot (1, 2, 2);
    bi_plot_quantiles (priorFile, 'Z');
    hold on;
    bi_plot_quantiles (posteriorFile, 'Z');
    hold off;
    xlabel('t');
    ylabel('Z');
    legend ('prior', '', 'posterior');
end
