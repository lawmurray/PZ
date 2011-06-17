nc = netcdf('results/likelihood_disturbance.nc.0', 'r');
ll = nc{'loglikelihood'}(:);
ll = sort(reshape(ll, 50, length(ll)/50));

mx = max(ll);
ll -= repmat(mx, rows(ll), 1);
l = exp(ll);
logmu = log(mean(l)) + mx;

[xs,js] = sort(logmu);
ll = ll(:,js);
figure(4);
imagesc(ll);
colorbar;

ll += repmat(mx - logmu, rows(ll), 1);
l = exp(ll);
sigma = std(l);
