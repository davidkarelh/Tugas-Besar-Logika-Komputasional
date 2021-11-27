:- dynamic((chicken/1, cow/1, sheep/1, pig/1, ostrich/1, tiger/1, mythical_duck/1, chickenLastTaken/1)).

% Asumsi hewan ternak hanya ada 3 jenis
% trueMap sama seperti pada farming gunanya
% Belum mengimplementasikan waktu dari hasil hewan ternak (perlu implementasi waktu)
% Belum mengimplementasikan exp
% Belum mengimplementasikan menyimpan hasil ternak ke inventori
% Belum implementasi jika inventori penuh apa yang terjadi
% Belum mengimplementasikan pembelian hewan ternak dari Marketplace

chicken(0).
cow(0).
sheep(0).
pig(0).
ostrich(0).
tiger(0).
mythical_duck(0).
chickenLastTaken(0).

elmt_in_true_matrix(X,Y,L) :-    
    trueMap(M),
    find_matrix(M,X,Y,L).


showChicken :-
    chicken(Chick),
    Chick > 0,
    write(Chick), write(' chicken\n').

showCow(Cow) :-
    cow(Cow),
    Cow > 0,
    write(Cow), write(' cow\n').

showSheep :-
    sheep(Sheep),
    Sheep > 0,
    write(Sheep), write(' sheep\n').

showPig :-
    pig(Pig),
    Pig > 0,
    write(Pig), write(' pig\n').

showOstrich :-
    ostrich(Ostrich),
    Ostrich > 0,
    write(Ostrich), write(' ostrich\n').

showTiger :-
    tiger(Tiger),
    Tiger > 0,
    write(Tiger), write(' tiger\n').

showMythicalDuck :-
    mythical_duck(MythicalDuck),
    MythicalDuck > 0,
    write(MythicalDuck), write(' mythical duck\n').

validasi_ranching :-
    scan_player(_, X, Y),
    ranch_position(XR, YR),
    X == XR,
    Y == YR.

showRanch(Day) :-
    chicken(Chick),
    cow(Cow),
    sheep(Sheep),
    pig(Pig),
    ostrich(Ostrich),
    tiger(Tiger),
    mythical_duck(MythicalDuck),
    (
        ((Chick + Cow + Sheep + Pig + Ostrich + Tiger + MythicalDuck) > 0)
            -> write('\nSelamat datang di Ranch! Kamu memiliki:\n'), showChicken, showCow, showSheep, showPig, showOstrich, showTiger, showMythicalDuck, write('\nApa yang mau kamu lakukan?\n'), chooseRanch(Day), !
            ; write('\nAnda tidak memiliki hewan ternak di Ranch. Silakan coba membeli hewan ternak di Marketplace.\n'), !, fail
    ).

ranch(Day) :-
    (
        validasi_ranching
        -> showRanch(Day), !
        ; write('Tile ini bukan Ranch. Silakan pergi ke Ranch untuk melakukan kegiatan ranch.\n'), !, fail
    ). 

chooseRanch(Day) :-
    read(Animal),
    (
        (
            Animal == 'chicken',
                chicken(Chick),
                (
                    (Chick > 0)
                    -> chickenEgg(Day)
                    ; write('Kamu tidak memiliki chicken pada ranch')
                ), !
        );
        (
            Animal == 'cow',
                cow(Cow),
                (
                    (Cow > 0)
                    -> cowMilk
                    ; write('Kamu tidak memiliki cow pada ranch')
                ), !
        );
        (
            Animal == 'sheep',
                sheep(Sheep),
                (
                    (Sheep > 0)
                    -> chickenEgg
                    ; write('Kamu tidak memiliki sheep pada ranch')
                ), !
        );
        (
            Animal == 'pig',
                pig([Pig]),
                (
                    (Pig > 0)
                    -> chickenEgg
                    ; write('Kamu tidak memiliki pig pada ranch')
                ), !
        );
        (
            Animal == 'ostrich',
                ostrich(Ostrich),
                (
                    (Ostrich > 0)
                    -> chickenEgg
                    ; write('Kamu tidak memiliki ostrich pada ranch')
                ), !
        );
        (
            Animal == 'tiger',
                tiger(Tiger),
                (
                    (Tiger > 0)
                    -> chickenEgg
                    ; write('Kamu tidak memiliki tiger pada ranch')
                ), !
        );
        (
            Animal == 'mythical_duck',
                mythical_duck(MythicalDuck),
                (
                    (MythicalDuck > 0)
                    -> chickenEgg
                    ; write('Kamu tidak memiliki mythical duck pada ranch')
                ), !
        )
    ).


chickenEgg(Day) :-
    chickenLastTaken(D),
    (
        (Day > D)
        ->
            chicken(Chick),
            generateRandom(N),
            (
                (N =< 25)
                -> write('Ayam kamu belum menghasilkan telur\n'), !
                ; (N =< 50)
                -> insertItem(30, Chick * 1), write('Ayam kamu menghasilkan '), write(Chick * 1), write(' telur.\n'), !
                ; (N =< 75)
                -> insertItem(30, Chick * 2), write('Ayam kamu menghasilkan '), write(Chick * 1), write(' telur.\n'), !
                ; insertItem(30, Chick * 3), write('Ayam kamu menghasilkan '), write(Chick * 1), write(' telur.\n'), !
            ),
            retract(chickenLastTaken(D)),
            asserta(chickenLastTaken(Day)), !
        ; write('Ayam kamu belum menghasilkan telur\n'), !
    ).

cowMilk :-
    cow(Cow),
    generateRandom(N),
    (
        (N =< 33)
        -> write('Ayam kamu belum menghasilkan telur\n'), !
        ; (N =< 67)
        -> insertItem(32, Cow * 1), write('Sapi kamu menghasilkan '), write(Chick * 1), write(' botol susu.\n'), !
        ; insertItem(32, Cow * 2), write('Sapi kamu menghasilkan '), write(Chick * 1), write(' botol susu.\n'), !
    ).