function [uzaklik] = sehirEkle( sehirSayisi )
   konumX = round(rand([1,sehirSayisi]).*100); %.* elementer çarpým.
   konumY = round(rand([1,sehirSayisi]).*100);
   
   konumlar = [konumX;konumY]';
   save('konumlar','konumlar');
   
   for i=1:sehirSayisi
       for j=1:sehirSayisi
           if(i==j)
               uzaklik(i,j)=0;
           else
               uzaklik(i,j)= sqrt((konumX(i)-konumX(j))^2 + (konumY(i)-konumY(j))^2);
       end
   end
end

