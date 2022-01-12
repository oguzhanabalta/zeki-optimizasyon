function [ ] = yolCiz( cozum )
    hold off;
    drawnow();
    load konumlar;
    for i=1:size(cozum,2)
        plot(konumlar(i,1), konumlar(i,2),'o');
        text(konumlar(i,1), konumlar(i,2)+2, int2str(i), 'Fontsize', 9);
        hold on;
    end
    for i=1:size(cozum,2)-1
        plot([konumlar(cozum(i),1),konumlar(cozum(i+1),1)],[konumlar(cozum(i),2),konumlar(cozum(i+1),2)]);
    end
    plot([konumlar(cozum(end),1),konumlar(cozum(1),1)],[konumlar(cozum(end),2),konumlar(cozum(2),2)]);
    

    
end

