function dy = lotka4(t,y)
    global a np
    c=0.25;
    e=0.3;
    ml=0.1;
    mq=0.1;
    dy = zeros(2*(np-1),1);
    c1=1;
    c2=1;
    P=y(1:np);
    Z=y(np+1:np*2);
    for i=1:(np)
        dy(c1)=a(c2)*P(i)-c*P(i)*Z(i);
        c1=c1+1;
        c2=c2+1;
    end
    
    for i=1:(np)
        dy(c1)=c*e*P(i)*Z(i)-ml*Z(i)-mq*Z(i)^2;
        c1=c1+1;
    end
    
        
