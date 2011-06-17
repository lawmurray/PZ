% output setup
figure(1, "visible", "off");
set (0, "defaultaxesfontname", "Helvetica")
set (0, "defaultaxesfontsize", 10)
set (0, "defaulttextfontname", "Helvetica")
set (0, "defaulttextfontsize", 10) 

u = dlmread('results/gpr_u.csv')';
P = dlmread('results/gpr_P.csv');
Z = dlmread('results/gpr_Z.csv');
P_mu = P(:,1);
P_sigma = P(:,2);
Z_mu = Z(:,1);
Z_sigma = Z(:,2);

p = [0.025 0.5 0.975]; % quantiles (median and 95%)
PQ = zeros(length(u), length(p));
ZQ = zeros(length(u), length(p));
for n = 1:length(u)
    PQ(n,:) = logninv(p, P_mu(n), P_sigma(n));
    ZQ(n,:) = logninv(p, Z_mu(n), Z_sigma(n));
end

subplot(1, 4, 1);
area_between(u(1:100), PQ(1:100,1), PQ(1:100,3), watercolour(2, 0.5));
hold on
area_between(u(100:end), PQ(100:end,1), PQ(100:end,3), watercolour(4, 0.5));
plot(u(1:100), PQ(1:100,2), 'linewidth', 3, 'color', watercolour(2));
plot(u(100:end), PQ(100:end,2), '-', 'linewidth', 3, 'color', watercolour(4));
title('P');
%plot_obs('data/obs.nc', {'P_obs'});
plot_defaults;
axis tight;

subplot(1, 4, 2);
area_between(u(1:100), ZQ(1:100,1), ZQ(1:100,3), watercolour(2, 0.5));
hold on
area_between(u(100:end), ZQ(100:end,1), ZQ(100:end,3), watercolour(4, 0.5));
plot(u(1:100), ZQ(1:100,2), 'linewidth', 3, 'color', watercolour(2));
plot(u(100:end), ZQ(100:end,2), '-', 'linewidth', 3, 'color', watercolour(4));
title('Z');
%plot_obs('data/obs.nc', {'Z_obs'});
plot_defaults;
axis tight;

subplot(1, 4, 3);
%plot_simulate('results/simulate.nc.0', {'P'});
plot_mcmc('results/mcmc.nc.0', {'P'});
plot_predict('results/predict.nc.0', {'P'});
%plot_obs('data/obs.nc', {'P_obs'});

subplot(1, 4, 4);
%plot_simulate('results/simulate.nc.0', {'Z'});
plot_mcmc('results/mcmc.nc.0', {'Z'});
plot_predict('results/predict.nc.0', {'Z'});
%plot_obs('data/obs.nc', {'Z_obs'});

% print
papersize = get(gcf, "papersize");
papersize = [ papersize(1) 0.25*papersize(2) ];
border = 0;
set (gcf, "paperposition", [border, border, (papersize - 2*border)])
print -color -deps 'compare.eps';
system('epstopdf compare.eps');
