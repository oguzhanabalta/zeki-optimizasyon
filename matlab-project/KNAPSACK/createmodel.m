function model = createmodel()

n=50;
w=[752 825 201 831 606 178 323 538 866 872 226 877 866 488 741 213 437 833 734 ... 
    868 625 128 780 848 643 706 695 414 625 237 665 125 321 136 177 759 656 353 ... 
    861 127 451 405 713 736 249 492 456 617 668 704];
v=[32 65 63 23 19 50 87 37 57 28 70 30 50 66 82 87 54 21 22 30 78 30 75 29 85 ... 
    38 25 30 59 48 38 77 57 54 84 33 71 71 40 55 16 14 52 73 85 20 56 48 10 37];

W=15000; 
model.n=n;
model.v=v;
model.w=w;
model.W=W;

end