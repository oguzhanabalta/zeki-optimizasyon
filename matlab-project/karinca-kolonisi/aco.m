
ss=input('sehir sayisi:');

%%problemin tanýmlanmasý
model=Createmodel(ss);

%%ACO parametreleri
maxIt=30; %iterasyon sayýsý
nAnt=40;  %karýnca sayýsý
Q=1;

tau0=0.1;  %baslangic feromon

alpha=1; %feromon kuvvetlendirme oraný
%feromon kuvvetlendirme oran(alfa):düðümler arasýndaki feromon mþktarlarnýn
%önem derecesini belirleyeb parametredir.

beta=0.02; %heuristic exp aðýrlýk,sezgisellik 
%sezgisellik kuvvetlendirme oraný(beta):düðümler arasýndaki mesafenin önem
%derecesinin belirleyen parametredir.

rho=0.05; %buharlaþma oraný
%feromon buharlaþma oraný(p):her iterasyon sonunda düðümler arasýndaki
%feromonlarýn hangi oranda buharlaþacaðýný belirleyen parametredir.

%baþlangýç
eta=1./model.D; %heuristik bilgi matrisi

tau=tau0*ones(model.n,model.n);%feromon matrisi:tau yu matris haline getirdik.
%her elemaný 0.1 olan bir matris

BestCost=zeros(maxIt,1); %en iyi çözüm

%boþ karýnca
empty_ant.Tour=[];
empty_ant.Cost=[];

%karýnca koloni matrisi
ant=repmat(empty_ant,nAnt,1);

%en iyi karýnca
BestSol.Cost=inf;

%%ACO main dongu
for it=1:maxIt
    
%bu alanda her bir karýnca için yol oluþturularak,yol oluþturuluren bir
%sonraki þehir p olasýlýðýna göre rulet çarký yöntemine göre
%seçiliyor.yollarýn maliyetleri hesaplanýyor.
for k=1:nAnt
    ant(k).Tour=unidrnd(model.n);
    %birinci þehir seçildikten sonra ikinci þehir nasýl seçilecek
    for l=2:model.n
        i=ant(k).Tour(end);
        P=tau(i,:).^alpha.*eta(i,:).^beta;
        P(ant(k).Tour)=0;%ayný þehire gitme ihtimalim 0
        P=P/sum(P);
        j=RouletteWheelSelection(P);
        ant(k).Tour=[ant(k).Tour j]; %diðer þehir de tura eklenmiþ oldu
    end
    ant(k).Cost=TourLength(ant(k).Tour,model);%diðer þehre geçtiðimize göre maliyeti hesaplayabiliriz
    
    if ant(k).Cost<BestSol.Cost
        BestSol=ant(k);
    end
end

%update feromon
%bir þehirden diðer þehre gidilince feromon býrakýldýðý için feromonu
%güncellemek ve buharlaþma oraný ile kokuyu azaltmanýz gerekir.
%feromon deðerlerini güncelleþtirilir.
for k=1:nAnt %her bir karýnca için
    tour=ant(k).Tour;
    tour=[tour tour(1)];
    
    for l=1:model.n %kaç þehir var
        
        i=tour(l);
        j=tour(l+1);
        
        tau(i,j)=tau(i,j)+Q/ant(k).Cost; %feromon güncelleme formülü,
        %maliyeti az olan yol feromon deðerini daha fazla arttýracaktýr.
        
    end
end

%feromon buharlaþtýr
tau=(1-rho)*tau;

%en iyi çözüm
BestCost(it)=BestSol.Cost;
disp(['Iter' num2str(it) ': En iyi cozum=' num2str(BestCost(it))]);


end %maxit nin end

figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;


