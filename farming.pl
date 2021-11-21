:- include('map.pl').
:- include('Inventory.pl').

:- dynamic((trueMap/1)).

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

validasi_dig(Out) :- 
    scan_player(_,X,Y),
    elmt_in_true_matrix(X, Y, P),
    (
        (P == 'M'; P == 'R'; P == 'H'; p == 'Q'; P == 'o'; P = ('=')) 
        -> Out is 0, !
        ; Out is 1, !
    ).

dig :-
    scan_player(_, X, Y),
    validasi_dig(V),
    (
        (V =:= 1)
        -> trueMap(M), replace(M, X, Y, ('='), MOut), update_true_matrix(MOut), write('Anda berhasil menggali di tile ini!\n'), !
        ; write('Anda tidak bisa melakukan penggalian di tile ini!\n'), !, fail
    ). 
    
    
validasi_plant(Out) :-
    scan_player(_,X,Y),
    elmt_in_true_matrix(X, Y, P),
    (
        (P == ('=')) 
        -> Out is 1, !
        ; Out is 0, !
    ).
    
plant :-
    scan_player(_, X, Y),
    validasi_plant(V),
    (
        (V =:= 1)
        -> inventory_list(L), totalItem(S, Total),
            (
                (Total =:= 0)
                -> write('Maaf, Inventori Anda kosong, silakan mengisi inventori Anda dengan tanaman panen terlebih dahulu.\n'), !, fail
                % Disimulasikan jagung memiliki simbol 'c' pada map
                ; trueMap(M), replace(M, X, Y, ('c'), MOut), update_true_matrix(MOut), write('Anda menanam jagung tile ini!\n'), !
            )
        ; write('Anda, tidak bisa menanam pada tile ini, lakukan penggalian terlebih dahulu!'), !, fail
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