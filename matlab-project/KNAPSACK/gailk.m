clc
clear
close all;
%% definition of the problem
%h
model=createmodel();
costfunction=@ (x) mycost(x, model);
Nvar=model.n; %number of variables - x vektörünün elemanı
%%
Npop=20;
birey.pozisyon=[];
birey.maliyet=[];
birey.solution=[];
%h 


% Öyle bir birey bul ki maliyeti düşük olsun.
pop =repmat(birey, Npop,1); % birey i çoğaltıyoruz.
% Popülasyonun rastgele üretmesini istiyoruz.

for i=1:Npop
    pop(i).pozisyon = randi([0 1], 1, Nvar); % 1 satır Nvar sütun olacak şekilde ya 0 ya 1 olacak şekilde sayılar üret 
    [pop(i).maliyet pop(i).solution]= costfunction(pop(i).pozisyon);
end

% Bu toplulukta en iyi maliyet nedir? pop.maliyet ile tüm maliyeti görürüz.
% sort([pop.maliyet])
%Toplumun maliyetini de bir yerde kaydedelim.
%%
cost =[pop.maliyet];
[cost y]=sort([pop.maliyet]); % x de maliyet olur, y de hangi elemanın o maliyete sahip olduğu
%x yerine cost yazdık.
%%
%y=y(:);
pop=pop(y); %pop da benim en iyim

best.sol=pop(1); % Buraya kadarki en opt cevabı da best.sol da kaydetmiş olduk.

%% main loop
iterasyon=100;
pc=0.7; % probability of crossover = çaprazlama oranı %70 kişilere bu işlem yapılsın
Npopc= round(Npop/2*pc);

pm=0.5;
Npopm = round(Npop*pm);
for it=1:iterasyon
    %crossover - Kaç kişi üzerinde çaprazlama yapılacak.
    %crossover sonucunu yazmak için boş matrisler oluşturuyoruz.
    %çaprazlama oranı çok yüksek olursa başlangıçta iyi çözüm veren
    %bir kromozom varsa onu yok etmeye çalışır.
    popc=repmat(birey,Npop/2,2); %25 satırdan ve 2 sütundan oluşan çaprazlama popülasyonu
    
    for k=1:Npop/2
        %selection rastgele yapılacak - turnuva ve rulet tekerleği
        i1=randi([1 Npop]);
        pop1=pop(i1);

        i2=randi([1 Npop]);
        pop2=pop(i2);

        [popc(k,1).pozisyon popc(k,2).pozisyon]= singlepointcrossover(pop1.pozisyon, pop2.pozisyon);
        %Yeni kromozomların maliyetleri de hesaplandı ve kaydedildi.
        [popc(k,1).maliyet popc(k,1).solution]= costfunction(popc(k,1).pozisyon);
        [popc(k,2).maliyet popc(k,2).solution]= costfunction(popc(k,2).pozisyon);
    end
        %popc nin de tek sütunda gözükmesini istersek
    popc=popc(:);
    
    %mutasyon - 
    popm=repmat(birey,Npop,1);

    for j=1:Npopm
        %selection rastgele
         i1=randi([1 Npop]);
         pop1=pop(i1);

         popm(j).pozisyon = mutation(pop1.pozisyon);
         [popm(j).maliyet popm(j).solution]= costfunction(popm(j).pozisyon);
    
    end


    pop= [pop
        popc
        popm];


   cost =[pop.maliyet];
   [cost y]=sort(cost); % x de maliyet olur, y de hangi elemanın o maliyete sahip olduğu

pop=pop(y); %pop da benim en iyim

best.sol(it)=pop(1); 


% Delete - kötü cevaplara ihtiyacımız yok
pop=pop(1:Npop); 
bestcost(it)=best.sol(it).maliyet;

end

figure;
plot(bestcost);
xlabel('iterasyon');
ylabel('Best sol');
%semilogx(bestcost);


