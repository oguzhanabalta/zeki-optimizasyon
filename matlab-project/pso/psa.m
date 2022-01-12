function [sbestpos sbestval] = psa(as,us,d,ssize, w, c1, c2)


%Rastgee sürü(popülasyon) oluþturulur.
swarm = unifrnd(as,us,[ssize,d])

%Amaç fonksiyonu tanýmlanmasý ve deðerlerinin atanmasý
obj=zeros(ssize,1);
for i=1:ssize
    obj(i)=sum(swarm(i,:).^2);
end
%hýz
velocity=zeros(ssize,d);%hýz
pbestpos=swarm;%parçacýklarýn en iyi pozisyonu
pbestval=obj;%bunlarýn en iyi deðerleri, ilk olduðu için
%amaç fonksiyonlarýnýn en küçüðü
sbestval=min(obj);

idx=find(sbestval==obj);%value bul
sbestpos=swarm(idx,:);%swarm içinde pozisyonu bul satýrý,

iterasyon=1;
while(iterasyon<50)
%Hýz güncellemesi
%Birinci bölüm :Parçacýðýn eylemsizliðini korumak istemesi
%ikinci bölüm:Parçacýðýn kendi en iyisine doðru gitmek istemesi
%Üçüncü bölüm: Parçacýðýn sürünün en iyisine gitmek istemesi
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
%Sürünün pozisyon güncellenmesi
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

