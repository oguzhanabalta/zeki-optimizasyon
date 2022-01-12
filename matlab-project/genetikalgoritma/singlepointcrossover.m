function [kiz erkek] = singlepointcrossover(anne,baba)

%Her kromozomda ka� gen var bulmal�y�z.

n=numel(anne);

%Kesme noktas�n� rastgele se�meliyiz. randi komutu ile

cutpoint=randi([1 n-1]);

%tek noktal� �aprazlama
kiz=[anne(1:cutpoint) baba(cutpoint+1:end)];
erkek=[baba(1:cutpoint) anne(cutpoint+1:end)];
end