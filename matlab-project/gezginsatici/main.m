%Gezgin Satıcı Yöntemi - ---- - Tavlama Benzetimi

fprintf('Gezgin Satıcı Problemi......\n');
sehirSayisi=input('Sehir sayisini giriniz:');

%display(sehirSayisi)

uzaklik=sehirEkle(sehirSayisi);
cozum=randperm(sehirSayisi);
obj=mesafeHesapla(cozum,uzaklik);

iterasyon = 1;
objit = obj;
cozumeniyi=cozum;
objeniyi=obj;

%Tavlama Benzetimi Parametleri
T= 100;
Tend= 0.1;
sk=0.95;
%-----------------------------


while(T>Tend)
    degis(1) = 0;
    degis(2) = 0;
    while(degis(1) == degis(2))
        degis= unidrnd(sehirSayisi, [1,2]);
    end
    komsu=cozum;
    takas=komsu(degis(1));
    komsu(degis(1)) = komsu(degis(2));
    komsu(degis(2)) = takas;
    komsu;
    
    obj_komsu = mesafeHesapla(komsu,uzaklik);
    
    if(obj_komsu <= obj)
        cozum = komsu;
        obj = obj_komsu;
    else
        de = obj_komsu - obj;
        pa = exp(-de/T);
        rs = unifrnd(0,1);
        
        if(rs<pa)
            cozum= komsu;
            obj = obj_komsu;
        end
    end
    
    T=T*sk;
    
    iterasyon = iterasyon +1;
    if(obj<min(objit))
        objit(iterasyon) = obj;
    else
        objit(iterasyon) = objit (iterasyon-1);
    end
    
    if(objit(iterasyon)<objeniyi)
        cozumeniyi = cozum;
        objeniyi = obj;
    end
end

cozumeniyi
obj