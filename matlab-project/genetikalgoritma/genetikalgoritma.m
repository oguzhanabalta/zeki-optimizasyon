costfunction=@(x) toplam(x);
Npop=50; %popülasyon 50 bireyden oluþur.
Nvar=10; %her kromozom 10genden oluþacak

birey.pozisyon=[];
birey.maliyet=[];


pop=repmat(birey, Npop, 1); %repmat kopyalama iþlemi yapar. Birey ver, yapýsýný Npop satýr sayýsýnca ve 1 sütýnlu bir þekilde 50 kere çoðaltýr.

for i=1:Npop
    pop(i).pozisyon=randi([0,1],1, Nvar); %randi 0ve1 den rastgele seçim yaparak 1 satýr 10 sütunlu bir vektör oluþturur.
    pop(i).maliyet=costfunction(pop(i).pozisyon);
    
end

cost=[pop.maliyet];
[cost y] = sort(cost);
pop=pop(y);
best=pop(1);


%Crossover and Mutation
iterasyon=100;
pc=0.7;
Npopc=round(Npop/2+pc); %çaprazlama yaptýktan sonraki popülasyonun içerdiði birey sayýsý

pm=0.5;
Npopm=round(Npop+pm);%mutasyon yaptýktan sonraki popülasyonnun içerdiði birrey sayýsý


for it=1:iterasyon
   %crossover - çaprazlama
    popc=repmat(birey, Npop/2, 2);
    for k=1:Npop/2
        i1=randi([1 Npop]); %rastgele selection(seçim)
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
