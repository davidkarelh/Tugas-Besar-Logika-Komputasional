:- dynamic((chicken/1, cow/1, sheep/1, pig/1, ostrich/1, tiger/1, mythical_duck/1, chickenLastTaken/1, cowLastTaken/1, sheepLastTaken/1, ostrichLastTaken/1, duckLastTaken/1)).

chicken(0).
cow(0).
sheep(0).
pig(0).
ostrich(0).
tiger(0).
mythical_duck(0).
chickenLastTaken(0).
cowLastTaken(0).
sheepLastTaken(0).
ostrichLastTaken(0).
duckLastTaken(0).

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

showRanch(Day, Lvranching) :-
    chicken(Chick),
    cow(Cow),
    sheep(Sheep),
    pig(Pig),
    ostrich(Ostrich),
    tiger(Tiger),
    mythical_duck(MythicalDuck),
    (
        ((Chick + Cow + Sheep + Pig + Ostrich + Tiger + MythicalDuck) > 0)
            -> write('\nSelamat datang di Ranch! Kamu memiliki:\n'), showChicken, showCow, showSheep, showPig, showOstrich, showTiger, showMythicalDuck, write('\nApa yang mau kamu lakukan?\n'), chooseRanch(Day, Lvranching), !
            ; write('\nAnda tidak memiliki hewan ternak di Ranch. Silakan coba membeli hewan ternak di Marketplace.\n'), !, fail
    ).

ranch(Day, Lvranching) :-
    (
        validasi_ranching
        -> showRanch(Day, Lvranching), !
        ; write('Tile ini bukan Ranch. Silakan pergi ke Ranch untuk melakukan kegiatan ranch.\n'), !, fail
    ). 

chooseRanch(Day, Lvranching) :-
    read(Animal),
    (
        (
            Animal == 'chicken',
                chicken(Chick),
                (
                    (Chick > 0)
                    -> chickenEgg(Day, Lvranching)
                    ; write('Kamu tidak memiliki chicken pada ranch')
                ), !
        );
        (
            Animal == 'cow',
                cow(Cow),
                (
                    (Cow > 0)
                    -> cowMilk(Day, Lvranching)
                    ; write('Kamu tidak memiliki cow pada ranch')
                ), !
        );
        (
            Animal == 'sheep',
                sheep(Sheep),
                (
                    (Sheep > 0)
                    -> woolSheep(Day, Lvranching)
                    ; write('Kamu tidak memiliki sheep pada ranch')
                ), !
        );
        (
            Animal == 'pig',
                pig(Pig),
                (
                    (Pig > 0)
                    -> pigMeat(Lvranching)
                    ; write('Kamu tidak memiliki pig pada ranch')
                ), !
        );
        (
            Animal == 'ostrich',
                ostrich(Ostrich),
                (
                    (Ostrich > 0)
                    -> ostrichFeather(Day, Lvranching)
                    ; write('Kamu tidak memiliki ostrich pada ranch')
                ), !
        );
        (
            Animal == 'tiger',
                tiger(Tiger),
                (
                    (Tiger > 0)
                    -> tigerSkin(Lvranching)
                    ; write('Kamu tidak memiliki tiger pada ranch')
                ), !
        );
        (
            Animal == 'mythical_duck',
                mythical_duck(MythicalDuck),
                (
                    (MythicalDuck > 0)
                    -> duckGoldenEgg(Day, Lvranching)
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
                -> insertItem(30, Chick * 1), write('Ayam kamu menghasilkan '), write(Chick * 1), write(' telur.\n'), retract(chickenLastTaken(D)), asserta(chickenLastTaken(Day)), !
                ; (N =< 75)
                -> insertItem(30, Chick * 2), write('Ayam kamu menghasilkan '), write(Chick * 1), write(' telur.\n'), retract(chickenLastTaken(D)), asserta(chickenLastTaken(Day)), !
                ; insertItem(30, Chick * 3), write('Ayam kamu menghasilkan '), write(Chick * 1), write(' telur.\n'), retract(chickenLastTaken(D)), asserta(chickenLastTaken(Day)), !
            )
        ; write('Ayam kamu belum menghasilkan telur\n'), !
    ).

cowMilk(Day) :-
    cowLastTaken(D),
    (
        (Day > D)
        ->
            cow(Cow),
            generateRandom(N),
            (
                (N =< 25)
                -> write('Sapi kamu belum menghasilkan susu\n'), !
                ; (N =< 50)
                -> insertItem(31, Cow * 1), write('Sapi kamu menghasilkan '), write(Cow * 1), write(' botol susu.\n'), retract(cowLastTaken(D)), asserta(cowLastTaken(Day)), !
                ; (N =< 75)
                -> insertItem(31, Cow * 2), write('Sapi kamu menghasilkan '), write(Cow * 1), write(' botol susu.\n'), retract(cowLastTaken(D)), asserta(cowLastTaken(Day)), !
                ; insertItem(31, Cow * 3), write('Sapi kamu menghasilkan '), write(Cow * 1), write(' botol susu.\n'), retract(cowLastTaken(D)), asserta(cowLastTaken(Day)), !
            )
        ; write('Sapi kamu belum menghasilkan susu\n'), !
    ).

woolSheep(Day) :-
    sheepLastTaken(D),
    (
        (Day > D + 1)
        ->
            sheep(Sheep),
            generateRandom(N),
            (
                (N =< 33)
                -> write('Domba kamu belum menghasilkan wool\n'), !
                ; (N =< 67)
                -> insertItem(32, Sheep * 1), write('Domba kamu menghasilkan '), write(Sheep * 1), write(' helai wool.\n'), retract(sheepLastTaken(D)), asserta(sheepLastTaken(Day)), !
                ; insertItem(32, Sheep * 2), write('Domba kamu menghasilkan '), write(Sheep * 2), write(' hwlai wool.\n'), retract(sheepLastTaken(D)), asserta(sheepLastTaken(Day)), !
            )
        ; write('Domba kamu belum menghasilkan wool\n'), !
    ).

pigMeat(Lvranching) :-
    pig(Pig),
    (
        searchEquipment(38, _, LvSamurai)
        ->  read(Jumlah),
                (
                    (Jumlah =< Pig)
                    -> Npig is Pig - Jumlah, retract(pig(Pig)), asserta(pig(Npig)), killPig(Lvranching, LvSamurai, Jumlah)
                    ; write('Jumlah yang dimasukkan melebihi jumlah pig pada ranch.\n')
                )

        ; write('Kamu tidak memiliki samurai untuk memotong hewan ternak.\n'), !
    ).

killPig(Lvranching, LvSamurai, Jumlah) :-
    (
        (Lvranching < 10)
        -> tier1PigKill(LvSamurai, Jumlah)
        ; (Lvranching < 20)
        -> tier2PigKill(LvSamurai, Jumlah)
        ; (Lvranching < 30)
        -> tier3PigKill(LvSamurai, Jumlah)
        ; tier4PigKill(LvSamurai, Jumlah)
    ).

tier1PigKill(LvSamurai, Jumlah) :-
    generateRandom(N),
    (
        (LvSamurai > 20)
        -> NN is ((LvSamurai - (mod(LvSamurai, 20))) / 2), !
        ; NN is 0, !
    ),
    (
        (N < (25 - NN))
        -> write('Yah, sepertinya babi-babi Anda tidak menghasilkan daging.\n')
        ; (N < 50)
        -> insertItem(29, Jumlah * 1), write('Wah, Anda mendapat '), write(Jumlah * 1), write(' daging!\n')
        ; (N < (75 - NN))
        -> insertItem(29, Jumlah * 2), write('Wah, Anda mendapat '), write(Jumlah * 2), write(' daging!\n')
        ; insertItem(29, Jumlah * 3), write('Wah, Anda mendapat '), write(Jumlah * 3), write(' daging!\n')
    ).

tier2PigKill(LvSamurai, Jumlah) :-
    generateRandom(N),
    (
        (LvSamurai > 20)
        -> NN is ((LvSamurai - (mod(LvSamurai, 20))) / 2), !
        ; NN is 0, !
    ),
    (
        (N < (25 - NN))
        -> insertItem(29, Jumlah * 1), write('Wah, Anda mendapat '), write(Jumlah * 1), write(' daging!\n')
        ; (N < 50)
        -> insertItem(29, Jumlah * 2), write('Wah, Anda mendapat '), write(Jumlah * 2), write(' daging!\n')
        ; (N < (75 - NN))
        -> insertItem(29, Jumlah * 3), write('Wah, Anda mendapat '), write(Jumlah * 3), write(' daging!\n')
        ; insertItem(29, Jumlah * 4), write('Wah, Anda mendapat '), write(Jumlah * 4), write(' daging!\n')
    ).

tier3PigKill(LvSamurai, Jumlah) :-
    generateRandom(N),
    (
        (LvSamurai > 20)
        -> NN is ((LvSamurai - (mod(LvSamurai, 20))) / 2), !
        ; NN is 0, !
    ),
    (
        (N < (25 - NN))
        -> insertItem(29, Jumlah * 2), write('Wah, Anda mendapat '), write(Jumlah * 2), write(' daging!\n')
        ; (N < 50)
        -> insertItem(29, Jumlah * 3), write('Wah, Anda mendapat '), write(Jumlah * 3), write(' daging!\n')
        ; (N < (75 - NN))
        -> insertItem(29, Jumlah * 4), write('Wah, Anda mendapat '), write(Jumlah * 4), write(' daging!\n')
        ; insertItem(29, Jumlah * 5), write('Wah, Anda mendapat '), write(Jumlah * 5), write(' daging!\n')
    ).

% Tier4 bisa mendapatkan 5 daging secara terus menerus jika level Samurai cukup tinggi dan ada chance 5% mendapat 6 daging
tier4PigKill(LvSamurai, Jumlah) :-
    generateRandom(N),
    (
        (LvSamurai > 20)
        -> NN is ((LvSamurai - (mod(LvSamurai, 20))) / 2), !
        ; NN is 0, !
    ),
    (
        (N < (25 - NN))
        -> insertItem(29, Jumlah * 2), write('Wah, Anda mendapat '), write(Jumlah * 2), write(' daging!\n')
        ; (N < (50 - NN))
        -> insertItem(29, Jumlah * 3), write('Wah, Anda mendapat '), write(Jumlah * 3), write(' daging!\n')
        ; (N < (75 - NN))
        -> insertItem(29, Jumlah * 4), write('Wah, Anda mendapat '), write(Jumlah * 4), write(' daging!\n')
        ; (N < 95)
        -> insertItem(29, Jumlah * 5), write('Wah, Anda mendapat '), write(Jumlah * 5), write(' daging!\n')
        ; insertItem(29, Jumlah * 6), write('Wah, Anda mendapat '), write(Jumlah * 6), write(' daging!\n')
    ).

% Maksimal 4 feather per ostrich
ostrichFeather(Day, Lvranching) :-
    ostrichLastTaken(D),
    (Day > D + 2)
    -> (
            ostrich(Ostrich),
            generateRandom(N),
            (Lvranching < 10)
            -> (
                    (N < 25)
                    -> write('Maaf, bulu ostrich Anda belum ada yang rontok'), !, fail
                    ; (N < 50)
                    -> insertItem(33, Ostrich), write('Wah, Anda mendapat '), write(Ostrich), write(' ostrich feather!\n'), retract(ostrichLastTaken(D)), asserta(ostrichLastTaken(Day)), !
                    ; (N < 50)
                    -> insertItem(33, Ostrich * 2), write('Wah, Anda mendapat '), write(Ostrich * 2), write(' ostrich feather!\n'), retract(ostrichLastTaken(D)), asserta(ostrichLastTaken(Day)), !
                    ; insertItem(33, Ostrich * 3), write('Wah, Anda mendapat '), write(Ostrich * 3), write(' ostrich feather!\n'), retract(ostrichLastTaken(D)), asserta(ostrichLastTaken(Day)), !
                )
            ; (Lvranching < 20)
            -> (
                    (N < 33)
                    -> insertItem(33, Ostrich), write('Wah, Anda mendapat '), write(Ostrich), write(' ostrich feather!\n'), retract(ostrichLastTaken(D)), asserta(ostrichLastTaken(Day)), !
                    ; (N < 67)
                    -> insertItem(33, Ostrich * 2), write('Wah, Anda mendapat '), write(Ostrich * 2), write(' ostrich feather!\n'), retract(ostrichLastTaken(D)), asserta(ostrichLastTaken(Day)), !
                    ; insertItem(33, Ostrich * 3), write('Wah, Anda mendapat '), write(Ostrich * 3), write(' ostrich feather!\n'), retract(ostrichLastTaken(D)), asserta(ostrichLastTaken(Day)), !
                )
            ; (Lvranching < 30)
            -> (
                    (N < 33)
                    -> insertItem(33, Ostrich * 2), write('Wah, Anda mendapat '), write(Ostrich * 2), write(' ostrich feather!\n'), retract(ostrichLastTaken(D)), asserta(ostrichLastTaken(Day)), !
                    ; (N < 67)
                    -> insertItem(33, Ostrich * 3), write('Wah, Anda mendapat '), write(Ostrich * 3), write(' ostrich feather!\n'), retract(ostrichLastTaken(D)), asserta(ostrichLastTaken(Day)), !
                    ; insertItem(33, Ostrich * 4), write('Wah, Anda mendapat '), write(Ostrich * 4), write(' ostrich feather!\n'), retract(ostrichLastTaken(D)), asserta(ostrichLastTaken(Day)), !
                )
            ;   (
                    (N < 50)
                    -> insertItem(33, Ostrich * 3), write('Wah, Anda mendapat '), write(Ostrich * 3), write(' ostrich feather!\n'), retract(ostrichLastTaken(D)), asserta(ostrichLastTaken(Day)), !
                    ; insertItem(33, Ostrich * 4), write('Wah, Anda mendapat '), write(Ostrich * 4), write(' ostrich feather!\n'), retract(ostrichLastTaken(D)), asserta(ostrichLastTaken(Day)), !
                )
        )
    ; write('Maaf, bulu ostrich Anda belum ada yang rontok'), !, fail.

tigerSkin(Lvranching) :-
    tiger(Tiger),
    (
        searchEquipment(38, _, LvSamurai)
        ->  read(Jumlah),
                (
                    (Jumlah =< Tiger)
                    -> Ntiger is Tiger - Jumlah, retract(tiger(Tiger)), asserta(tiger(Ntiger)), killTiger(Lvranching, LvSamurai, Jumlah)
                    ; write('Jumlah yang dimasukkan melebihi jumlah tiger pada ranch.\n')
                )
        ; write('Kamu tidak memiliki samurai untuk memotong hewan ternak.\n'), !
    ).

killTiger(Lvranching, LvSamurai, Jumlah) :-
    (
        (Lvranching < 20)
        -> tier1TigerKill(LvSamurai, Jumlah)
        ; tier2TigerKill(LvSamurai, Jumlah)
    ).

tier1TigerKill(LvSamurai, Jumlah) :-
    generateRandom(N),
    (
        (LvSamurai > 20)
        -> NN is ((LvSamurai - (mod(LvSamurai, 20))) / 2), !
        ; NN is 0, !
    ),
    (
        (N < (50 - NN))
        -> insertItem(34, Jumlah * 1), write('Wah, Anda mendapat '), write(Jumlah * 1), write(' tiger skin!\n')
        ; insertItem(34, Jumlah * 2), write('Wah, Anda mendapat '), write(Jumlah * 2), write(' tiger skin!\n')
    ),
    generateRandom(N2),
    (
        (N2 < 33)
        -> !
        ; (N2 < 67)
        -> insertItem(29, Jumlah), write('Anda juga mendapat '), write(Jumlah), write(' daging.\n')
        ; insertItem(29, Jumlah * 2), write('Anda juga mendapat '), write(Jumlah * 2), write(' daging.\n')
    ).

tier2TigerKill(LvSamurai, Jumlah) :-
    generateRandom(N),
    (
        (LvSamurai > 20)
        -> NN is ((LvSamurai - (mod(LvSamurai, 20))) / 2), !
        ; NN is 0, !
    ),
    (
        (N < (50 - NN))
        -> insertItem(34, Jumlah * 2), write('Wah, Anda mendapat '), write(Jumlah * 2), write(' tiger skin!\n')
        ; insertItem(34, Jumlah * 3), write('Wah, Anda mendapat '), write(Jumlah * 3), write(' tiger skin!\n')
    ),
    generateRandom(N2),
    (
        (N2 < 33)
        -> insertItem(29, Jumlah), write('Anda juga mendapat '), write(Jumlah), write(' daging.\n')
        ; (N2 < 67)
        -> insertItem(29, Jumlah * 2), write('Anda juga mendapat '), write(Jumlah * 2), write(' daging.\n')
        ; insertItem(29, Jumlah * 3), write('Anda juga mendapat '), write(Jumlah * 3), write(' daging.\n')
    ).

duckGoldenEgg(Day, Lvranching) :-
    duckLastTaken(D),
    (Day > D + 3)
    -> (
        (Lvranching < 20)
        -> insertItem(35, 1), write('Wah, Anda mendapat 1 golden egg!\n'), insertItem(29, 3), write('Anda juga mendapat 3 daging.\n')
        ; insertItem(35, 1), write('Wah, Anda mendapat 1 golden egg!\n'), insertItem(29, 4), write('Anda juga mendapat 4 daging.\n')
    ).