costfunction=@(x) toplam(x);
Npop=50; %pop�lasyon 50 bireyden olu�ur.
Nvar=10; %her kromozom 10genden olu�acak

birey.pozisyon=[];
birey.maliyet=[];


pop=repmat(birey, Npop, 1); %repmat kopyalama i�lemi yapar. Birey ver, yap�s�n� Npop sat�r say�s�nca ve 1 s�t�nlu bir �ekilde 50 kere �o�alt�r.

for i=1:Npop
    pop(i).pozisyon=randi([0,1],1, Nvar); %randi 0ve1 den rastgele se�im yaparak 1 sat�r 10 s�tunlu bir vekt�r olu�turur.
    pop(i).maliyet=costfunction(pop(i).pozisyon);
    
end

cost=[pop.maliyet];
[cost y] = sort(cost);
pop=pop(y);
best=pop(1);


%Crossover and Mutation
iterasyon=100;
pc=0.7;
Npopc=round(Npop/2+pc); %�aprazlama yapt�ktan sonraki pop�lasyonun i�erdi�i birey say�s�

pm=0.5;
Npopm=round(Npop+pm);%mutasyon yapt�ktan sonraki pop�lasyonnun i�erdi�i birrey say�s�


for it=1:iterasyon
   %crossover - �aprazlama
    popc=repmat(birey, Npop/2, 2);
    for k=1:Npop/2
        i1=randi([1 Npop]); %rastgele selection(se�im)
        pop1=pop(i1);
        
        i2=randi([1 Npop]);
        pop2=pop(i2);
        
        [popc(k,1).pozisyon, popc(k,2).pozisyon]=singlepointcrossover(pop1.pozisyon, pop2.pozisyon);
        popc(k,1).maliyet=costfunction(popc(k,1).pozisyon);
        popc(k,2).maliyet=costfunction(popc(k,2).pozisyon);
    end
   popc=popc(:);
   %mutation- mutasyon
   popm=repmat(birey, Npop, 1);
   
   for j=1:Npopm
      i1=randi([1 Npop]);
      pop1=pop(i1);
      
      popm(j).pozisyon=mutation(pop1.pozisyon);
      popm(j).maliyet=costfunction(popm(j).pozisyon);
   end
   pop=[pop
       popc
       popm];
   cost=[pop.maliyet];
   [cost y]= sort(cost);
   pop=pop(y);
   
   pop=pop(1:Npop);
   best.sol(it)=pop(1);
   
   bestcost(it)=best.sol(it).maliyet;
   
end
figure;
plot(bestcost);
