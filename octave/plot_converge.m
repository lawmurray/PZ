% Copyright (C) 2011
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} plot_converge (@var{pmatch})
%
% Produce plot of convergence statistic for PZ model.
%
% @itemize
% @bullet{ @var{pmatch} True to plot propagation matched results, false
% otherwise.}
% @end itemize

% @end deftypefn
%
function plot_converge (pmatch)
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
        };
    
    % load models
    load Rp.mat
    
    % subset of models
    if pmatch
        first = 7;
        last = 12;
    else
        first = 1;
        last = 6;
    end

    meanfunc = 'meanConst'; hyp.mean = 1;
    covfunc = 'covSEiso'; ell = 1000; sf = 1; hyp.cov = log([ell; sf]);
    likfunc = 'likGauss'; sn = 0.1; hyp.lik = log(sn);

    hold off;
    x = [21:20:50000]';
    for i = first:last
        y = Rp{i};
        
        %x1 = x(1:10:end);
        %y1 = y(1:10:end);
        
        %hyp1 = hyp;
        %hyp1.mean = mean(y);
        %hyp1 = minimize(hyp1, @gp, -1000, @infExact, meanfunc, covfunc, ...
        %    likfunc, x1, y1);
        %[m s2] = gp(hyp1, @infExact, meanfunc, covfunc, likfunc, x1, y1,
        %x);
        
        % seems to give very different answers depending on degree
        %[alpha,c,rms] = expfit(2, 21, 20, y - 1);
        %m = zeros(size(x));
        %for j = 1:2
        %    m += c(j)*exp(alpha(j)*x);
        %end
        %m += 1;
        
        m = y;
        plot(x, m, 'color', watercolour(mod(i - 1, 6) + 1), 'linewidth', 3);
        hold on;
    end
    plot_defaults;
    ylabel('{\hat{R}^p}');
    xlabel('Step');
    legend(titles);
    axis([0 20000 1 1.05]);
end
