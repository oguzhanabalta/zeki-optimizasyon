function [kiz erkek] = singlepointcrossover(anne,baba)

%Her kromozomda kaç gen var bulmalýyýz.

n=numel(anne);

%Kesme noktasýný rastgele seçmeliyiz. randi komutu ile

cutpoint=randi([1 n-1]);

%tek noktalý çaprazlama
kiz=[anne(1:cutpoint) baba(cutpoint+1:end)];
erkek=[baba(1:cutpoint) anne(cutpoint+1:end)];
end