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
function plot_posterior ()
    % load models from prepare_posterior()
    load model_posterior.mat
    
    % common axes
    ax1 = [];
    cax1 = [];
    
    % first drawing
    for i = 1:length(models)
        subplot(2,6,i);
        contour_model(models{i});
        ax1 = [ ax1; axis() ];
        cax1 = [ cax1; caxis() ];
    end
    
    % second drawing, tidy
    ax2 = [ min(ax1(:,1)) max(ax1(:,2)) min(ax1(:,3)) max(ax1(:,4)) ];
    cax2 = [ min(cax1(:,1)) max(cax1(:,2)) ];
    lvl2 = linspace(cax2(1), cax2(2), 11);
    for i = 1:length(models)
        subplot(2,6,i);
        contour_model(models{i}, [], [], ax2, lvl2);
        %surf_model(models{i}, ax2);
        plot_defaults;
        axis(ax2);
        caxis(cax2);
        xlabel('{\mu}');
        ylabel('{\sigma}');
        colorbar;
    end
end
