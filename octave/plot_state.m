% Copyright (C) 2011
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} plot_acceptance ()
%
% Produce plot of state posteriors for PZ model.
% @end deftypefn
%
function plot_state ()
    MCMC_FILE = 'results/mcmc_acupf.nc.0';
    SIMULATE_FILE = 'results/simulate.nc.0'; % for prior
    OBS_FILE = 'data/obs.nc';
    ps = [25000:50000];
    ts = [1:101];
    ns = 2;
    
    nco = netcdf(OBS_FILE, 'r');
    
    titles = {
        '';
        'Prior';
        '';
        'Posterior';
        'Observed';
        'Truth';
        };
    
    subplot(1,2,2);
    plot_simulate(SIMULATE_FILE, 'P', [], [], ts);
    hold on;
    plot_mcmc(MCMC_FILE, 'P', [], ps);
    %plot_traj(SIMULATE_FILE, 'P', [], p, ts);
    x = read_var (nco, 'P', [], 1, ts);
    [t y] = read_obs (nco, 'P_obs', [], ts, ns);
    plot_obs(OBS_FILE, 'P_obs', [], ts, ns);
    plot(t, x, '.k', 'markersize', 5);
    for i = 1:length(t)
        line([t(i), t(i)], [x(i), y(i)], 'linewidth', 1, 'color', 'k');
    end
    hold off;
    plot_defaults;
    axis([0 100 0 7]);
    xlabel('t');
    ylabel('P');
    legend(titles);
    
    subplot(2,2,1);
    plot_simulate(SIMULATE_FILE, 'Z', [], [], ts);
    hold on;
    plot_mcmc(MCMC_FILE, 'Z', [], ps);
    x = read_var (nco, 'Z', [], 1, ts);
    plot(t, x, '.k', 'markersize', 5);
    hold off;
    plot_defaults;
    axis([0 100 0.25 2.75]);
    ylabel('Z');

    subplot(2,2,3);
    plot_simulate(SIMULATE_FILE, 'rPg', [], [], ts);
    hold on;
    plot_mcmc(MCMC_FILE, 'rPg', [], ps);
    x = read_var (nco, 'rPg', [], 1, ts);
    plot(t, x, '.k', 'markersize', 5);
    hold off;
    plot_defaults;
    xlabel('t');
    ylabel('{\alpha}');
end
