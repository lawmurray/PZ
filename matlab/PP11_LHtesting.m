%A Very Simple Lotka-Volterra Predator-Prey Model.
%Adapted for phytoplankton-zooplankton interaction.

clear all
global a np

ndays=200;
dt=1;
t(1)=0;
nsteps=ndays/dt;


%The synthetic dataset
load JP_synobs2.txt
synobs_m=JP_synobs2;
t_obs=synobs_m(:,1);
P_obs=synobs_m(:,2);
Z_obs=synobs_m(:,3);

%Number of particles
np=200;

%Number of MCMC iterations
nhe=2000;

%Set the sampler
MH=1; %MH Particle filter
SIR=0; %SIR particle filter

%Initial Conditions
t(1)=0;

m_i=0.2;
s_i=0.15;
s_obs=0.2;

m_prop=0.02;
s_prop=0.01;

tic
c4=1;
c5=1;
for zz=1:nhe
c1=ones(np,1);
c2=1;

P=1+randn(np,1)*s_obs;
Z=1+randn(np,1)*s_obs;

if zz==1
    m(zz)=m_i;
    s(zz)=s_i;
    m_n=m_i;
    s_n=s_i;
else
    c3=1;
    while c3==1
        m_n=m(zz-1)+randn(1)*m_prop;
        s_n=s(zz-1)+randn(1)*s_prop;
        if m_n>0
            if s_n>0
                c3=0;
            end
        end
    end
end

%m_n=0.25;
%s_n=0.1;
m_h(zz)=m_n;
s_h(zz)=s_n;


for i=1:np
    phygrow(i,1)=randn(1)*s_n+m_n;
end

for t=2:nsteps
    day(t)=t*dt-dt;
    
    
    if rem(t*dt,1)==0
        for i=1:np
            c1(i)=c1(i)+1;
            phygrow(i,c1(i))=randn(1)*s_n+m_n;           
        end
        p=ceil(np.*rand(np,1));
    end
        
    
    
    if abs((day(t)-t_obs(c2)))<0.001
        a=phygrow(:,c1(1));
        [T,Y] = ode23(@lotka4,[0 dt],[P(p); Z(p)]');
        nrecs=length(T);
        P_test=Y(nrecs,1:np);
        Z_test=Y(nrecs,np+1:2*np);
        
        P_obs_std=(s_obs);
        state_obs=P_obs(c2);
        
        L_test=exp(-1/2*(log(P_test/state_obs)/P_obs_std).^2);
        
        if MH==1;
            %P(1)=median(P_test);
            %Z(1)=median(Z_test);
            
            particle=randi(np);
            
            P(1)=P_test(particle);
            Z(1)=Z_test(particle);
            
            for i=1:np
                L_old(i)=exp(-1/2*(log(P(i)/state_obs)/P_obs_std)^2);
                L(i)=L_test(i)/L_old(i);
                alpha(i,c2)=min(1,L(i));
                z=rand(1);
                if z<=alpha(i,c2)
                    %acceptance(zz,i,c2)=1;
                    P(i+1)=P_test(i);
                    Z(i+1)=Z_test(i);
                else
                    %acceptance(zz,i,c2)=0;
                    P(i+1)=P(i);
                    Z(i+1)=Z(i);
                end
            end
        end
        
        if SIR==1;
            multinomial=1;
            strat=0;
            
            if multinomial==1
                c10=1;
                L_norm=(L_test/sum(L_test));
                [X,Y]=multrnd(np,L_norm); 
                for i=1:np
                    ndraws=X(i);
                    for j=1:ndraws
                        P(c10)=P_test(i);
                        Z(c10)=Z_test(i);
                        c10=c10+1;
                    end
                end
            end
            
            if strat==1
                W=cumsum(L_test);
            end
            
        end

        P_filter(:,i)=P;
        Z_filter(:,i)=Z;
        
        %mean_L(zz,c2)=mean(L);
        mean_Ltest(zz,c2)=mean(L_test);
        c2=c2+1;
    end
end

xbar=mean(P_test);
ybar=P_obs(1:ndays);
diff=(log(ybar)-log(xbar'));

SSQ=sum(diff(2:ndays).^2);

CP=cumprod(mean_Ltest(zz,:));
L_h(zz)=CP(ndays-1)
if zz>1
    L_h_rat(zz-1)=L_h(zz)/L_h(c4);
    if L_h_rat(zz-1)>rand(1)
        m(zz)=m_n;
        s(zz)=s_n;
        c4=zz;
        hp_a(zz-1)=1;
        phyto(c5,:,:)=P_filter;
        zoo(c5,:,:)=Z_filter;
        c5=c5+1;
    else
        m(zz)=m(zz-1);
        s(zz)=s(zz-1);
        hp_a(zz-1)=0;
    end
    int_data=[m_n,s_n,hp_a(zz-1)]
end
percent_complete=(zz/nhe)*100
end

for t=1:ndays-1
    Ptemp(:,:)=phyto(:,:,t);
    Prs=reshape(Ptemp,(c5-1)*np,1);
    Pmed(t)=median(Prs);
    [Pu(t),Pl(t)]=CI95(Prs);
    
    Ztemp(:,:)=zoo(:,:,t);
    Zrs=reshape(Ztemp,(c5-1)*np,1);
    Zmed(t)=median(Zrs);
    [Zu(t),Zl(t)]=CI95(Zrs);
    
end

clear phyto zoo

toc

save PP11_results_newrun2.mat








    
