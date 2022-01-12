function [ toplam ] = mesafeHesapla(cozum,uzaklik)
    yolCiz(cozum);
    toplam=0;
    for i=1:size(cozum,2)-1
        toplam=toplam+uzaklik(cozum(i), cozum(i+1));
    end
    toplam=toplam+uzaklik(cozum(end),cozum(1));


end

