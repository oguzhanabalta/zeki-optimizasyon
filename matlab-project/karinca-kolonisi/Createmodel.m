function model = CreateModel(ss)
    x=unidrnd(100,[1,ss]);
    y=unidrnd(100,[1,ss]);

    %x = [89 81 92]
    %y = [12 30 32]

    n=length(x);
    D=zeros(n,n);

    for i=1:n-1
        for j =i+1:n
            D(i,j) = sqrt((x(i) - x(j))^2 + ((y(i) - y(j))^2));
            D(j,i) = D(i,j);
        end
    end

    model.n=n;
    model.x=x;
    model.y=y;
    model.D=D;
end