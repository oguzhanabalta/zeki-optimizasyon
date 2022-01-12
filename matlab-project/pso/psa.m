function [sbestpos sbestval] = psa(as,us,d,ssize, w, c1, c2)


%Rastgee s�r�(pop�lasyon) olu�turulur.
swarm = unifrnd(as,us,[ssize,d])

%Ama� fonksiyonu tan�mlanmas� ve de�erlerinin atanmas�
obj=zeros(ssize,1);
for i=1:ssize
    obj(i)=sum(swarm(i,:).^2);
end
%h�z
velocity=zeros(ssize,d);%h�z
pbestpos=swarm;%par�ac�klar�n en iyi pozisyonu
pbestval=obj;%bunlar�n en iyi de�erleri, ilk oldu�u i�in
%ama� fonksiyonlar�n�n en k�����
sbestval=min(obj);

idx=find(sbestval==obj);%value bul
sbestpos=swarm(idx,:);%swarm i�inde pozisyonu bul sat�r�,

iterasyon=1;
while(iterasyon<50)
%H�z g�ncellemesi
%Birinci b�l�m :Par�ac���n eylemsizli�ini korumak istemesi
%ikinci b�l�m:Par�ac���n kendi en iyisine do�ru gitmek istemesi
%���nc� b�l�m: Par�ac���n s�r�n�n en iyisine gitmek istemesi
for i=1:ssize
    velocity(i,:)=w*velocity(i,:) ...
    +c1*unifrnd(0,1)*(pbestpos(i,:)-swarm(i,:)) ...
    +c2*unifrnd(0,1)*(sbestpos-swarm(i,:)); 
end

vmax=(us-as)/2;
for i=1:ssize
    for j=1:d
        if(velocity(i,j)>vmax)
            velocity(i,j)=vmax;
        elseif(velocity(i,j)<-vmax)
            velocity(i,j)=-vmax;
        end
    end
end
%S�r�n�n pozisyon g�ncellenmesi
swarm=swarm+velocity;

for i=1:ssize
    for j=1:d
        if(swarm(i,j)>us)
            swarm(i,j)=us;
        elseif(velocity(i,j)<as)
            swarm(i,j)=as;
        end
    end
end

for i=1:ssize
    obj(i)=sum(swarm(i,:).^2)
end
 iterasyon=iterasyon+1;
end 
end

