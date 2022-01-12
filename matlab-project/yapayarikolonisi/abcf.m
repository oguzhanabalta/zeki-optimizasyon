function [bestx,bestf,itn] = abcf(f,d,sn,limit,maxit,eps,xmaps)
%bestx=eniyikaynak 
%bestf=eniyikayna��n uygunluk de�eri
%sn=kaynak say�s� ile g�zc� ar� say�s� birbirine e�it olur
%d=problem boyutu
%limit=kayna��n t�kenip t�kenmedi�ini kontrol eden parametre
%eps=algoritmay� durdurmak i�in hata tolerans�
%f=optimize edileceek fonksiyon
%xmaps=de�i�kenlerin tan�m aral���
%itn: uygulanan iterasyon say�s�
dk=0; itn=0;
%baslangic pozisyonlar� �retimi
%-xmaps ve xmaps aras�nda ba�lang�� pozisyonlar� �retirlir.
X=unifrnd(-xmaps, xmaps,sn,d);%kaynak say�s� sat�r� kadar problem boyutu s�tunu kadar
%baslangictaki kaynaklar�n fail indexleri
fail=zeros(sn,1);

%f=@(x) 100*(x(2)-x(1).^2)^.2+(1-x(1).^2).^2+x(3).^2-x(4).^2

%uygunluk de�erlerini hesaplayal�m
fit=ones(sn,1);
for i=1:sn
    fit(i)=f(X(i,:));
end

j=find(fit==min(fit)); j=j(1);
bestx=X(j,:); %en iyi kaynak haf�zaya alindi
bestf=fit(j); %en iyi kayna��n uygunluk de�eri

%iterasyonlar ba�lat�l�yor
for i=1:maxit
    %i��i ar�/g�revli ar� a�amas�
    for i1=1:sn %kaynak say�s� kadar i��i ar� g�revlendirece�imiz i�in
        %i1 art�k i��i ar� i�in d�nen d�ng�
        %kom�u kaynak rasgele belirlensin art�k i1 olamaz bu y�zden while
        i2=unidrnd(sn);
        while(i1==i2)
            i2=unidrnd(sn);
        end
        %kaynaklar rastgele bir pozisyon se�er
        i3=unidrnd(d);
        %yeni bir pozisyon �retilmesi
        xy=X(i1,i3)+unidrnd(-1,1)*(X(i1,i3)- X(i2,i3)); %kom�u kaynak ile mevcut kayna��n pozisyonlar�
        Xnew=X(i1,:);
        Xnew(i3)=xy; %xnep in i3. pozisyonuna xy'yi atiyoruz
        %yeni kayna��n uygunluk de�eri
        newfit=f(Xnew);
        
        if newfit<fit(i1)
            X(i1,:)=Xnew;
            fit(i1)=newfit;
            fail(i1)=0;
        else
            fail(i1)=1+fail(i1);
        end
    end %i��i ar� endi
    
    %olas�l�k hesaplan�r
    P=(1./fit)/sum(1./fit);
    KP=cumsum(P);
    for j=1:sn
        %G�zc� kayna��n se�ilmesi
        rnd=rand; %0 ile 1 aras�nda bir say� �retir
        for j1=1:sn
            if rnd<KP(j1)
                i1=j1;
                break
            end
        end
        %kom�u kaynak se�ilmesi
        i2=unidrnd(sn);
        while(i1==i2)
            i2=unidrnd(sn);
        end
        %Kaynaktan rastgele bir pozisyon se�iyorum
        i3=unidrnd(d);
        %yeni bir pozisyon �retilmesi
        xy=X(i1,i3)+unifrnd(-1,1)*(X(i1,i3)-X(i2,i3)); %komsu kaynak ile mevcut kayna��n pozisyonlar� aras�ndaki fark
        
        Xnew=X(i1,:);
        Xnew(i3)=xy; %Xnew in 3. pozisyonu
        
        %Yeni kayna��n uygunluk de�eri
        newfit=f(Xnew);
        
        if newfit<fit(i1)
            X(i1,:)=Xnew;
            fit(i1)=newfit;
            fail(i1)=0;
        else
            fail(i1)=1+fail(i1);
        end
    end %g�zc� ar� i�lemleri for'u
    
    %En iyi kayna��n uygunluk de�erini haf�zaya al
    bestf_eski=bestf;
    j=find(fit==min(fit)); j=j(1);
    bestx=X(j,:); %en iyi kaynak haf�zaya al�nd�
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
    %ka�if ar� a�amas�
    
    %her bir kaynak i�in fail indeksleri kontrol edilir
    %e�er fail indeksleri limitlerin �zerine ��mm��sa alg durdurulur
    
    for j=1:sn
        if fail(j)>limit
            X(j,:)=unifrnd(-xmaps,xmaps,1,d);
            fail(j)=0;
        end
    end
    
    
end %iterasyon endi
end %fonksiyonun endi

    
    %[bestx,bestf,itn] = abcf(f,4,30,100,100,10^-4,3)
