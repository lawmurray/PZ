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
function plot_acceptance ()
    experiments = {'bootstrap', 'disturbance'};
    invars = {'EPg', 'VPg'};
    M = 50;

    % common axes
    ax1 = [];
    cax1 = [];
    
    % first drawing
    for i = 1:length(experiments)
        experiment = experiments{i};
        file = sprintf('results/likelihood_%s.nc.0', experiment);
        
        model{i} = model_likelihood(file, invars, [], M);
        model{i} = krig_likelihood(model{i}, 1000);
        
        subplot(1,length(experiments),i);
        contour_likelihood(model{i});
        ax1 = [ ax1; axis() ];
        cax1 = [ cax1; caxis() ];
    end
    
    % second drawing, tidy
    ax2 = [ min(ax1(:,1)) max(ax1(:,2)) min(ax1(:,3)) max(ax1(:,4)) ];
    cax2 = [ max(min(cax1(:,1)),0) min(max(cax1(:,2)),1) ];
    lvl2 = linspace(0, 1, 11);
    for i = 1:length(experiments)
        subplot(1,length(experiments),i);
        contour_likelihood(model{i}, [], [], ax2, lvl2);
        %surf_likelihood(model{i}, ax2);
        plot_defaults;
        axis(ax2);
        %axis([ ax2 cax2 ]);
        caxis(cax2);
        xlabel('{\mu}');
        ylabel('{\sigma}');
        colorbar;
    end
end
