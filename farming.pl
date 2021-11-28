% :- include('map.pl').
% :- include('Inventory.pl').

:- dynamic((dataHarvest/5)).

dataHarvest(1, 3, 18, 2, 3).
dataHarvest(1, 2, 18, 2, 3).
dataHarvest(2, 2, 18, 2, 3).

% Jika galian, IDSeed = 0
% dataHarvest(X, Y, IDSeed, DayHarvest, HourHavest)

% carrot 1 Day
% potato 2 Day
% wheat 3 Day
% melon 4 Day
% pumpkin 5 Day
% beet_root 6 Day
% golden_apple 7 Day



% Belum lengkap sepenuhnya
% Perlu pengimplementasian jenis tanaman dan lambangnya pada map serta implementasinya pada inventori
% Perlu pengimplementasian waktu untuk implementasi kesiapan panen
% Exp juga belum diimplementasikan pada file ini
% Asumsi pemain masih bisa berjalan di atas area yang digali atau ditanam
% Belum mengimplementasikan menyimpan hasil panen ke inventori
% Belum implementasi jika inventori penuh apa yang terjadi


% trueMap sama seperti map biasa hanya saja simbol tile-nya bisa berubah karena dinamis, di sini digunakan untuk
% menyimpan simbol tile saat pemain sedang berada di tile tersebut

searchDataHarvest(X, Y, IDSeed, DayHarvest, HourHavest) :-
    (
        dataHarvest(X, Y, IDSeed, DayHarvest, HourHavest)
        -> !
        ; fail
    ).

validasi_lokasi_dig :- 
    scan_player(_,X,Y),
    (
        (quest_position(XQ, YQ), XQ == X, YQ == Y) 
        -> write('Anda tidak dapat melakukan penggalian di tile ini!\n'), !, fail
        ; (ranch_position(XR, YR), XR == X, YR == Y)
        -> write('Anda tidak dapat melakukan penggalian di tile ini!\n'), !, fail
        ; (house_position(XH, YH), XH == X, YH == Y)
        -> write('Anda tidak dapat melakukan penggalian di tile ini!\n'), !, fail
        ; (market_position(XM, YM),XM == X, YM == Y)
        -> write('Anda tidak dapat melakukan penggalian di tile ini!\n'), !, fail
        ; searchDataHarvest(X, Y, _, _, _)
        -> write('Anda tidak dapat melakukan penggalian di tile ini!\n'), !, fail
        ; !
    ).

validasi_shovel :-
    (
        searchEquipment(36, _, _)
        -> scan_player(_, X, Y), assertz(dataHarvest(X, Y, 0, 1, 1)), write('Anda berhasil menggali di tile ini!\n'), !
        ; write('Anda tidak mempunyai shovel untuk melakukan penggalian.\n'), !, fail
    ).

dig :-
    validasi_lokasi_dig,
    validasi_shovel. 
    
validasi_lokasi_plant :-
    scan_player(_,X,Y),
    (
        (searchDataHarvest(X, Y, ID, _, _), ID == 0) 
        -> !
        ; write('Anda tidak bisa menanam pada tile ini, jika tile ini bukan tile spesial, lakukan penggalian terlebih dahulu!\n'), !, fail
    ).

validasi_seed :-
    (
        searchItem(8, _, _)
        -> write('Kamu memiliki\n'), displaySeed, !
        ; searchItem(9, _, _)
        -> write('Kamu memiliki\n'), displaySeed, !
        ; searchItem(10, _, _)
        -> write('Kamu memiliki\n'), displaySeed, !
        ; searchItem(11, _, _)
        -> write('Kamu memiliki\n'), displaySeed, !
        ; searchItem(12, _, _)
        -> write('Kamu memiliki\n'), displaySeed, !
        ; searchItem(13, _, _)
        -> write('Kamu memiliki\n'), displaySeed, !
        ; searchItem(14, _, _)
        -> write('Kamu memiliki\n'), displaySeed, !
        ; write('Maaf, kamu tidak memiliki seed untuk ditanam!'), !, fail
    ).

plant(Day, Hour) :-
    validasi_lokasi_plant,
    validasi_seed,
    scan_player(_, X, Y),
    write('\nApa yang mau kamu tanam?\n'),
    read(Seed),
    (
        Seed == 'carrot',
            decreaseItem(8, 1), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 8, Day + 1, Hour)), write('Kamu menanam sebuah carrot seed!\n');
        Seed == 'potato',
            decreaseItem(9, 1), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 9, Day + 2, Hour)), write('Kamu menanam sebuah potato seed!\n');
        Seed == 'wheat',
            decreaseItem(10, 1), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 10, Day + 3, Hour)), write('Kamu menanam sebuah wheat seed!\n');
        Seed == 'melon',
            decreaseItem(11, 1), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 11, Day + 4, Hour)), write('Kamu menanam sebuah melon seed!\n');
        Seed == 'pumpkin',
            decreaseItem(12, 1), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 12, Day + 5, Hour)), write('Kamu menanam sebuah pumpkin seed!\n');
        Seed == 'beet_root',
            decreaseItem(13, 1), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 13, Day + 6, Hour)), write('Kamu menanam sebuah beet root seed seed!\n');
        Seed == 'golden_apple',
            decreaseItem(14, 1), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 14, Day + 7, Hour)), write('Kamu menanam sebuah golden apple seed seed!\n')
    ). 

validasi_harvest :-
    scan_player(_, X, Y),
    (
        (searchDataHarvest(X, Y, ID, _, _), ID \== 0)
        -> !
        ; fail
    ).

% Belum diimplementasikan (perlu pengimplementasian waktu terlebih dahulu, disimulasikan jika belum siap panen)
validasi_kesiapan_panen(Day, Hour, ID) :-
    scan_player(_, X, Y),
    searchDataHarvest(X, Y, ID, NDay, NHour),
    (NDay >= Day),
    (NHour >= Hour)
    .

harvest(Day, Hour) :-
    scan_player(_, X, Y),
    (
        validasi_harvest
        -> 
            (
                validasi_kesiapan_panen(Day, Hour, ID)
                -> 
                    (
                        (ID == 8)
                        -> write('Anda mendapat 2 carrot!\n'), insertItem(1, 2), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), !
                        ; (ID == 9)
                        -> write('Anda mendapat 3 potato!\n'), insertItem(2, 3), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), !
                        ; (ID == 10)
                        -> write('Anda mendapat 3 wheat!\n'), insertItem(3, 3), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), !
                        ; (ID == 11)
                        -> write('Anda mendapat 3 melon!\n'), insertItem(4, 3), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), !
                        ; (ID == 12)
                        -> write('Anda mendapat 3 pumpkin!\n'), insertItem(5, 3), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), !
                        ; (ID == 13)
                        -> write('Anda mendapat 2 beet root!\n'), insertItem(6, 2), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), !
                        ; write('Anda mendapat 1 golden apple!\n'), insertItem(7, 1), retract(dataHarvest(X, Y, _, _, _)), assertz(dataHarvest(X, Y, 0, 1, 1)), !
                    )
                ; write('Tanaman ini belum siap panen, datang lagi jika sudah siap yaa!\n'), !, fail
            )
        ; write('Tile ini tidak bisa dipanen.\n'), !, fail
    ).

tesf :-
    write('Start'),
    dataHarvest(X, Y, _, _, _),
    write(X), write(' '), write(Y).

kalibrasiMap :-
    scan_player(_, XP, YP), !,
    dataHarvest(X, Y, ID, _, _),
    X \== XP,
    Y \== YP,
    trueMap(Matrix),
    (
        (ID == 0)
        -> replace(Matrix, X, Y, '=', NMatrix), retract(trueMap(_)), asserta(trueMap(NMatrix))
        ;
        (ID == 8)
        -> replace(Matrix, X, Y, 'c', NMatrix), retract(trueMap(_)), asserta(trueMap(NMatrix))
        ;
        (ID == 9)
        -> replace(Matrix, X, Y, 'p', NMatrix), retract(trueMap(_)), asserta(trueMap(NMatrix))
        ;
        (ID == 10)
        -> replace(Matrix, X, Y, 'w', NMatrix), retract(trueMap(_)), asserta(trueMap(NMatrix))
        ;
        (ID == 11)
        -> replace(Matrix, X, Y, 'm', NMatrix), retract(trueMap(_)), asserta(trueMap(NMatrix))
        ;
        (ID == 12)
        -> replace(Matrix, X, Y, 'u', NMatrix), retract(trueMap(_)), asserta(trueMap(NMatrix))
        ;
        (ID == 13)
        -> replace(Matrix, X, Y, 'b', NMatrix), retract(trueMap(_)), asserta(trueMap(NMatrix))
        ;
        (ID == 14)
        -> replace(Matrix, X, Y, 'g', NMatrix), retract(trueMap(_)), asserta(trueMap(NMatrix))
    ).