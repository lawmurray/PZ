% Copyright (C) 2011
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} plot_noise (@var{in}, @var{M})
%
% Plot output of the likelihood program.
%
% @itemize
% @bullet{ @var{in} Input file. Gives the name of a NetCDF file output by
% likelihood.}
%
% @bullet{ @var{M} Number of times each sample repeated in file.
% @end itemize
% @end deftypefn
%
function plot_noise (in, M)
    % read in log-likelihoods
    nc = netcdf('results/likelihood_disturbance.nc.0', 'r');
    ll = nc{'loglikelihood'}(:);
    ll = reshape(ll, M, length(ll)/M);

    % compute log of mean likelihood
    mx = max(ll);
    llZ = ll - repmat(mx, rows(ll), 1);
    lZ = exp(llZ);
    logmu = log(mean(lZ)) + mx;
    
    % compute standard deviation of likelihood
    ll0 = ll - repmat(logmu, rows(ll), 1);
    l0 = exp(ll0);
    sigma = std(l0);
    
    logmu = logmu';
    sigma = sigma';
    
    % support points
    X = [ nc{'EPg'}(1:M:end) nc{'VPg'}(1:M:end) ];
        
    % krig likelihood noise
    meanfunc = @meanZero;
    covfunc = @covSEiso; ell = 1/4; sf = 1; hyp.cov = log([ell; sf]);
    likfunc = @likGauss; sn = 1.0; hyp.lik = log(sn);
    
    hyp = minimize(hyp, @gp, -200, @infExact, meanfunc, covfunc, likfunc, ...
                   X, sigma);
   
    % find peaks and troughs
    N = 50;
    mx = X(randi(rows(X), N, 1),:);
    for i = 1:N
        mx(i,:) = fmins('maxgp', mx(i,:), [], [], hyp, @infExact, meanfunc, ...
            covfunc, likfunc, X, sigma);    
    end
    
    mn = X(randi(rows(X), N, 1),:);
    for i = 1:N
        mn(i,:) = fmins('mingp', mn(i,:), [], [], hyp, @infExact, meanfunc, ...
            covfunc, likfunc, X, sigma);    
    end

    % surface
    x = linspace(min([0.0 mn(1,:)])-0.1, max([1.0 mx(1,:)]+0.1), 50);
    y = linspace(min([0.0 mn(2,:)])-0.1, max([0.5 mx(2,:)]+0.1), 50);
    [XX YY] = meshgrid(x, y);
    Z = [ XX(:) YY(:) ];
    [m s2] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, X, sigma, Z);

    % plot
    ZZ = reshape(m, size(XX));
    contourf(XX, YY, ZZ);
    hold on;
    plot(mn(:,1), mn(:,2), 'ow');
    plot(mx(:,1), mx(:,2), 'ok');
    hold off;
end
