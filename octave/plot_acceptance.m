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
    % load models from prepare_acceptance()
    load model_acceptance.mat
    amodels = models;
    load model_posterior.mat
    pmodels = models;
    
    % use grey
    colormap(flipud(gray));
    
    % common axes
    ax1 = [];
    cax1 = [];
    
    % first drawing
    for i = 1:length(amodels)
        subplot(2,6,i);
        contour_model(amodels{i});
        ax1 = [ ax1; axis() ];
        cax1 = [ cax1; caxis() ];
    end
    
    % second drawing, tidy
    ax2 = [ min(ax1(:,1)) max(ax1(:,2)) min(ax1(:,3)) max(ax1(:,4)) ];
    cax2 = [ max(min(cax1(:,1)),0) min(max(cax1(:,2)),1) ];
    lvl2 = linspace(0, 1, 16);
    for i = 1:length(amodels)
        subplot(2,6,i);
        contour_model(amodels{i}, [], [0.2836, 0.0970], ax2, lvl2);
        hold on;
        contour_model(models{mod(i - 1, length(pmodels)) + 1});
        %surf_model(models{i}, ax2);
        plot_defaults;
        axis(ax2);
        %axis([ ax2 cax2 ]);
        caxis([0 1]);
        if i == 1 || i == 7
            ylabel('{\sigma}');
        end
        if i > 6
            xlabel('{\mu}');
        end
        if i == 6 || i == 12
            colorbar('east');
        end
    end
end
