% Copyright (C) 2011
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} plot_acceptance ()
%
% Produce plot of acceptance rates for pz model.
% @end deftypefn
%
function plot_state ()
    MCMC_FILE = 'results/mcmc_pf.nc.0';
    SIMULATE_FILE = 'results/simulate.nc.0';
    OBS_FILE = 'data/obs.nc';
    p = 295; % index of observation trajectory in simulate file
    ps = [25000:50000];
    ts = [1:101];
    ns = 2;
    
    nco = netcdf(OBS_FILE, 'r');
    ncs = netcdf(SIMULATE_FILE, 'r');
    
    titles = {
        '';
        'Prior';
        '';
        'Posterior';
        'Observed';
        'Truth';
        };
    
    subplot(3,1,1);
    plot_simulate(SIMULATE_FILE, 'P', [], [], ts);
    hold on;
    plot_mcmc(MCMC_FILE, 'P', [], ps);
    %plot_traj(SIMULATE_FILE, 'P', [], p, ts);
    x = read_var (ncs, 'P', [], p, ts);
    [t y] = read_obs (nco, 'P_obs', [], ts, ns);
    plot_obs(OBS_FILE, 'P_obs', [], ts, ns);
    plot(t, x, '.k', 'markersize', 5);
    for i = 1:length(t)
        line([t(i), t(i)], [x(i), y(i)], 'linewidth', 1, 'color', 'k');
    end
    hold off;
    plot_defaults;
    axis([0 100 0 8]);
    ylabel('P');
    legend(titles);
    
    subplot(3,1,2);
    plot_simulate(SIMULATE_FILE, 'Z', [], [], ts);
    hold on;
    plot_mcmc(MCMC_FILE, 'Z', [], ps);
    %plot_traj(SIMULATE_FILE, 'Z', [], p, ts);
    x = read_var (ncs, 'Z', [], p, ts);
    plot(t, x, '.k', 'markersize', 5);
    hold off;
    plot_defaults;
    axis([0 100 0 3]);
    ylabel('Z');

    subplot(3,1,3);
    plot_simulate(SIMULATE_FILE, 'rPg', [], [], ts);
    hold on;
    plot_mcmc(MCMC_FILE, 'rPg', [], ps);
    %plot_traj(SIMULATE_FILE, 'rPg', [], p, ts);
    x = read_var (ncs, 'rPg', [], p, ts);
    plot(t, x, '.k', 'markersize', 5);
    hold off;
    plot_defaults;
    xlabel('t');
    ylabel('{\alpha}');
end
