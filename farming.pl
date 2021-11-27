% :- include('map.pl').
% :- include('Inventory.pl').

:- dynamic((trueMap/1, dataHarvest/1)).

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

initiate_true_map :-
    map_init(M),
    scan_player(_, X, Y),
    replace(M, X, Y, '-', MOut),
    asserta(trueMap(MOut)), !. 

true_map :-
    trueMap(M),
    print_matrix(M).

update_true_matrix(New) :-
    trueMap(M),
    retract(trueMap(M)),
    asserta(trueMap(New)).

elmt_in_true_matrix(X,Y,L) :-    
    trueMap(M),
    find_matrix(M,X,Y,L).

validasi_lokasi_dig :- 
    scan_player(_,X,Y),
    elmt_in_true_matrix(X, Y, P),
    (
        (P == 'M'; P == 'R'; P == 'H'; p == 'Q'; P == 'o'; P = ('=')) 
        -> !
        ; write('Anda tidak dapat melakukan penggalian di tile ini!'), !, fail
    ).

validasi_shovel :-
    (
        searchEquipment(36, _, _)
        -> scan_player(_, X, Y), trueMap(M), replace(M, X, Y, ('='), MOut), update_true_matrix(MOut), write('Anda berhasil menggali di tile ini!\n'), !
        ; write('Anda tidak mempunyai shovel untuk melakukan penggalian.\n'), !, fail
    ).

dig :-
    validasi_lokasi_dig,
    validasi_shovel. 
    
validasi_lokasi_plant :-
    scan_player(_,X,Y),
    elmt_in_true_matrix(X, Y, P),
    (
        (P == ('=')) 
        -> !
        ; write('Anda, tidak bisa menanam pada tile ini, jika tile ini bukan tile spesial, lakukan penggalian terlebih dahulu!'), !, fail
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
            decreaseItem(1, 1), assertz(dataHarvest(X, Y, Day + 1, Hour));
        Seed == 'potato',
            decreaseItem(2, 1);
        Seed == 'wheat',
            decreaseItem(3, 1);
        Seed == 'melon',
            decreaseItem(4, 1);
        Seed == 'pumpkin',
            decreaseItem(5, 1);
        Seed == 'beet_root',
            decreaseItem(6, 1);
        Seed == 'golden_apple',
            decreaseItem(7, 1)
    ). 

validasi_harvest(Out) :-
    scan_player(_, X, Y),
    elmt_in_true_matrix(X, Y, P),
    (
        (P == 'c')
        -> Out is 1, !
        ; Out is 0, !
    ).

% Belum diimplementasikan (perlu pengimplementasian waktu terlebih dahulu, disimulasikan jika belum siap panen)
validasi_kesiapan_panen(Out) :-
    Out is 0.

harvest :-
    scan_player(_, X, Y),
    validasi_harvest(V), 
    (
        (V =:= 1)
        -> validasi_kesiapan_panen(VP),
            (
                (P =:= 1)
                -> write('Anda memanen jagung.\n'), !
                ; write('Tanaman ini belum siap panen, datang lagi jika sudah siap yaa!\n'), !, fail
            )
        ; write('Tile ini tidak bisa dipanen.\n'), !, fail
    ).

tesf :-
    (
        searchEquipment(36, X, Y)
        -> write('success'), !
        ; write('fail'), !, fail
    ).