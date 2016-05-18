clc

E_tot=40; % Дж
ro_0=2700; %kg/m^3
V_prov=0.01.*0.01.*7.*0.000001; %m^3
m_prov=ro_0.*V_prov; %kg
E_ud=E_tot/m_prov;
G=2; % параметр Грюнайзена
P_0=G.*ro_0.*E_ud;


n_max=5000; % количество шагов по времени
i_max=300;  % количество шагов по координате 

%n_max и i_max подбираются такие, чтобы выполнялась устойчивость метода

dt=2.5*(1e-06)/n_max;   % размер шага по времени
dl=(2e-03)/i_max;       % размер шага по времени по пространству

ro=zeros(n_max,i_max);
ro_prom=zeros(n_max,i_max);
v=zeros(n_max,i_max);
v_prom=zeros(n_max,i_max);
E=zeros(n_max,i_max);
E_prom=zeros(n_max,i_max);
P=zeros(n_max,i_max);
dM_pered=zeros(n_max,i_max);
dM_posle=zeros(n_max,i_max);
P_pered=zeros(n_max,i_max);
P_posle=zeros(n_max,i_max);
ro(1,2)=ro_0;
ro(1,3)=ro_0;
E(1,2)=E_ud/2;
E(1,3)=E_ud/2;

ro(1,1)=ro(1,2);
v(1,1)=-v(1,2);
E(1,1)=E(1,2);

k=2;     

for n=1:n_max-1
 
        if n>1
        ro(n,1)=ro(n,2);
        v(n,1)=-v(n,2);
        E(n,1)=E(n,2);
        end    
        
        for i=2:i_max-1
        ro_prom(n,i)=ro(n,i);
        if(P(n,i)==0)
        P(n,i)=G*ro(n,i)*(E(n,i));
        end
        if(P(n,i+1)==0)
        P(n,i+1)=G*ro(n,i+1)*(E(n,i+1));
        end
        if(P(n,i-1)==0)
        P(n,i-1)=G*ro(n,i-1)*(E(n,i-1));
        end

        P(n,1)=P(n,2);
        P_pered(n,i)=(P(n,i)+P(n,i-1))/2;
        P_posle(n,i)=(P(n,i+1)+P(n,i))/2;

        if ro(n,i)==0        
            v_prom(n,i)=0;
            E_prom(n,i)=0;
        else
            
             if((abs(ro(n,i))<K(k,n,ro))&&(i>k))        % Если плотность в ячейке много меньше допустимой плотности - 
                    v_prom(n,i)=0;                      % то пренебрегаем энергией и скоростью в этой ячейке.
                     E_prom(n,i)=0;                     % Это делается для сохранения устойчивости метода.
                    if((ro(n,i-1)~=0)&&(ro(n,i+1)==0))  % Такой подход обосновывается тем, что
                         k=i-1;                         % масса перетекающая в соседнюю ячейку
                    end                                 % должна быть сравнима с массой
                                                        % находящейся в этой ячейке.
            else
            v_prom(n,i)=v(n,i)-(P_posle(n,i)-P_pered(n,i)).*(dt/(dl.*ro(n,i)));
            E_prom(n,i)=E(n,i)-(P_posle(n,i).*((v(n,i)+v(n,i+1))/2)-P_pered(n,i).*((v(n,i)+v(n,i-1))/2)).*(dt/(dl.*ro(n,i)));  
            if(E_prom(n,i)<0)
                E_prom(n,i)=abs( E_prom(n,i));
            end
        end  
        end
        end
    
        v_prom(n,1)=-v_prom(n,2);
        
    for i=2:i_max-1

        if v_prom(n,i)+v_prom(n,i+1)==0
            dM_posle(n,i)=0;
        else
            if v_prom(n,i)+v_prom(n,i+1)>=0 
                dM_posle(n,i)=ro(n,i)*dt*(v_prom(n,i)+v_prom(n,i+1))/2;
              
            else
                dM_posle(n,i)=ro(n,i+1)*dt*(v_prom(n,i)+v_prom(n,i+1))/2;
                 
            end
        end
        if v_prom(n,i-1)+v_prom(n,i)==0
            dM_pered(n,i)=0;
        else    
            
                dM_pered(n,1)=0;
            
                if v_prom(n,i-1)+v_prom(n,i)>=0
                    dM_pered(n,i)=ro(n,i-1)*dt*(v_prom(n,i-1)+v_prom(n,i))/2;
                   
                else 
                    dM_pered(n,i)=ro(n,i)*dt*(v_prom(n,i-1)+v_prom(n,i))/2;
                   
                end
   
            
        end
        if dM_pered(n,i)>=0 
                    v_prom_pered(n,i)=v(n,i-1);
                    E_prom_pered(n,i)=E(n,i-1);
            else
                v_prom_pered(n,i)=v(n,i);
                E_prom_pered(n,i)=E(n,i);
        end
        
        if dM_posle(n,i)>=0
            v_prom_posle(n,i)=v(n,i);
            E_prom_posle(n,i)=E(n,i);
        else
            v_prom_posle(n,i)=v(n,i+1);
            E_prom_posle(n,i)=E(n,i+1);
        end
    end
    for i=2:i_max-1
        RR=(dM_pered(n,i)-dM_posle(n,i))/dl;
        ro(n+1,i)=ro_prom(n,i)+RR;

        if ro(n+1,i)==0
        v(n+1,i)=0; 
        E(n+1,i)=0; 
        else   
            if(((abs(ro(n+1,i)))<K(k,n,ro))&&(i>k))
              v(n+1,i)=0;
              E(n+1,i)=0; 
              if((ro(n,i-1)~=0)&&((ro(n,i+1)==0))) 
                         k=i-1;     
                    end   
            else          
             v(n+1,i)=v_prom(n,i)+dM_pered(n,i).*v_prom_pered(n,i)/(ro(n+1,i).*dl)-dM_posle(n,i).*v_prom_posle(n,i)/(ro(n+1,i).*dl);
             E(n+1,i)=E_prom(n,i)+dM_pered(n,i).*E_prom_pered(n,i)/(ro(n+1,i).*dl)-dM_posle(n,i).*E_prom_posle(n,i)/(ro(n+1,i).*dl); 
            end
        end
    end
end
sum_ro=zeros(n_max);
sum_E=zeros(n_max);
for i=1:n_max
    for j=2:i_max
        sum_ro(i)=sum_ro(i)+ro(i,j);
        sum_E(i)=sum_E(i)+E(i,j);
    end
end
x=zeros(1,i_max);
for i=2:i_max
x(i)=(i-1)*dl;
end
y=zeros(1,n_max);

for i=1:n_max
y(i)=i*dt;
end
figure
ro_xfix_in_p(10,dl,y,ro);

figure
ro_xfix_in_p(200,dl,y,ro);

figure
ro_xfix_in_p(290,dl,y,ro);

figure
ro_tfix_in_p(200,dt,x,ro);

figure
ro_tfix_in_p(800,dt,x,ro);

figure
ro_tfix_in_p(1334,dt,x,ro);

figure
ro_tfix_in_p(2000,dt,x,ro);

 figure
P_xfix_in_p(50,dl,y,P);

 figure
P_xfix_in_p(200,dl,y,P);

 figure
P_xfix_in_p(299,dl,y,P);

 figure
P_tfix_in_p(100,dt,x,P);

figure
P_tfix_in_p(1000,dt,x,P);

figure
P_tfix_in_p(3000,dt,x,P);

figure
v_xfix_in_p(50,dl,y,v);

figure
v_xfix_in_p(200,dl,y,v);
figure
v_xfix_in_p(299,dl,y,v);

figure
v_tfix_in_p(100,dt,x,v);

figure
v_tfix_in_p(1000,dt,x,v);
figure
v_tfix_in_p(3000,dt,x,v);



