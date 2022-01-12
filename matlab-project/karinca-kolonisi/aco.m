
ss=input('sehir sayisi:');

%%problemin tan�mlanmas�
model=Createmodel(ss);

%%ACO parametreleri
maxIt=30; %iterasyon say�s�
nAnt=40;  %kar�nca say�s�
Q=1;

tau0=0.1;  %baslangic feromon

alpha=1; %feromon kuvvetlendirme oran�
%feromon kuvvetlendirme oran(alfa):d���mler aras�ndaki feromon m�ktarlarn�n
%�nem derecesini belirleyeb parametredir.

beta=0.02; %heuristic exp a��rl�k,sezgisellik 
%sezgisellik kuvvetlendirme oran�(beta):d���mler aras�ndaki mesafenin �nem
%derecesinin belirleyen parametredir.

rho=0.05; %buharla�ma oran�
%feromon buharla�ma oran�(p):her iterasyon sonunda d���mler aras�ndaki
%feromonlar�n hangi oranda buharla�aca��n� belirleyen parametredir.

%ba�lang��
eta=1./model.D; %heuristik bilgi matrisi

tau=tau0*ones(model.n,model.n);%feromon matrisi:tau yu matris haline getirdik.
%her eleman� 0.1 olan bir matris

BestCost=zeros(maxIt,1); %en iyi ��z�m

%bo� kar�nca
empty_ant.Tour=[];
empty_ant.Cost=[];

%kar�nca koloni matrisi
ant=repmat(empty_ant,nAnt,1);

%en iyi kar�nca
BestSol.Cost=inf;

%%ACO main dongu
for it=1:maxIt
    
%bu alanda her bir kar�nca i�in yol olu�turularak,yol olu�turuluren bir
%sonraki �ehir p olas�l���na g�re rulet �ark� y�ntemine g�re
%se�iliyor.yollar�n maliyetleri hesaplan�yor.
for k=1:nAnt
    ant(k).Tour=unidrnd(model.n);
    %birinci �ehir se�ildikten sonra ikinci �ehir nas�l se�ilecek
    for l=2:model.n
        i=ant(k).Tour(end);
        P=tau(i,:).^alpha.*eta(i,:).^beta;
        P(ant(k).Tour)=0;%ayn� �ehire gitme ihtimalim 0
        P=P/sum(P);
        j=RouletteWheelSelection(P);
        ant(k).Tour=[ant(k).Tour j]; %di�er �ehir de tura eklenmi� oldu
    end
    ant(k).Cost=TourLength(ant(k).Tour,model);%di�er �ehre ge�ti�imize g�re maliyeti hesaplayabiliriz
    
    if ant(k).Cost<BestSol.Cost
        BestSol=ant(k);
    end
end

%update feromon
%bir �ehirden di�er �ehre gidilince feromon b�rak�ld��� i�in feromonu
%g�ncellemek ve buharla�ma oran� ile kokuyu azaltman�z gerekir.
%feromon de�erlerini g�ncelle�tirilir.
for k=1:nAnt %her bir kar�nca i�in
    tour=ant(k).Tour;
    tour=[tour tour(1)];
    
    for l=1:model.n %ka� �ehir var
        
        i=tour(l);
        j=tour(l+1);
        
        tau(i,j)=tau(i,j)+Q/ant(k).Cost; %feromon g�ncelleme form�l�,
        %maliyeti az olan yol feromon de�erini daha fazla artt�racakt�r.
        
    end
end

%feromon buharla�t�r
tau=(1-rho)*tau;

%en iyi ��z�m
BestCost(it)=BestSol.Cost;
disp(['Iter' num2str(it) ': En iyi cozum=' num2str(BestCost(it))]);


end %maxit nin end

figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;


