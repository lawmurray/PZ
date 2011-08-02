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
    
    for i = 1:length(models)
        subplot(2,6,i);
        hold on;
        contour_model(models{i});
        %surf_model(models{i}, ax2);
        %plot_defaults;
        %axis(ax2);
        %caxis(cax2);
        %xlabel('{\mu}');
        %ylabel('{\sigma}');
        %colorbar;
    end
end
