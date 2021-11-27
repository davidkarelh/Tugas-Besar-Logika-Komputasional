:- include('map.pl').
:- include('Inventory.pl').

:- dynamic((chicken/1, cow/1, sheep/1, pig/1, ostrich/1, tiger/1, mythical_duck/1, trueMap/1)).

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

validasi_ranching(Out) :-
    scan_player(_, X, Y),
    elmt_in_true_matrix(X, Y, P),
    (
        (P == 'R')
        -> Out is 1, !
        ; Out is 0, !
    ).

showChicken :-
    chicken(Chick),
    Chick > 0,
    write(Chick), write(' chicken\n').

showSheep :-
    sheep(Sheep),
    Sheep > 0,
    write(Sheep), write(' sheep\n').

showCow(Cow) :-
    cow(Cow),
    Cow > 0,
    write(Cow), write(' cow\n').

showRanch :-
    chicken(Chick),
    sheep(Sheep),
    cow(Cow),
    (
        ((Chick + Sheep + Cow) > 0)
        -> write('\nSelamat datang di Ranch! Kamu memiliki:\n'), showChicken, showSheep, showCow, write('\nApa yang mau kamu lakukan?\n'), !
        ; write('\nAnda tidak memiliki hewan ternak di Ranch. Silakan coba membeli hewan ternak di Marketplace.\n'), !, fail
    ).

ranch :-
    validasi_ranching(V),
    (
        (V =:= 1)
        -> showRanch, !
        ; write('Tile ini bukan Ranch. Silakan pergi ke Ranch untuk melakukan kegiatan ranch.\n'), !, fail
    ). 

chicken :-
    validasi_ranching(V),
    (
        (V =:= 1)
        -> 
            chicken(Chick),
            (
                (Chick > 0)
                -> 
                    % Simulasi ayam menghasilkan 2 telur
                    write('Ayam-ayam Anda menghasilkan 2 telur.\n'),
                    write('Anda mendapat 2 telur!\n'),
                    write('Anda mendapat 6 ranching exp!\n'), !
                ;
                    write('Tidak ada ayam pada Ranch.\n'), !, fail
            )
            
        ; write('Anda tidak bisa mengambil hasil ternak selain di Ranch.\n'), !, fail
    ).

sheep :-
    validasi_ranching(V),
    (
        (V =:= 1)
        -> 
            sheep(Sheep),
            (
                (Sheep > 0)
                -> 
                    % Simulasi domba belum menghasilkan wool
                    write('Domba Anda belum menghasilkan wool.\n'),
                    write('Silakan cek lagi nanti.\n'), !
                ;
                    write('Tidak ada domba pada Ranch.\n'), !, fail
            )
            
        ; write('Anda tidak bisa mengambil hasil ternak selain di Ranch.\n'), !, fail
    ).

cow :-
    validasi_ranching(V),
    (
        (V =:= 1)
        -> 
            cow(Cow),
            (
                (Cow > 0)
                -> 
                    % Simulasi sapi belum menghasilkan susu
                    write('Sapi Anda belum menghasilkan susu.\n'),
                    write('Silakan cek lagi nanti.\n'), !
                ;
                    write('Tidak ada sapi pada Ranch.\n'), !, fail
            )
            
        ; write('Anda tidak bisa mengambil hasil ternak selain di Ranch.\n'), !, fail
    ).
