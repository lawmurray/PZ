% Copyright (C) 2011
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} plot_acceptance (@var{pmatch})
%
% Produce plot of acceptance rates for pz model.
%
% @itemize
% @bullet{ @var{pmatch} True to plot propagation matched results, false
% otherwise.}
% @end itemize

% @end deftypefn
%
function plot_acceptance (pmatch)
    % arguments
    if nargin < 1
        pmatch = 0;
    end
    
    % plot titles
    titles = {
        'PF0';
        'MUPF0';
        'CUPF0';
        'PF1';
        'MUPF1';
        'CUPF1';
        'PF0';
        'MUPF0';
        'CUPF0';
        'PF1';
        'MUPF1';
        'CUPF1';
        };
    
    % load models
    load model_acceptance.mat
    amodels = models;
    load model_posterior.mat
    pmodels = models;
    
    % subset of models
    if pmatch
        first = 7;
        last = 12;
    else
        first = 1;
        last = 6;
    end
    
    % use grey
    colormap(flipud(gray));
    
    % common axes
    ax1 = [];
    cax1 = [];
    
    % first drawing
    for i = first:last
        subplot(2,3,i - first + 1);
        contour_model(amodels{i});
        ax1 = [ ax1; axis() ];
        cax1 = [ cax1; caxis() ];
    end
    
    % second drawing, tidy
    ax2 = [ min(ax1(:,1)) max(ax1(:,2)) min(ax1(:,3)) max(ax1(:,4)) ];
    cax2 = [ max(min(cax1(:,1)),0) min(max(cax1(:,2)),1) ];
    lvl2 = linspace(0, 1, 11);
    for i = first:last
        subplot(2,3,i - first + 1);
        contour_model(amodels{i}, [], [0.29032, 0.10938], ax2, lvl2);
        hold on;
        contour_model(pmodels{i});
        %surf_model(models{i}, ax2);
        plot_defaults;
        axis(ax2);
        %axis([ ax2 cax2 ]);
        caxis([0 1]);
        title(titles{i});
        if mod(i,3) == 1
            ylabel('{\sigma}');
        end
        if mod(fix((i - 1) / 3), 2) == 1
            xlabel('{\mu}');
        end
        if mod(i, 6) == 0
            colorbar('east');
        end
    end
end
