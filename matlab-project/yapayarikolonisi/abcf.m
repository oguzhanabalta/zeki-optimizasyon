function [bestx,bestf,itn] = abcf(f,d,sn,limit,maxit,eps,xmaps)
%bestx=eniyikaynak 
%bestf=eniyikaynaðýn uygunluk deðeri
%sn=kaynak sayýsý ile gözcü arý sayýsý birbirine eþit olur
%d=problem boyutu
%limit=kaynaðýn tükenip tükenmediðini kontrol eden parametre
%eps=algoritmayý durdurmak için hata toleransý
%f=optimize edileceek fonksiyon
%xmaps=deðiþkenlerin taným aralýðý
%itn: uygulanan iterasyon sayýsý
dk=0; itn=0;
%baslangic pozisyonlarý üretimi
%-xmaps ve xmaps arasýnda baþlangýç pozisyonlarý üretirlir.
X=unifrnd(-xmaps, xmaps,sn,d);%kaynak sayýsý satýrý kadar problem boyutu sütunu kadar
%baslangictaki kaynaklarýn fail indexleri
fail=zeros(sn,1);

%f=@(x) 100*(x(2)-x(1).^2)^.2+(1-x(1).^2).^2+x(3).^2-x(4).^2

%uygunluk deðerlerini hesaplayalým
fit=ones(sn,1);
for i=1:sn
    fit(i)=f(X(i,:));
end

j=find(fit==min(fit)); j=j(1);
bestx=X(j,:); %en iyi kaynak hafýzaya alindi
bestf=fit(j); %en iyi kaynaðýn uygunluk deðeri

%iterasyonlar baþlatýlýyor
for i=1:maxit
    %iþçi arý/görevli arý aþamasý
    for i1=1:sn %kaynak sayýsý kadar iþçi arý görevlendireceðimiz için
        %i1 artýk iþçi arý için dönen döngü
        %komþu kaynak rasgele belirlensin artýk i1 olamaz bu yüzden while
        i2=unidrnd(sn);
        while(i1==i2)
            i2=unidrnd(sn);
        end
        %kaynaklar rastgele bir pozisyon seçer
        i3=unidrnd(d);
        %yeni bir pozisyon üretilmesi
        xy=X(i1,i3)+unidrnd(-1,1)*(X(i1,i3)- X(i2,i3)); %komþu kaynak ile mevcut kaynaðýn pozisyonlarý
        Xnew=X(i1,:);
        Xnew(i3)=xy; %xnep in i3. pozisyonuna xy'yi atiyoruz
        %yeni kaynaðýn uygunluk deðeri
        newfit=f(Xnew);
        
        if newfit<fit(i1)
            X(i1,:)=Xnew;
            fit(i1)=newfit;
            fail(i1)=0;
        else
            fail(i1)=1+fail(i1);
        end
    end %iþçi arý endi
    
    %olasýlýk hesaplanýr
    P=(1./fit)/sum(1./fit);
    KP=cumsum(P);
    for j=1:sn
        %Gözcü kaynaðýn seçilmesi
        rnd=rand; %0 ile 1 arasýnda bir sayý üretir
        for j1=1:sn
            if rnd<KP(j1)
                i1=j1;
                break
            end
        end
        %komþu kaynak seçilmesi
        i2=unidrnd(sn);
        while(i1==i2)
            i2=unidrnd(sn);
        end
        %Kaynaktan rastgele bir pozisyon seçiyorum
        i3=unidrnd(d);
        %yeni bir pozisyon üretilmesi
        xy=X(i1,i3)+unifrnd(-1,1)*(X(i1,i3)-X(i2,i3)); %komsu kaynak ile mevcut kaynaðýn pozisyonlarý arasýndaki fark
        
        Xnew=X(i1,:);
        Xnew(i3)=xy; %Xnew in 3. pozisyonu
        
        %Yeni kaynaðýn uygunluk deðeri
        newfit=f(Xnew);
        
        if newfit<fit(i1)
            X(i1,:)=Xnew;
            fit(i1)=newfit;
            fail(i1)=0;
        else
            fail(i1)=1+fail(i1);
        end
    end %gözcü arý iþlemleri for'u
    
    %En iyi kaynaðýn uygunluk deðerini hafýzaya al
    bestf_eski=bestf;
    j=find(fit==min(fit)); j=j(1);
    bestx=X(j,:); %en iyi kaynak hafýzaya alýndý
    bestf=fit(j);
    
    
    itn=i;
    %Durdurma kriteri kontrol edilsin
    if(bestf_eski-bestf)<eps
        dk=dk+1;
    else
        dk=0;
    end
    
    if dk>=10
        itn=1;
        break;
    end
    %kaþif arý aþamasý
    
    %her bir kaynak için fail indeksleri kontrol edilir
    %eðer fail indeksleri limitlerin üzerine çýmmýþsa alg durdurulur
    
    for j=1:sn
        if fail(j)>limit
            X(j,:)=unifrnd(-xmaps,xmaps,1,d);
            fail(j)=0;
        end
    end
    
    
end %iterasyon endi
end %fonksiyonun endi

    
    %[bestx,bestf,itn] = abcf(f,4,30,100,100,10^-4,3)
